import 'package:flutter/material.dart';
import 'package:nathelite/ui/pages/home.page.dart';
import 'package:nathelite/ui/data/api/launch.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "Nathellite",
    home: HomePage(),
  );
}
