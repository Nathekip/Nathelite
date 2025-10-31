import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nathelite/data/models/launch.model.dart';
import 'package:nathelite/ui/widgets/launch_list_card.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Launch> launches = Launch.mocks();

    return Scaffold(
      body : ListView(
        children: launches.map((launch) => LaunchListCard(launch: launch)).toList(),
      ),
    );
  }
}