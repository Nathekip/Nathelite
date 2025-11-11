import 'package:flutter/material.dart';
import 'package:nathelite/data/models/launch.model.dart';
import 'package:nathelite/ui/data/api/launch.service.dart';
import 'package:nathelite/ui/widgets/launch_list_card.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Launch>>(
          future: LaunchService.getLaunches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              String snapErr = snapshot.error.toString();
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
            return ListView(
              children: launches.map((launch) => LaunchListCard(launch: launch)).toList(),
            );
          }),
    );
  }
}