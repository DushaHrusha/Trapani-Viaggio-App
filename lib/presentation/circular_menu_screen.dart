import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/core/routing/app_routes.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/data/models/menu_item.dart';

class MenuAnimations {
  final AnimationController _controller;

  static const double _appBarStart = 0;
  static const double _appBarEnd = 0.3;

  static const double _searchStart = 0.2;
  static const double _searchEnd = 0.5;

  static const double _circleStart = 0.4;
  static const double _circleEnd = 0.7;

  static const double _textStart = 0.3;
  static const double _textEnd = 0.9;

  static const double _centerStart = 0.5;
  static const double _centerEnd = 0.7;

  static const double _bottomBarStart = 0.5;
  static const double _bottomBarEnd = 0.7;

  MenuAnimations(this._controller);

  Animation<double> get appBarAnimation => Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(_appBarStart, _appBarEnd, curve: Curves.easeOut),
    ),
  );

  Animation<double> get searchAnimation => Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(_searchStart, _searchEnd, curve: Curves.easeOut),
    ),
  );

  Animation<double> get circleAnimation => Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(_circleStart, _circleEnd, curve: Curves.easeOut),
    ),
  );

  Animation<double> get textAnimation =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(_textStart, _textEnd, curve: Curves.easeInOut),
        ),
      );

  Animation<double> get centerAnimation =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(_centerStart, _centerEnd, curve: Curves.linear),
        ),
      );

  Animation<double> get bottomBarAnimation =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            _bottomBarStart,
            _bottomBarEnd,
            curve: Curves.easeOut,
          ),
        ),
      );
}

class CircularMenuScreen extends StatefulWidget {
  const CircularMenuScreen({super.key});

  @override
  createState() => _CircularMenuScreenState();
}

class _CircularMenuScreenState extends State<CircularMenuScreen>
    with TickerProviderStateMixin {
  final List<MenuItem> _menuItems = [
    MenuItem(
      label: 'Apartment',
      iconPath: 'assets/file/keys.svg',
      route: AppRouter.apartments,
    ),
    MenuItem(
      label: 'Auto',
      iconPath: 'assets/file/auto.svg',
      route: AppRouter.vehicleDetailsCars,
    ),
    MenuItem(
      label: 'Moto',
      iconPath: 'assets/file/Moto.svg',
      route: AppRouter.vehicleDetailsMotorcycles,
    ),
    MenuItem(
      label: 'Bicycle',
      iconPath: 'assets/file/Bicycle.svg',
      route: AppRouter.vehicleDetailsVespa,
    ),
    MenuItem(
      label: 'Vespa',
      iconPath: 'assets/file/Vespa.svg',
      route: AppRouter.vehicleDetailsVespa,
    ),
    MenuItem(
      label: 'Excursion',
      iconPath: 'assets/file/Excursion.svg',
      route: AppRouter.excursions,
    ),
  ];

  late AnimationController _masterController;
  late MenuAnimations _animations;
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animations = MenuAnimations(_masterController);
  }

  void _startAnimation() {
    _masterController.forward();
  }

  @override
  void dispose() {
    _masterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.25;
    final center = Offset(size * 2, size * 2);
    final radius = size * 1.1;
    return Scaffold(
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            _AppBar(),
            _DividerLine(),
            _SearchBar(),
            _CircularMenu(size, context, center, radius),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _animations.bottomBarAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animations.bottomBarAnimation,
                curve: Curves.easeOut,
              ),
            ),
            child: BottomBar(currentScreen: widget),
          );
        },
      ),
    );
  }

  SizedBox _CircularMenu(
    double size,
    BuildContext context,
    Offset center,
    double radius,
  ) {
    return SizedBox(
      width: size * 4,
      height: size * 5,
      child: Padding(
        padding: context.adaptivePadding(EdgeInsets.only(top: 45.0)),
        child: Stack(
          children: List.generate(7, (index) {
            final angle = index == 6 ? 0.0 : (index * 60 - 90) * (pi / 180);
            final offset =
                index == 6
                    ? Offset(size * 2 - 4, size * 2 - 4)
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
                            parent: _animations.circleAnimation,
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
    );
  }

  AnimatedBuilder _SearchBar() {
    return AnimatedBuilder(
      animation: _animations.searchAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _animations.searchAnimation.value,
          child: Padding(
            padding: context.adaptivePadding(
              EdgeInsets.only(top: 48, left: 30, right: 30),
            ),
            child: Container(
              height: context.adaptiveSize(40),
              decoration: BoxDecoration(
                color: BaseColors.background,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Color.fromRGBO(224, 224, 224, 1),
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
                    padding: context.adaptivePadding(
                      const EdgeInsets.only(left: 28, right: 6),
                    ),
                    child: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: SizedBox(
                        width: context.adaptiveSize(20),
                        height: context.adaptiveSize(20),
                        child: SvgPicture.asset(
                          "assets/file/search.svg",
                          color: BaseColors.primary,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'What do you want to find in Trapani?',
                  hintStyle: TextStyle(
                    fontSize: context.adaptiveSize(14),
                    height: 1.0,
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
    );
  }

  AnimatedBuilder _DividerLine() {
    return AnimatedBuilder(
      animation: _animations.searchAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _animations.searchAnimation.value,
          child: GreyLine(),
        );
      },
    );
  }

  AnimatedBuilder _AppBar() {
    return AnimatedBuilder(
      animation: _animations.appBarAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _animations.appBarAnimation.value,
          child: CustomAppBar(label: "trapani viaggio"),
        );
      },
    );
  }

  Widget _buildRegularCircle(double size, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(size / 2),
        onTap: () {
          context.go(_menuItems[index].route);
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: BaseColors.backgroundCircles,
            shape: BoxShape.circle,
          ),
          child: AnimatedBuilder(
            animation: _animations.textAnimation,
            builder: (context, child) {
              final textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animations.textAnimation,
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
                      _menuItems[index].iconPath,
                      color: BaseColors.secondary,
                    ),
                    SizedBox(height: size * 0.03),
                    Text(
                      _menuItems[index].label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
      ),
    );
  }

  Widget _buildCenterCircle(double size) {
    return AnimatedBuilder(
      animation: _animations.centerAnimation,
      builder: (context, child) {
        final textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _masterController,
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
                    "What are you looking for?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size * 0.14,
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
