// app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/data/models/excursion_model.dart';
import 'package:test_task/data/repositories/cars_repository.dart';
import 'package:test_task/data/repositories/motorcycle_repository.dart';
import 'package:test_task/data/repositories/vespa_repository.dart';
import 'package:test_task/presentation/apartment_detail_screen.dart';
import 'package:test_task/presentation/apartments_list_screen.dart';
import 'package:test_task/presentation/bookmarks.dart';
import 'package:test_task/presentation/chat_screen.dart';
import 'package:test_task/presentation/circular_menu_screen.dart';
import 'package:test_task/presentation/excursion_detail_screen.dart';
import 'package:test_task/presentation/excursions_list.dart';
import 'package:test_task/presentation/main_menu_screen.dart';
import 'package:test_task/presentation/profile_screen.dart';
import 'package:test_task/presentation/splash_screen.dart';
import 'package:test_task/presentation/vehicle_details_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainMenuScreen(),
        routes: [
          GoRoute(
            path: 'main-menu',
            builder: (context, state) => const CircularMenuScreen(),
            routes: [
              // Apartments List
              GoRoute(
                path: 'apartments-list',
                builder: (context, state) => ApartmentsListScreen(),
                routes: [
                  // Apartment Detail
                  GoRoute(
                    path: 'apartment-detail',
                    builder: (context, state) {
                      final apartment = state.extra as Apartment;
                      return ApartmentDetailScreen(apartment: apartment);
                    },
                  ),
                ],
              ),

              GoRoute(
                path: 'vehicle-details-cars',
                builder:
                    (context, state) => VehicleDetailsScreen(
                      vehicleRepository: CarsRepository(),
                      label: "automobiles",
                    ),
              ),
              GoRoute(
                path: 'vehicle-details-motorcycles',
                builder:
                    (context, state) => VehicleDetailsScreen(
                      vehicleRepository: MotorcycleRepository(),
                      label: "motorcycles",
                    ),
              ),
              GoRoute(
                path: 'vehicle-details-vespa',
                builder:
                    (context, state) => VehicleDetailsScreen(
                      vehicleRepository: VespaRepository(),
                      label: "vespa bikes",
                    ),
              ),
              GoRoute(
                path: 'excursions-list',
                builder: (context, state) => ExcursionsList(),
                routes: [
                  GoRoute(
                    path: 'excursion-detail',
                    builder: (context, state) {
                      final excursion = state.extra as Excursion;
                      return ExcursionDetailScreen(excursion: excursion);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Bookmarks
      GoRoute(
        path: '/bookmarks',
        builder: (context, state) => BookmarksScreen(),
      ),
      GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
      GoRoute(path: '/chat', builder: (context, state) => ChatScreen()),
    ],

    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Ошибка')),
          body: const Center(child: Text('Не удалось загрузить страницу')),
        ),
  );

  static List<String> getAllRoutes() {
    return [
      '/home/main-menu/apartments-list',
      '/home/main-menu/vehicle-details-cars',
      '/home/main-menu/vehicle-details-motorcycles',
      '/home/main-menu/vehicle-details-motorcycles',
      '/home/main-menu/vehicle-details-vespa',
      '/home/main-menu/excursions-list',
    ];
  }
}
