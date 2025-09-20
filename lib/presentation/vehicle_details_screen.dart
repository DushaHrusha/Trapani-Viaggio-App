import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/bloc/cubits/vehicle_cubit.dart';
import 'package:test_task/bloc/state/vehicle_state.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';
import 'package:test_task/core/constants/date_picker.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/data/models/vehicle.dart';
import 'package:test_task/data/repositories/vehicle_repository.dart';

class VehicleAnimationController {
  final TickerProvider _vsync;
  late final AnimationController _masterController;
  late final VehicleAnimationSequence _animations;

  VehicleAnimationController({required TickerProvider vsync}) : _vsync = vsync {
    _initializeController();
  }

  void _initializeController() {
    _masterController = AnimationController(
      vsync: _vsync,
      duration: const Duration(milliseconds: 3000),
    );
    _animations = VehicleAnimationSequence(_masterController);
  }

  VehicleAnimationSequence get animations => _animations;

  void startAnimation() => _masterController.forward();
  void resetAnimation() => _masterController.reset();
  void dispose() => _masterController.dispose();
}

class VehicleAnimationSequence {
  final AnimationController _controller;

  static const _AnimationTiming _appBarTiming = _AnimationTiming(0.17, 0.33);
  static const _AnimationTiming _headerTiming = _AnimationTiming(0.33, 0.5);
  static const _AnimationTiming _contentTiming = _AnimationTiming(0.5, 0.67);
  static const _AnimationTiming _imageTiming = _AnimationTiming(0.5, 0.67);
  static const _AnimationTiming _bottomTiming = _AnimationTiming(0.33, 0.5);

  VehicleAnimationSequence(this._controller);

  Animation<double> get appBarFade => _createFadeAnimation(_appBarTiming);

  Animation<double> get headerFade => _createFadeAnimation(_headerTiming);

  Animation<double> get contentFade => _createFadeAnimation(_contentTiming);

  Animation<Offset> get imageSlide => _createSlideAnimation(
    _imageTiming,
    begin: const Offset(1, 0),
    end: Offset.zero,
  );

  Animation<double> get bottomFade => _createFadeAnimation(_bottomTiming);
  Animation<Offset> get bottomBarSlide => _createSlideAnimation(
    _bottomTiming,
    begin: const Offset(0, 1),
    end: Offset.zero,
  );

  Animation<double> _createFadeAnimation(_AnimationTiming timing) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(timing.start, timing.end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<Offset> _createSlideAnimation(
    _AnimationTiming timing, {
    required Offset begin,
    required Offset end,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(timing.start, timing.end, curve: Curves.easeOut),
      ),
    );
  }
}

class _AnimationTiming {
  final double start;
  final double end;
  const _AnimationTiming(this.start, this.end);
}

class VehicleDetailsScreen extends StatefulWidget {
  final VehicleRepository vehicleRepository;
  final String label;
  const VehicleDetailsScreen({
    super.key,
    required this.vehicleRepository,
    required this.label,
  });
  @override
  createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen>
    with TickerProviderStateMixin {
  String _selectedDateRange = '--/--/----';
  late int sumDay = 0;
  late final ScrollController _scrollController;
  late final PageController _pageController;
  late final VehicleAnimationController _animationController;
  late final List<Vehicle> _vehicle;
  late final VehicleRepository _vehicleRepository;
  late final String label;
  int _currentIndex = 0;
  final Map<String, String> _icons43 = {
    'type_transmission': 'assets/file/Automatic.svg',
    'number_seats': 'assets/file/Seats.svg',
    'type_fuel': 'assets/file/Gasoline.svg',
    'insurance': 'assets/file/Insurance.svg',
  };

  @override
  void initState() {
    super.initState();

    _animationController = VehicleAnimationController(vsync: this);
    _vehicleRepository = widget.vehicleRepository;
    label = widget.label;
    _scrollController = ScrollController();
    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: 1,
      keepPage: true,
    );
    _startAnimation();
  }

  void _startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.startAnimation();
    });
  }

  void _nextCar() {
    if (_currentIndex < _vehicle.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCar() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildCharacteristicCircle(String carCh, String iconPath) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.5, curve: Curves.linear),
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 0.8, curve: Curves.linear),
              ),
            ),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<String>(_vehicle[_currentIndex].year.toString()),
        width: context.adaptiveSize(80),
        height: context.adaptiveSize(80),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 241, 244),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, color: Color.fromARGB(255, 85, 97, 178)),
            SizedBox(height: context.adaptiveSize(6)),
            Text(
              carCh,
              style: context.adaptiveTextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 85, 97, 178),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => VehicleCubit()..loadExcursions(_vehicleRepository),
    child: Scaffold(
      body: BlocBuilder<VehicleCubit, VehicleState>(
        builder: (context, state) {
          if (state is VehicleInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is VehicleLoaded) {
            _vehicle = state.vehicles;
            return CustomBackgroundWithGradient(
              child: Column(
                children: [
                  _AppBar(),
                  _DiverLine(),
                  Column(
                    children: [
                      _AnimatedVehicleHeader(context),
                      SizedBox(height: context.adaptiveSize(27)),
                      _YearProduction(),
                      SizedBox(height: context.adaptiveSize(7)),
                      _NameAndPricePerDay(),
                      SizedBox(height: context.adaptiveSize(8)),
                      _MaxSpeed(context),
                      _AnimatedVehicleImage(),
                      SizedBox(height: context.adaptiveSize(16)),
                      _AnimatedVehicleSpecs(),
                    ],
                  ),
                  Spacer(),
                  _buildDateSelector(),
                  Spacer(),
                  _buildBookingPanel(),
                  Spacer(),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _animationController.animations.bottomBarSlide,
        builder:
            (context, child) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _animationController.animations.contentFade,
                  curve: Curves.easeOut,
                ),
              ),
              child: BottomBar(currentScreen: widget),
            ),
      ),
    ),
  );

  Align _MaxSpeed(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: context.adaptiveSize(30),
          right: context.adaptiveSize(30),
        ),
        child: AnimatedBuilder(
          animation: _animationController.animations.contentFade,
          builder: (context, child) {
            return Opacity(
              opacity: _animationController.animations.contentFade.value,
              child: Row(
                children: [
                  Text(
                    'Max speed: ',
                    style: context.adaptiveTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 130, 130, 130),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      key: ValueKey<String>(
                        _vehicle[_currentIndex].year.toString(),
                      ),
                      "${_vehicle[_currentIndex].maxSpeed.toString()} km/h",
                      style: context.adaptiveTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
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

  AnimatedBuilder _NameAndPricePerDay() {
    return AnimatedBuilder(
      animation: _animationController.animations.contentFade,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.animations.contentFade.value,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Padding(
              key: ValueKey<String>(_vehicle[_currentIndex].year.toString()),
              padding: EdgeInsets.only(
                left: context.adaptiveSize(30),
                right: context.adaptiveSize(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _vehicle[_currentIndex].brand,
                    style: context.adaptiveTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 109, 109, 109),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _vehicle[_currentIndex].pricePerHour.toString(),
                        key: ValueKey<String>(
                          'price${_vehicle[_currentIndex].pricePerHour}',
                        ),
                        style: context.adaptiveTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 127, 80),
                        ),
                      ),
                      Text(
                        ' €',
                        style: context.adaptiveTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 127, 80),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder _YearProduction() {
    return AnimatedBuilder(
      animation: _animationController.animations.contentFade,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.animations.contentFade.value,
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 1000),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    key: ValueKey<String>(
                      _vehicle[_currentIndex].year.toString(),
                    ),
                    _vehicle[_currentIndex].year.toString(),
                    style: context.adaptiveTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 130, 130, 130),
                    ),
                  ),
                ),
                Text(
                  'from:',
                  style: context.adaptiveTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 130, 130, 130),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder _AnimatedVehicleSpecs() {
    return AnimatedBuilder(
      animation: _animationController.animations.imageSlide,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController.animations.contentFade,
              curve: Curves.easeOut,
            ),
          ),
          child: SizedBox(
            height: context.adaptiveSize(80),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildCharacteristicCircle(
                  _vehicle[_currentIndex].type_transmission,
                  _icons43["type_transmission"]!,
                ),
                SizedBox(width: context.adaptiveSize(24)),
                _buildCharacteristicCircle(
                  "${_vehicle[_currentIndex].number_seats} Seats",
                  _icons43["number_seats"]!,
                ),
                SizedBox(width: context.adaptiveSize(24)),
                _buildCharacteristicCircle(
                  _vehicle[_currentIndex].type_fuel,
                  _icons43["type_fuel"]!,
                ),
                SizedBox(width: context.adaptiveSize(24)),
                _buildCharacteristicCircle(
                  _vehicle[_currentIndex].insurance,
                  _icons43["insurance"]!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder _AnimatedVehicleImage() {
    return AnimatedBuilder(
      animation: _animationController.animations.imageSlide,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController.animations.contentFade,
              curve: Curves.easeOut,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.widthOf(context),
                height: context.adaptiveSize(212),
                margin: EdgeInsets.symmetric(
                  horizontal: context.adaptiveSize(30),
                ),
                child: SvgPicture.asset(
                  'assets/file/form-bg.svg',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: context.adaptiveSize(210),
                    child: AnimatedBuilder(
                      animation: _pageController,
                      builder:
                          (context, _) => PageView.builder(
                            controller: _pageController,
                            itemCount: _vehicle.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                switchInCurve: Curves.easeOut,
                                switchOutCurve: Curves.easeIn,
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                ) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Container(
                                  key: ValueKey<int>(index),
                                  child: Image.asset(
                                    _vehicle[index].image,
                                    fit: BoxFit.contain,
                                    height: context.adaptiveSize(210),
                                  ),
                                ),
                              );
                            },
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _AnimatedVehicleHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.adaptiveSize(20),
        left: context.adaptiveSize(10),
        right: context.adaptiveSize(10),
      ),
      child: SizedBox(
        height: context.adaptiveSize(26),
        child: AnimatedBuilder(
          animation: _animationController.animations.headerFade,
          builder: (context, child) {
            return Opacity(
              opacity: _animationController.animations.headerFade.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: context.adaptiveSize(24),
                    icon: Icon(
                      Icons.chevron_left,
                      size: 28,
                      color: Color.fromRGBO(189, 189, 189, 1),
                    ),
                    onPressed: _nextCar,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select vehicle',
                      style: context.adaptiveTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: context.adaptiveSize(24),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 28,
                      color: Color.fromRGBO(189, 189, 189, 1),
                    ),
                    onPressed: _previousCar,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AnimatedBuilder _DiverLine() {
    return AnimatedBuilder(
      animation: _animationController.animations.appBarFade,
      builder:
          (context, child) => Opacity(
            opacity: _animationController.animations.appBarFade.value,
            child: GreyLine(),
          ),
    );
  }

  AnimatedBuilder _AppBar() {
    return AnimatedBuilder(
      animation: _animationController.animations.appBarFade,
      builder:
          (context, child) => Opacity(
            opacity: _animationController.animations.appBarFade.value,
            child: CustomAppBar(label: label),
          ),
    );
  }

  Widget _buildDateSelector() {
    return AnimatedBuilder(
      animation: _animationController.animations.contentFade,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.animations.contentFade.value,
          child: Container(
            height: context.adaptiveSize(56),
            margin: EdgeInsets.symmetric(horizontal: context.adaptiveSize(30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.adaptiveSize(30)),
              color: Color.fromARGB(0, 177, 11, 11),
              border: Border.all(
                color: const Color.fromARGB(255, 224, 224, 224),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Choose dates:',
                      style: context.adaptiveTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: context.adaptiveSize(56),
                  width: 1,
                  color: const Color.fromARGB(255, 224, 224, 224),
                ),
                SizedBox(
                  width: context.adaptiveSize(170),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DatePickerWidget(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDateRange,
                          style: context.adaptiveTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 109, 109, 109),
                          ),
                        ),
                        SizedBox(width: context.adaptiveSize(8)),
                        Icon(
                          Icons.calendar_today,
                          size: context.adaptiveSize(16),
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingPanel() {
    return AnimatedBuilder(
      animation: _animationController.animations.contentFade,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.animations.contentFade.value,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.adaptiveSize(30)),
            child: CustomTextFieldWithGradientButton(
              text: "${49 * sumDay} € / ${sumDay} days",
              style: context.adaptiveTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 109, 109, 109),
              ),
            ),
          ),
        );
      },
    );
  }
}
