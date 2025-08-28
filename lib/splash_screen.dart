import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lightSpread;
  late Animation<double> _subtitleFade;
  late Animation<double> _subtitleFade1;
  late Animation<double> _subtitleFade2;
  final Color _blueLight = Color.fromARGB(255, 85, 97, 178);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });

    // Корректируем интервалы
    _lightSpread = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeIn), // Было 1.8-2.0
      ),
    );

    _subtitleFade1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.7, curve: Curves.easeIn), // Было 1.0-1.8
      ),
    );

    _subtitleFade2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          0.4,
          curve: Curves.easeIn,
        ), // Оставлено без изменений
      ),
    );

    _controller.forward();
  }

  // 2. Модифицированный метод перехода с анимацией
  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (_, __, ___) => MainMenu(),
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
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Blue light spread effect
                CustomPaint(
                  painter: _LightPainter(
                    radius:
                        MediaQuery.of(context).size.height * _lightSpread.value,
                    color: _blueLight,
                  ),
                  size: Size.infinite,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          FadeTransition(
                            opacity: _subtitleFade1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: Baseline(
                                baseline: 36 * 1.35,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  'trpani',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontFamily: 'Berlin Sans FB',
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 127, 80),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _subtitleFade2,
                            child: SvgPicture.asset(
                              'assets/file/Logo.svg',
                              height: 50,
                            ),
                          ),
                          FadeTransition(
                            opacity: _subtitleFade1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Baseline(
                                baseline: 36 * 0.8,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  'viaggio',
                                  style: TextStyle(
                                    fontFamily: 'Berlin Sans FB',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 127, 80),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FadeTransition(
                        opacity: _subtitleFade,
                        child: Text(
                          'tourists assistance',
                          style: TextStyle(
                            fontFamily: 'San Francisco Pro Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LightPainter extends CustomPainter {
  final double radius;
  final Color color;

  _LightPainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant _LightPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
