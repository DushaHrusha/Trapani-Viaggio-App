import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/bloc/car_catalog_cubit.dart';
import 'package:test_task/date_picker.dart';
import 'package:test_task/main_menu.dart';
import 'package:test_task/bottom_bar.dart';
import 'package:test_task/sign_up_screen.dart';
import 'package:intl/intl.dart';

class CarCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Automobiles', home: CarDetailsScreen());
  }
}

class CarDetailsScreen extends StatefulWidget {
  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _stageController;
  String _selectedDateRange = '--/--/----'; // Инициализация плейсхолдера
  late AnimationController _stageController1;

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
    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward();
          _stageController1.forward();
        });
      }
    });

    _stageController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(255, 127, 80, 1),
              Color.fromRGBO(85, 97, 178, 1),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 58),
          child: Container(
            decoration: BoxDecoration(
              color: BaseColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _appBarController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _appBarController.value,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 25.0,
                          right: 20,
                          left: 20,
                          bottom: 23,
                        ),
                        child: SizedBox(
                          height: 27,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/file/left.svg',
                                  height: 24,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  maxHeight: 24,
                                ),
                                onPressed:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarCatalog(),
                                      ),
                                    ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'trapani viaggio',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Berlin Sans FB',
                                    height: 1.0,
                                    color: Color.fromARGB(255, 109, 109, 109),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/file/menu.svg',
                                  height: 24,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  maxHeight: 24,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 1, color: Colors.grey[300], thickness: 1),
                CarPage(),
                //  _buildSpecsCarousel(),
                SizedBox(height: 24),
                _buildDateSelector(),
                SizedBox(height: 24),
                _buildBookingPanel(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 22, left: 22, right: 22),
      child: Container(
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
    return Container(
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

  String _selectedDateRange1 =
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
                Container(
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

  // Вспомогательный метод для получения сокращения месяца
  String _getMonthAbbreviation(int month) {
    return DateFormat('MMM').format(DateTime(2020, month));
  }

  Widget _buildBookingPanel() {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: Text(
                    ' ${49 * sumDay} € / ${sumDay} days',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF Pro Display",
                      color: Color.fromARGB(255, 109, 109, 109),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Container(
                    height: 56,
                    width: 190,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 127, 80),
                          Color.fromARGB(255, 85, 97, 178),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                            127,
                            255,
                            175,
                            175,
                          ), // Начальный цвет градиента
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: Offset(-5, -5),
                        ),
                        BoxShadow(
                          color: Color.fromARGB(
                            127,
                            132,
                            147,
                            197,
                          ), // Конечный цвет градиента
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Book now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "SF Pro Display",
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height: 56,
                          width: 1,
                          color: const Color.fromARGB(255, 138, 120, 178),
                        ),

                        Container(
                          width: 60,
                          child: Icon(Icons.arrow_forward, color: Colors.white),
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
}

class CarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarPageState();
  }
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

  final List<Car> cars = [
    Car(
      brand: 'Toyota Camry',
      pricePerHour: 5,
      maxSpeed: 200,
      image: "assets/file/car1.png",
      year: 2014,
      type_transmission: 'Automatic',
      number_seats: 4,
      type_fuel: 'gasoline',
      insurance: 'Insurance',
    ),
    Car(
      brand: 'BMW X5',
      pricePerHour: 8,
      maxSpeed: 220,
      image: "assets/file/car2.png",
      year: 2014,
      type_transmission: 'Automatic',
      number_seats: 4,
      type_fuel: 'gasoline',
      insurance: 'Insurance',
    ),
    Car(
      brand: 'Tesla Model 3',
      pricePerHour: 10,
      maxSpeed: 250,
      image: "assets/file/car1.png",
      year: 2014,
      type_transmission: 'Automatic',
      number_seats: 4,
      type_fuel: 'gasoline',
      insurance: 'Insurance',
    ),
    Car(
      brand: 'Mercedes-Benz',
      pricePerHour: 12,
      maxSpeed: 230,
      image: "assets/file/car2.png",
      year: 2014,
      type_transmission: 'Automatic',
      number_seats: 4,
      type_fuel: 'gasoline',
      insurance: 'Insurance',
    ),
    Car(
      brand: 'Audi Q7',
      pricePerHour: 9,
      maxSpeed: 210,
      image: "assets/file/car1.png",
      year: 2014,
      type_transmission: 'Automatic',
      number_seats: 4,
      type_fuel: 'gasoline',
      insurance: 'Insurance',
    ),
  ];
  late PageController _pageController;
  late AnimationController _controller;
  //final ScrollController _scrollController = ScrollController();
  late AnimationController _stageController;
  String _selectedDateRange = '--/--/----'; // Инициализация плейсхолдера

  late AnimationController _appBarController;

  late AnimationController _stageController1;
  late AnimationController _stageController2;

  @override
  void initState() {
    super.initState();

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

    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 0), () {
          _appBarController.forward();
          _stageController1.forward();
          _stageController2.forward();
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
          child: Container(
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
                      key: ValueKey<String>(cars[currentIndex].brand),
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
            Stack(
              children: [
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
                                    cars[currentIndex].maxSpeed.toString(),
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
                                  // Анимация slide справа налево
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0), // Начало справа
                                      end: Offset.zero, // Конечная позиция
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
          ],
        ),
        SizedBox(height: 7),
        Container(
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
      ],
    );
  }

  Widget _buildCharacteristicCircle(String car_ch, String icon_path) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000), // Общая длительность
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
        key: ValueKey<String>(cars[currentIndex].maxSpeed.toString()),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 241, 244),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon_path,
              color: Color.fromARGB(255, 85, 97, 178),
            ),
            SizedBox(height: 6),
            Text(
              car_ch,
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

class Car {
  final String brand;
  final int pricePerHour;
  final int maxSpeed;
  final String image;
  final int year;
  final String type_transmission;
  final int number_seats;
  final String type_fuel;
  final String insurance;
  Car({
    required this.brand,
    required this.pricePerHour,
    required this.maxSpeed,
    required this.image,
    required this.year,
    required this.type_transmission,
    required this.number_seats,
    required this.type_fuel,
    required this.insurance,
  });
}
