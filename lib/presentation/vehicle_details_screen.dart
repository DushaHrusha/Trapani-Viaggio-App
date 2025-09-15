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
  late AnimationController _stageController;
  String _selectedDateRange = '--/--/----';
  late AnimationController _stageController1;
  late AnimationController _bottomBarController;
  late AnimationController _appBarController;
  late AnimationController _appBarController1;
  late int sumDay = 0;

  int currentIndex43 = 0;
  final Map<String, String> _icons43 = {
    'type_transmission': 'assets/file/Automatic.svg',
    'number_seats': 'assets/file/Seats.svg',
    'type_fuel': 'assets/file/Gasoline.svg',
    'insurance': 'assets/file/Insurance.svg',
  };

  final ScrollController _scrollController434 = ScrollController();

  late List<Vehicle> vehicle;
  late PageController _pageController43;
  late AnimationController _stageController43;

  late AnimationController _appBarController23;
  late AnimationController _animationTextController32;
  late AnimationController _stageController132;
  late AnimationController _stageController223;
  late VehicleRepository vehicleRepository;
  late String label;

  @override
  void initState() {
    super.initState();
    vehicleRepository = widget.vehicleRepository;
    label = widget.label;
    _pageController43 = PageController(
      initialPage: currentIndex43,
      viewportFraction: 1,
      keepPage: true,
    );
    _appBarController23 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _stageController132 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _stageController223 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _stageController43 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationTextController32 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _stageController43.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController23.forward().then((_) {
            _stageController132.forward().then((_) {
              _stageController223.forward();
              _animationTextController32.forward();
            });
          });
        });
      }
    });

    _stageController43.forward();

    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _appBarController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _stageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _stageController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward().then((_) {
            _appBarController1.forward().then((_) {
              _stageController1.forward();
              _bottomBarController.forward();
            });
          });
        });
      }
    });

    _stageController.forward();
  }

  void _nextCar() {
    if (currentIndex43 < vehicle.length - 1) {
      _pageController43.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCar() {
    if (currentIndex43 > 0) {
      _pageController43.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _stageController43.dispose();
    _appBarController23.dispose();
    _animationTextController32.dispose();
    _stageController132.dispose();
    _stageController223.dispose();
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
        key: ValueKey<String>(vehicle[currentIndex43].year.toString()),
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
    create: (context) => VehicleCubit()..loadExcursions(vehicleRepository),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: BaseColors.background,
      body: BlocBuilder<VehicleCubit, VehicleState>(
        builder: (context, state) {
          if (state is VehicleInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is VehicleLoaded) {
            vehicle = state.vehicles;
            return CustomBackgroundWithGradient(
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _appBarController,
                    builder:
                        (context, child) => Opacity(
                          opacity: _appBarController.value,
                          child: CustomAppBar(label: label),
                        ),
                  ),
                  AnimatedBuilder(
                    animation: _appBarController,
                    builder:
                        (context, child) => Opacity(
                          opacity: _appBarController.value,
                          child: GreyLine(),
                        ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.adaptiveSize(20),
                          left: context.adaptiveSize(10),
                          right: context.adaptiveSize(10),
                        ),
                        child: SizedBox(
                          height: context.adaptiveSize(26),
                          child: AnimatedBuilder(
                            animation: _stageController132,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _stageController132.value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color: Color.fromARGB(
                                            255,
                                            130,
                                            130,
                                            130,
                                          ),
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
                      ),
                      SizedBox(height: context.adaptiveSize(27)),
                      Column(
                        children: [
                          AnimatedBuilder(
                            animation: _stageController223,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _stageController223.value,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 1000),
                                        transitionBuilder: (
                                          Widget child,
                                          Animation<double> animation,
                                        ) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        child: Text(
                                          key: ValueKey<String>(
                                            vehicle[currentIndex43].year
                                                .toString(),
                                          ),
                                          vehicle[currentIndex43].year
                                              .toString(),
                                          style: context.adaptiveTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                              255,
                                              130,
                                              130,
                                              130,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'from:',
                                        style: context.adaptiveTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                            255,
                                            130,
                                            130,
                                            130,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: context.adaptiveSize(7)),
                          AnimatedBuilder(
                            animation: _stageController223,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _stageController223.value,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 1000),
                                  transitionBuilder: (
                                    Widget child,
                                    Animation<double> animation,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  child: Padding(
                                    key: ValueKey<String>(
                                      vehicle[currentIndex43].year.toString(),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: context.adaptiveSize(30),
                                      right: context.adaptiveSize(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          vehicle[currentIndex43].brand,
                                          style: context.adaptiveTextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                              255,
                                              109,
                                              109,
                                              109,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              vehicle[currentIndex43]
                                                  .pricePerHour
                                                  .toString(),
                                              key: ValueKey<String>(
                                                'price${vehicle[currentIndex43].pricePerHour}',
                                              ),
                                              style: context.adaptiveTextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  127,
                                                  80,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' €',
                                              style: context.adaptiveTextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  127,
                                                  80,
                                                ),
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
                          ),
                          SizedBox(height: context.adaptiveSize(8)),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.adaptiveSize(30),
                                right: context.adaptiveSize(30),
                              ),
                              child: AnimatedBuilder(
                                animation: _stageController223,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _stageController223.value,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Max speed: ',
                                          style: context.adaptiveTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                              255,
                                              130,
                                              130,
                                              130,
                                            ),
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration: Duration(
                                            milliseconds: 1000,
                                          ),
                                          transitionBuilder: (
                                            Widget child,
                                            Animation<double> animation,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                          child: Text(
                                            key: ValueKey<String>(
                                              vehicle[currentIndex43].year
                                                  .toString(),
                                            ),
                                            "${vehicle[currentIndex43].maxSpeed.toString()} km/h",
                                            style: context.adaptiveTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                255,
                                                130,
                                                130,
                                                130,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _animationTextController32,
                            builder: (context, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: _animationTextController32,
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

                                    // Контейнер для машины по центру
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: context.adaptiveSize(210),
                                          child: AnimatedBuilder(
                                            animation: _pageController43,
                                            builder:
                                                (
                                                  context,
                                                  _,
                                                ) => PageView.builder(
                                                  controller: _pageController43,
                                                  itemCount: vehicle.length,
                                                  onPageChanged: (index) {
                                                    setState(() {
                                                      currentIndex43 = index;
                                                    });
                                                  },
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    return AnimatedSwitcher(
                                                      duration: Duration(
                                                        milliseconds: 500,
                                                      ),
                                                      switchInCurve:
                                                          Curves.easeOut,
                                                      switchOutCurve:
                                                          Curves.easeIn,
                                                      transitionBuilder: (
                                                        Widget child,
                                                        Animation<double>
                                                        animation,
                                                      ) {
                                                        return SlideTransition(
                                                          position: Tween<
                                                            Offset
                                                          >(
                                                            begin: Offset(
                                                              1.0,
                                                              0.0,
                                                            ),
                                                            end: Offset.zero,
                                                          ).animate(
                                                            CurvedAnimation(
                                                              parent: animation,
                                                              curve:
                                                                  Curves
                                                                      .easeOut,
                                                            ),
                                                          ),
                                                          child: FadeTransition(
                                                            opacity: animation,
                                                            child: child,
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        key: ValueKey<int>(
                                                          index,
                                                        ),
                                                        child: Image.asset(
                                                          vehicle[index].image,
                                                          fit: BoxFit.contain,
                                                          height: context
                                                              .adaptiveSize(
                                                                210,
                                                              ),
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
                          ),
                        ],
                      ),
                      SizedBox(height: context.adaptiveSize(16)),
                      AnimatedBuilder(
                        animation: _animationTextController32,
                        builder: (context, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _animationTextController32,
                                curve: Curves.easeOut,
                              ),
                            ),
                            child: SizedBox(
                              height: context.adaptiveSize(80),
                              child: ListView(
                                controller: _scrollController434,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                children: [
                                  _buildCharacteristicCircle(
                                    vehicle[currentIndex43].type_transmission,
                                    _icons43["type_transmission"]!,
                                  ),
                                  SizedBox(width: context.adaptiveSize(24)),
                                  _buildCharacteristicCircle(
                                    "${vehicle[currentIndex43].number_seats} Seats",
                                    _icons43["number_seats"]!,
                                  ),
                                  SizedBox(width: context.adaptiveSize(24)),
                                  _buildCharacteristicCircle(
                                    vehicle[currentIndex43].type_fuel,
                                    _icons43["type_fuel"]!,
                                  ),
                                  SizedBox(width: context.adaptiveSize(24)),
                                  _buildCharacteristicCircle(
                                    vehicle[currentIndex43].insurance,
                                    _icons43["insurance"]!,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
        animation: _bottomBarController,
        builder:
            (context, child) => SlideTransition(
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
            ),
      ),
    ),
  );
  Widget _buildDateSelector() {
    return AnimatedBuilder(
      animation: _bottomBarController,
      builder: (context, child) {
        return Opacity(
          opacity: _bottomBarController.value,
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
      animation: _bottomBarController,
      builder: (context, child) {
        return Opacity(
          opacity: _bottomBarController.value,
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
