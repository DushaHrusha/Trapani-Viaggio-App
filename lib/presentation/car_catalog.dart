import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/bloc/cubits/car_cubit.dart';
import 'package:test_task/bloc/state/car_state.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';
import 'package:test_task/core/constants/date_picker.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/data/models/car.dart';
import 'package:intl/intl.dart';

class CarCatalog extends StatelessWidget {
  const CarCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Automobiles', home: CarDetailsScreen());
  }
}

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _stageController;
  String _selectedDateRange = '--/--/----';
  late AnimationController _stageController1;
  late AnimationController _bottomBarController;

  late AnimationController _appBarController;
  late AnimationController _appBarController2;
  @override
  void initState() {
    super.initState();
    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _appBarController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _appBarController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _stageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _stageController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward();
          _stageController1.forward();
          _bottomBarController.forward();
          _appBarController1.forward();
        });
      }
    });

    _stageController.forward();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => CarCubit()..loadExcursions(),
    child: Scaffold(
      backgroundColor: BaseColors.background,
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, state) {
          if (state is CarInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CarLoaded) {
            return CustomBackgroundWithGradient(
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _appBarController,
                    builder:
                        (context, child) => Opacity(
                          opacity: _appBarController.value,
                          child: CustomAppBar(label: "trapani viaggio"),
                        ),
                  ),
                  Divider(height: 1, color: Colors.grey[300], thickness: 1),
                  CarPage(cars: state.cars),
                  SizedBox(height: 24),
                  _buildDateSelector(),
                  SizedBox(height: 24),
                  _buildBookingPanel(),
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

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 22, left: 22, right: 22),
      child: SizedBox(
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 24,
              icon: Icon(
                Icons.chevron_left,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
              //TODO
              onPressed: () {},
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Select vehicle',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'San Francisco Pro Display',
                  color: Color.fromARGB(255, 130, 130, 130),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 24,
              icon: Icon(
                Icons.chevron_right,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
              //TODO
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _icons = [
    {'icon': 'assets/file/Automatic.svg', 'label': 'Automatic'},
    {'icon': 'assets/file/Seats.svg', 'label': '4 Seats'},
    {'icon': 'assets/file/Gasoline.svg', 'label': 'Gasoline'},
    {'icon': 'assets/file/Insurance.svg', 'label': 'Insurance'},
  ];

  final ScrollController _scrollController = ScrollController();
  late AnimationController _appBarController1;

  void _scrollToIndex(int index) {
    final double itemWidth = 90 + 25;
    final double offset =
        index * itemWidth - (MediaQuery.of(context).size.width - itemWidth) / 2;

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSpecsCarousel() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _scrollToIndex(index);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                //  key: ValueKey(currentIndex),
                width: 80,
                height: 80,
                margin: EdgeInsets.only(
                  right: index < _icons.length - 1 ? 24 : 0,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 241, 244),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _icons[index]['icon'],
                      color: Color.fromARGB(255, 85, 97, 178),
                    ),
                    SizedBox(height: 6),
                    Text(
                      _icons[index]['label'],
                      style: TextStyle(
                        fontFamily: 'San Francisco Pro Display',
                        fontSize: 10,
                        color: Color.fromARGB(255, 85, 97, 178),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final String _selectedDateRange1 =
      '${DateTime.now().day} ${DateTime.now().month}  ${DateTime.now().year} ';
  late int sumDay = 0;

  Future<void> _selectDateRange1(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 2)),
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange =
            '${picked.start.day} — ${picked.end.day} ${picked.start.month} ${picked.start.year}';
        sumDay = picked.end.day - picked.start.day;
      });
    }
  }

  Widget _buildDateSelector() {
    return AnimatedBuilder(
      animation: _stageController1,
      builder: (context, child) {
        return Opacity(
          opacity: _stageController1.value,
          child: Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
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
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "SF Pro Display",
                        fontSize: 12,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  width: 1,
                  color: const Color.fromARGB(255, 224, 224, 224),
                ),
                SizedBox(
                  width: 170,
                  child: GestureDetector(
                    onTap: () {
                      // Вызываем через showDialog для отображения поверх экрана
                      showDialog(
                        context: context, // Требует наличия контекста
                        builder: (context) => DatePickerWidget(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDateRange,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "SF Pro Display",
                            fontSize: 14,
                            color: Color.fromARGB(255, 109, 109, 109),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
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

  // Метод для выбора даты
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 1)),
      ),
    );

    if (picked != null) {
      setState(() {
        sumDay = picked.end.day - picked.start.day;
        _selectedDateRange =
            '${picked.start.day} — ${picked.end.day} '
            '${_getMonthAbbreviation(picked.start.month)} '
            '${picked.start.year}';
      });
    }
  }

  String _getMonthAbbreviation(int month) {
    return DateFormat('MMM').format(DateTime(2020, month));
  }

  Widget _buildBookingPanel() {
    return AnimatedBuilder(
      animation: _stageController1,
      builder: (context, child) {
        return Opacity(
          opacity: _stageController1.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CustomTextFieldWithGradientButton(
              text: "${49 * sumDay} € / ${sumDay} days",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: "SF Pro Display",
                color: Color.fromARGB(255, 109, 109, 109),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CarPage extends StatefulWidget {
  late List<Car> cars;
  CarPage({super.key, required this.cars});

  @override
  createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> with TickerProviderStateMixin {
  int currentIndex = 0;
  int _previousIndex = 0;
  final Map<String, String> _icons = {
    'type_transmission': 'assets/file/Automatic.svg',
    'number_seats': 'assets/file/Seats.svg',
    'type_fuel': 'assets/file/Gasoline.svg',
    'insurance': 'assets/file/Insurance.svg',
  };

  final ScrollController _scrollController = ScrollController();

  void _scrollToIndex(int index) {
    final double itemWidth = 90 + 25;
    final double offset =
        index * itemWidth - (MediaQuery.of(context).size.width - itemWidth) / 2;

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  late List<Car> cars;
  late PageController _pageController;
  late AnimationController _controller;
  //final ScrollController _scrollController = ScrollController();
  late AnimationController _stageController;
  final String _selectedDateRange = '--/--/----';

  late AnimationController _appBarController;
  late AnimationController _animationTextController;
  late AnimationController _stageController1;
  late AnimationController _stageController2;

  @override
  void initState() {
    super.initState();
    cars = widget.cars;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 1,
      keepPage: true,
    );
    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _stageController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _stageController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _stageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward();
          _stageController1.forward();
          _stageController2.forward();
          _animationTextController.forward();
        });
      }
    });

    _stageController.forward();
  }

  void _nextCar() {
    if (currentIndex < cars.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCar() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22, left: 22, right: 22),
          child: SizedBox(
            height: 24,
            child: AnimatedBuilder(
              animation: _stageController1,
              builder: (context, child) {
                return Opacity(
                  opacity: _stageController1.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        icon: Icon(
                          Icons.chevron_left,
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                        //TODO
                        onPressed: _nextCar,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Select vehicle',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'San Francisco Pro Display',
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        icon: Icon(
                          Icons.chevron_right,
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                        //TODO
                        onPressed: _previousCar,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 27),
        Column(
          children: [
            AnimatedBuilder(
              animation: _stageController2,
              builder: (context, child) {
                return Opacity(
                  opacity: _stageController1.value,

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
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            key: ValueKey<String>(
                              cars[currentIndex].year.toString(),
                            ),
                            cars[currentIndex].year.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'San Francisco Pro Display',
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
                        ),
                        Text(
                          'from:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'San Francisco Pro Display',
                            color: Color.fromARGB(255, 130, 130, 130),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 7),
            AnimatedBuilder(
              animation: _stageController1,
              builder: (context, child) {
                return Opacity(
                  opacity: _stageController1.value,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Padding(
                      key: ValueKey<String>(cars[currentIndex].year.toString()),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cars[currentIndex].brand,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'San Francisco Pro Display',
                              color: Color.fromARGB(255, 109, 109, 109),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                cars[currentIndex].pricePerHour.toString(),
                                key: ValueKey<String>(
                                  'price${cars[currentIndex].pricePerHour}',
                                ),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'San Francisco Pro Display',
                                  color: Color.fromARGB(255, 255, 127, 80),
                                ),
                              ),
                              Text(
                                ' €',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'San Francisco Pro Display',
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
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: AnimatedBuilder(
                  animation: _stageController1,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _stageController1.value,
                      child: Row(
                        children: [
                          Text(
                            'Max speed: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'San Francisco Pro Display',
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
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
                                cars[currentIndex].year.toString(),
                              ),
                              cars[currentIndex].maxSpeed.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'San Francisco Pro Display',
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
            ),

            AnimatedBuilder(
              animation: _animationTextController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationTextController,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 212,
                          child: SvgPicture.asset(
                            'assets/file/form-bg.svg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 210,
                          child: AnimatedBuilder(
                            animation: _pageController,
                            builder:
                                (context, _) => PageView.builder(
                                  controller: _pageController,
                                  itemCount: cars.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _previousIndex = currentIndex;
                                      currentIndex = index;
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
                                            begin: Offset(
                                              1.0,
                                              0.0,
                                            ), // Начало справа
                                            end:
                                                Offset.zero, // Конечная позиция
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
                                          cars[index].image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    );
                                  },
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
        SizedBox(height: 7),
        AnimatedBuilder(
          animation: _animationTextController,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _animationTextController,
                  curve: Curves.easeOut,
                ),
              ),
              child: SizedBox(
                height: 80,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    _buildCharacteristicCircle(
                      cars[currentIndex].type_transmission,
                      _icons["type_transmission"]!,
                    ),
                    SizedBox(width: 24),
                    _buildCharacteristicCircle(
                      "${cars[currentIndex].number_seats} Seats",
                      _icons["number_seats"]!,
                    ),
                    SizedBox(width: 24),
                    _buildCharacteristicCircle(
                      cars[currentIndex].type_fuel,
                      _icons["type_fuel"]!,
                    ),
                    SizedBox(width: 24),
                    _buildCharacteristicCircle(
                      cars[currentIndex].insurance,
                      _icons["insurance"]!,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
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
        key: ValueKey<String>(cars[currentIndex].year.toString()),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 241, 244),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, color: Color.fromARGB(255, 85, 97, 178)),
            SizedBox(height: 6),
            Text(
              carCh,
              style: TextStyle(
                fontFamily: 'San Francisco Pro Display',
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
}
