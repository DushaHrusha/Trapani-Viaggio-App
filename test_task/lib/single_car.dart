import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/sign_up_screen.dart';

class AutomobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automobiles',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CarDetailsScreen(),
    );
  }
}

class CarDetailsScreen extends StatefulWidget {
  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
          onPressed: () {},
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
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: [CarPage(), CarPage(), CarPage()],
            ),
          ),
          _buildSpecsCarousel(),
          _buildDateSelector(),
          _buildBookingPanel(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
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
    {'icon': Icons.directions_car, 'label': 'Авто'},
    {'icon': Icons.home, 'label': 'Дом'},
    {'icon': Icons.work, 'label': 'Работа'},
    {'icon': Icons.settings, 'label': 'Настройки'},
  ];

  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _scrollToIndex(int index) {
    final double itemWidth = 90 + 25; // Ширина элемента + отступ
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
      height: 130, // Увеличенная высота
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              _scrollToIndex(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90, // Увеличенный размер
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 241, 244),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _icons[index]['icon'],
                          size: 40, // Увеличенный размер иконки
                          color:
                              _selectedIndex == index
                                  ? Colors.blue
                                  : Colors.grey[600],
                        ),
                        SizedBox(height: 10),

                        Text(
                          _icons[index]['label'],
                          style: TextStyle(
                            fontFamily: 'San Francisco Pro Display',
                            fontSize: 14,
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

  Widget _buildDateSelector() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Choose dates:'),
              Text(
                '19-21 Aug 2020',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),

                side: BorderSide(color: Colors.grey),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$120', style: TextStyle(fontSize: 18)),
                      GestureDetector(
                        onTap: () {
                          // 2. Убрать лишние стрелочные функции
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 127, 80),
                                Color.fromARGB(255, 85, 97, 178),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: Text(
                                  'Book now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class CarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
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
          padding: EdgeInsets.only(left: 16, top: 8),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SvgPicture.asset('assets/file/form-bg.svg'),
              Image.asset('assets/file/alfaromeo.png'),
            ],
          ),
        ),
      ],
    );
  }
}
