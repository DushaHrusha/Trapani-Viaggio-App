import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:test_task/presentation/bookmarks.dart';
import 'package:test_task/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookmarksProvider()),
      ],
      child: // DevicePreview(
          //enabled: true,
          //  tools: const [...DevicePreview.defaultTools],
          //  builder: (context) =>
          const MyApp(),
      //),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Inter'),
          bodyLarge: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SplashScreen()),
    );
  }
}
