import 'package:flutter/material.dart';
import 'package:nathelite/data/models/launch.model.dart';
import 'package:nathelite/ui/data/api/launch.service.dart';
import 'package:nathelite/ui/widgets/launch_list_card.widget.dart';
import 'package:nathelite/ui/widgets/launch_grid_card.widget.dart';
import 'package:nathelite/ui/widgets/onboarding.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGridView = true;
  bool _showOnboarding = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final isCompleted = await LaunchService.isOnboardingCompleted();
    setState(() {
      _showOnboarding = !isCompleted;
      _isLoading = false;
    });
  }

  Future<void> _completeOnboarding() async {
    await LaunchService.completeOnboarding();
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_showOnboarding) {
      return OnboardingWidget(onComplete: _completeOnboarding);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("SpaceX Launches"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: _isGridView ? "Afficher en liste" : "Afficher en grille",
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Launch>>(
        future: LaunchService.getLaunches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final snapErr = snapshot.error.toString();
            return Center(
              child: Text(
                "Data error : $snapErr",
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          final launches = snapshot.data ?? [];
          if (launches.isEmpty) {
            return const Center(child: Text("No data"));
          }

          if (_isGridView) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: launches.length,
              itemBuilder: (context, index) =>
                  LaunchGridCard(launch: launches[index]),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: launches.length,
            itemBuilder: (context, index) =>
                LaunchListCard(launch: launches[index]),
          );
        },
      ),
    );
  }
}