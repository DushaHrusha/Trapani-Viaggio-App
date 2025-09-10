import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/presentation/apartmens_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/presentation/car_catalog.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/presentation/excursions_list.dart';
import 'package:test_task/presentation/profile_screen.dart';

class CircularMenuScreen extends StatefulWidget {
  const CircularMenuScreen({super.key});

  @override
  _CircularMenuScreenState createState() => _CircularMenuScreenState();
}

class _CircularMenuScreenState extends State<CircularMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late final List<Widget> _cachedPages;
  final List<StatefulWidget> _pages = [
    ApartmensScreen(),
    CarDetailsScreen(),
    CarDetailsScreen(),
    CarDetailsScreen(),
    CarDetailsScreen(),
    ExcursionsList(),
  ];

  final List<String> _labels = [
    'Apartment',
    'Auto',
    'Moto',
    'Bicycle',
    'Vespa',
    'Excursion',
    'What are you looking for?',
  ];
  final List<String> _svgIcons = [
    'assets/file/keys.svg',
    'assets/file/auto.svg',
    'assets/file/Moto.svg',
    'assets/file/Bicycle.svg',
    'assets/file/Vespa.svg',
    'assets/file/Excursion.svg',
  ];
  late AnimationController _stageController;
  late AnimationController _appBarController;
  late AnimationController _searchController;
  late AnimationController _circlesController;
  late AnimationController _bottomBarController;
  late AnimationController _animationTextController;
  late AnimationController _centerCirclesController;

  @override
  void initState() {
    super.initState();

    _cachedPages = _pages.map((page) => page).toList();

    _centerCirclesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    ); // Общий контроллер этапов
    _stageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _circlesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 20),
    );

    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward().then((_) {
            _searchController.forward().then((_) {
              _circlesController.forward().then((_) {
                _controller.forward();
                _bottomBarController.forward();
                _animationTextController.forward();
                _centerCirclesController.forward();
              });
            });
          });
        });
      }
    });

    _stageController.forward();
  }

  @override
  void dispose() {
    _stageController.dispose();
    _appBarController.dispose();
    _searchController.dispose();
    _circlesController.dispose();
    _bottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _appBarController,
              builder: (context, child) {
                return Opacity(
                  opacity: _appBarController.value,
                  child: const CustomAppBar(label: "trapani viaggio"),
                );
              },
            ),
            AnimatedBuilder(
              animation: _searchController,
              builder: (context, child) {
                return Opacity(
                  opacity: _searchController.value,
                  child: Divider(
                    thickness: 1,
                    color: BaseColors.line,
                    height: 0,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _searchController,
              builder: (context, child) {
                return Opacity(
                  opacity: _searchController.value,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48.0,
                      left: 30,
                      right: 28,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: BaseColors.background,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: BaseColors.primary,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 28, right: 6),
                            child: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  "assets/file/search.svg",
                                  color: BaseColors.primary,
                                ),
                              ),
                            ),
                          ),
                          hintText: 'What do you want to find in Trapani?',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            height: 1.0,
                            fontFamily: 'San Francisco Pro Display',
                            color: BaseColors.primary,
                            fontStyle: FontStyle.italic,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 0,
                          ),
                          isDense: true,
                          isCollapsed: true,
                        ),
                        style: TextStyle(fontSize: 14, height: 1.0),
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: context.adaptiveSize(
                MediaQuery.of(context).size.shortestSide * 0.25 * 4,
              ),
              height: context.adaptiveSize(
                MediaQuery.of(context).size.shortestSide * 0.25 * 5,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Stack(
                  children: List.generate(7, (index) {
                    final shortestSide =
                        MediaQuery.of(context).size.shortestSide;
                    final size = context.adaptiveSize(shortestSide * 0.25);
                    final center = Offset(
                      context.adaptiveSize(size * 2),
                      context.adaptiveSize(size * 2),
                    );
                    final radius = context.adaptiveSize(size * 1.1);

                    final angle =
                        index == 6 ? 0.0 : (index * 60 - 90) * (pi / 180);
                    final offset =
                        index == 6
                            ? Offset(
                              context.adaptiveSize(size * 2 - 4),
                              context.adaptiveSize(size * 2 - 4),
                            )
                            : Offset(
                              center.dx + radius * cos(angle),
                              center.dy + radius * sin(angle),
                            );
                    return Positioned(
                      left: offset.dx - size / 2,
                      top: offset.dy - size / 2,
                      child:
                          index == 6
                              ? _buildCenterCircle(size + 8)
                              : ScaleTransition(
                                scale: Tween<double>(begin: 0, end: 1).animate(
                                  CurvedAnimation(
                                    parent: _controller,
                                    curve: Interval(
                                      index * 0.1,
                                      1.0,
                                      curve: Curves.easeOut,
                                    ),
                                  ),
                                ),
                                child: _buildRegularCircle(size, index),
                              ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _bottomBarController,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _bottomBarController,
                curve: Curves.easeOut,
              ),
            ),
            child: BottomBar(currentScreen: widget),
          );
        },
      ),
    );
  }

  Widget _buildRegularCircle(double size, int index) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: BaseColors.backgroundCircles,
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      _cachedPages[index],
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 300),
            ),
          );
        },
        child: AnimatedBuilder(
          animation: _animationTextController,
          builder: (context, child) {
            final textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationTextController,
                curve: Interval(
                  0.05 * index,
                  0.2 * (index),
                  curve: Curves.easeInOut,
                ),
              ),
            );
            return Opacity(
              opacity: textOpacity.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _svgIcons[index],
                    color: BaseColors.secondary,
                  ),
                  SizedBox(height: size * 0.01),
                  Text(
                    _labels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'San Francisco Pro Display',
                      fontSize: size * 0.13,
                      color: BaseColors.secondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCenterCircle(double size) {
    return AnimatedBuilder(
      animation: _centerCirclesController,
      builder: (context, child) {
        final textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _centerCirclesController,
            curve: Interval(0.7, 1, curve: Curves.linear),
          ),
        );
        return Opacity(
          opacity: textOpacity.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: CustomPaint(
              painter: DashedCirclePainter(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _labels[6],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size * 0.14,
                      fontFamily: 'San Francisco Pro Display',
                      color: BaseColors.accent,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = BaseColors.accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;
    double dashWidth = 5, dashSpace = 5, radius = size.width / 2;
    double startAngle = 0;
    while (startAngle < 2 * pi) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
