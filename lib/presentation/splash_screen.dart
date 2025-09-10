import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/presentation/main_menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _subTextAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _logoAnimation;
  final Color _blueLight = BaseColors.secondary;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });
    _backgroundAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, 0.5, curve: Curves.linear),
    );

    _subTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 0.9, curve: Curves.easeIn),
      ),
    );
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.55, 0.8, curve: Curves.easeIn),
      ),
    );
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.45, 0.7)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => MainMenuScreen(),
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
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: _LightPainter(
                    radius:
                        MediaQuery.of(context).size.height *
                        _backgroundAnimation.value,
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
                            opacity: _textAnimation,
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
                                    color: BaseColors.accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _logoAnimation,
                            child: SvgPicture.asset(
                              'assets/file/Logo.svg',
                              height: 50,
                            ),
                          ),
                          FadeTransition(
                            opacity: _textAnimation,
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
                                    color: BaseColors.accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FadeTransition(
                        opacity: _subTextAnimation,
                        child: Text(
                          'tourists assistance',
                          style: TextStyle(
                            fontFamily: 'San Francisco Pro Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
