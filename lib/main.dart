import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/cubits/bookmarks_cubit.dart';
import 'package:test_task/core/routing/app_routes.dart';
import 'package:test_task/core/theme/app_theme.dart';
import 'package:test_task/bloc/cubits/apartments_cubit.dart';
import 'package:test_task/bloc/cubits/chat_cubit.dart';
import 'package:test_task/bloc/cubits/vehicle_cubit.dart';
import 'package:test_task/bloc/cubits/excursion_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // DevicePreview(
    //enabled: true,
    //  tools: const [...DevicePreview.defaultTools],
    //  builder: (context) =>
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ApartmentCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => ExcursionCubit()),
        BlocProvider(create: (context) => VehicleCubit()),
        BlocProvider(create: (context) => BookmarksCubit()),
      ],
      child: const MyApp(),
    ),

    //),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Test Task App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
