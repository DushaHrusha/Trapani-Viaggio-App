import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:test_task/excursions_list.dart';

void main() {
  // убрать это
  //ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ExcursionsList()),
    );
  }
}
