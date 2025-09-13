import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/presentation/bookmarks.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/presentation/main_menu_screen.dart';
import 'package:test_task/presentation/profile_screen.dart';
import 'package:test_task/presentation/splash_screen.dart';

class BottomBar extends StatefulWidget {
  final Widget currentScreen;

  const BottomBar({super.key, required this.currentScreen});

  @override
  createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.adaptiveSize(64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.adaptiveSize(20)),
          topRight: Radius.circular(context.adaptiveSize(20)),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(190, 190, 190, 0.3),
            spreadRadius: context.adaptiveSize(5),
            blurRadius: context.adaptiveSize(100),
            offset: Offset(0, context.adaptiveSize(-10)),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.adaptiveSize(32)),
          topRight: Radius.circular(context.adaptiveSize(32)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 251, 251, 253),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          iconSize: context.adaptiveSize(24),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            _buildNavItem(
              'assets/file/home.svg',
              ProfileScreen(),
              widget.currentScreen is MainMenuScreen,
            ),
            _buildNavItem(
              'assets/file/map.svg',
              ProfileScreen(),
              widget.currentScreen is SplashScreen,
            ),
            _buildNavItem(
              'assets/file/bookmark.svg',
              ProfileScreen(),
              widget.currentScreen is BookmarksPage,
            ),
            _buildNavItem(
              'assets/file/user.svg',
              ProfileScreen(),
              widget.currentScreen is ProfileScreen,
            ),
          ],
          onTap: (index) {
            _navigateToScreen(index);
          },
        ),
      ),
    );
  }

  void _navigateToScreen(int index) {
    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = MainMenuScreen();
        break;
      case 1:
        targetScreen = SplashScreen();
        break;
      case 2:
        targetScreen = BookmarksPage();
        break;
      case 3:
        targetScreen = ProfileScreen();
        break;
      default:
        targetScreen = SplashScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 1.0,
                end: 0.0,
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String icon,
    Widget path,
    bool isActive,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: context.adaptiveSize(0)), //20
        child: SvgPicture.asset(
          icon,
          width: context.adaptiveSize(24),
          height: context.adaptiveSize(24),
          color: isActive ? BaseColors.accent : null,
        ),
      ),
      label: '',
    );
  }
}
