import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/presentation/main_menu_screen.dart';
import 'package:test_task/presentation/profile_screen.dart';
import 'package:test_task/presentation/splash_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
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
        targetScreen = SplashScreen();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(227, 228, 233, 0.6),
                  spreadRadius: context.adaptiveSize(5),
                  blurRadius: context.adaptiveSize(100),
                  offset: Offset(0, context.adaptiveSize(-10)),
                ),
              ],
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.orange, // Изменение цвета при выборе
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedPageIndex,
              showSelectedLabels: false, // Убираем лейблы
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed, // Фиксированный тип
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: ''),
                BottomNavigationBarItem(icon: Icon(null), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: '',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(227, 228, 233, 0.6),
                spreadRadius: context.adaptiveSize(5),
                blurRadius: context.adaptiveSize(100),
                offset: Offset(0, context.adaptiveSize(-10)),
              ),
            ],
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(Icons.search, color: Colors.white),
                onPressed:
                    () => setState(() {
                      _selectedPageIndex = 2;
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
