// lib/auth_guard.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/auth_cubit.dart';

import 'core/constants/base_colors.dart';

/// Глобальный AuthCubit для использования в роутере
/// Инициализируется в main.dart
late AuthCubit authCubit;

/// Обёртка для защищённых маршрутов
class AuthGuard extends StatelessWidget {
  final Widget child;
  final String redirectTo;

  const AuthGuard({
    super.key,
    required this.child,
    this.redirectTo = '/sign-up',
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          return child;
        }

        // Не авторизован - перенаправляем
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(redirectTo);
        });

        return Scaffold(
          backgroundColor: BaseColors.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Redirecting to login...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Redirect функция для GoRouter
String? authRedirect(BuildContext context, GoRouterState state) {
  final authState = authCubit.state;
  final location = state.matchedLocation;

  // Публичные пути (не требуют авторизации)
  final publicPaths = ['/', '/home', '/sign-up', '/login', '/bookmarks'];

  // Пути, начинающиеся с этих префиксов - публичные
  final publicPrefixes = [
    '/home/main-menu/apartments',
    '/home/main-menu/vehicle',
    '/home/main-menu/excursions',
  ];

  // Проверяем публичные пути
  final isPublicPath =
      publicPaths.contains(location) ||
      publicPrefixes.any((prefix) => location.startsWith(prefix));

  // Защищённые пути
  final protectedPaths = ['/profile', '/chat'];

  final isProtectedPath = protectedPaths.any(
    (path) => location.startsWith(path),
  );

  // Если путь защищённый и пользователь не авторизован
  if (isProtectedPath && authState is! AuthAuthenticated) {
    return '/sign-up?redirect=${Uri.encodeComponent(location)}';
  }

  // Если пользователь авторизован и пытается зайти на страницу логина
  if (authState is AuthAuthenticated && location == '/sign-up') {
    return '/profile';
  }

  return null;
}
