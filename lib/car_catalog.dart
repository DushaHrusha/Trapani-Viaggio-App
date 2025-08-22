import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/main_menu.dart';
import 'package:test_task/bottom_bar.dart';
import 'package:test_task/sign_up_screen.dart';

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

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 251, 253),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 251, 251, 253),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
        ),
        title: Text(
          'automobiles',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Berlin Sans FB',
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Color.fromARGB(255, 109, 109, 109)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(height: 1, color: Colors.grey[300], thickness: 1),
          _buildHeader(),
          CarPage(),
          _buildSpecsCarousel(),
          _buildDateSelector(),
          _buildBookingPanel(),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Color.fromARGB(255, 130, 130, 130),
            ),
            onPressed: () {},
          ),
          Text(
            'Select vehicle',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'San Francisco Pro Display',
              color: Color.fromARGB(255, 130, 130, 130),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Color.fromARGB(255, 130, 130, 130),
            ),
            onPressed: () {},
          ),
        ],
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
      height: 130,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _scrollToIndex(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _selectedDateRange =
      '${DateTime.now().day} ${DateTime.now().month}  ${DateTime.now().year} ';
  late int sumDay = 0;
  Future<void> _selectDateRange(BuildContext context) async {
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
    return Padding(
      padding: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => _selectDateRange(context),
        child: Material(
          color: Color.fromARGB(255, 251, 251, 253),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose dates:',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "SF Pro Display",
                    fontSize: 12,
                    color: Color.fromARGB(255, 109, 109, 109),
                  ),
                ),
                Text(
                  _selectedDateRange,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "SF Pro Display",
                    fontSize: 12,
                    color: Color.fromARGB(255, 109, 109, 109),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingPanel() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Color.fromARGB(255, 251, 251, 253),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),

                side: BorderSide(color: Colors.grey),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
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
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 127, 80),
                                    Color.fromARGB(255, 85, 97, 178),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 60,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 18.0,
                                      ),
                                      child: Text(
                                        'Book now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "SF Pro Display",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2015',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'San Francisco Pro Display',
                  color: Color.fromARGB(255, 130, 130, 130),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fiat 500',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'San Francisco Pro Display',
                  color: Color.fromARGB(255, 109, 109, 109),
                ),
              ),
              Text(
                '49 €',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'San Francisco Pro Display',
                  color: Color.fromARGB(255, 255, 127, 80),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32, top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Max speed: 140 km/h',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'San Francisco Pro Display',
                color: Color.fromARGB(255, 130, 130, 130),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/file/form-bg.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/file/alfaromeo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
