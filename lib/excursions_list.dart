import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/botom_bar_with_filtrs.dart';
import 'package:test_task/car_catalog.dart';
import 'package:test_task/sign_up_screen.dart';

class Excursion {
  final String title;
  final String imageUrl;
  final String description;
  final double price;

  Excursion({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}

class ExcursionsList extends StatefulWidget {
  @override
  _ExcursionsListState createState() => _ExcursionsListState();
}

class _ExcursionsListState extends State<ExcursionsList> {
  final List<Excursion> excursions = [
    Excursion(
      title: 'Горы Кaвказа',
      imageUrl: "assets/file/maraslua.jpg",
      description:
          'Most popular bicycle tour to Natural Reserve Salt pans in Trapani. You will visit saline work museum in an old salt mill and enjoy fantastic landscapes. ',
      price: 3500,
    ),
    Excursion(
      title: 'Петwrerергоф',
      imageUrl: "assets/file/maraslua.jpg",
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
    Excursion(
      title: 'Петерг2434оф',
      imageUrl: 'assets/file/maraslua.jpg',
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
    Excursion(
      title: 'Петергewrweоф',
      imageUrl: 'assets/file/maraslua.jpg',
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
  ];

  final Map<int, int> ratings = {};
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _pages = [
      {'page': CarCatalog()},
      {'page': CarCatalog()},
      {'page': CarCatalog()},
      {'page': CarCatalog()},
      {'page': CarCatalog()},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            Padding(
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
                      constraints: BoxConstraints(minWidth: 24, maxHeight: 24),
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
                      constraints: BoxConstraints(minWidth: 24, maxHeight: 24),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey[300], thickness: 1),
            Expanded(
              child: ListView.builder(
                itemCount: excursions.length,
                itemBuilder: (context, index) {
                  final excursion = excursions[index];
                  final rating = ratings[index] ?? 0;
                  return (index == 0)
                      ? FirstCard(
                        excursion: excursion,
                        rating: rating,
                        index: index,
                        context: context,
                      )
                      : SecondCard(
                        excursion: excursion,
                        rating: rating,
                        index: index,
                        context: context,
                      );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // убрать это
        height: 64,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5.0,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border_outlined),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        //  margin: EdgeInsets.only(bottom: 30),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(Icons.search, color: BaseColors.accent, size: 24),
              onPressed:
                  () => setState(() {
                    _selectedPageIndex = 2;
                  }),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String icon) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SvgPicture.asset(icon),
      ),
      label: '',
    );
  }
}

class SecondCard extends StatelessWidget {
  final Excursion excursion;
  final int rating;
  final int index;
  final BuildContext context;

  const SecondCard({
    Key? key,
    required this.excursion,
    required this.rating,
    required this.index,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 44),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: Image.asset(
                    excursion.imageUrl,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Row(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text(
                            excursion.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (starIndex) {
                              final isFilled = starIndex < rating;
                              return GestureDetector(
                                onTap: () {
                                  // Здесь нужно будет реализовать логику обновления рейтинга
                                  // Например, через колбэк или стейт-менеджмент
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    isFilled
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color:
                                        isFilled
                                            ? Colors.orange
                                            : Colors.orange.withOpacity(0.5),
                                    size: 16,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Text(
                    excursion.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          // Остальной код остается без изменений
        ],
      ),
    );
  }
}

class CustomBackgroundWithGradient extends StatelessWidget {
  final Widget child;

  const CustomBackgroundWithGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: child,
        ),
      ),
    );
  }
}

class FirstCard extends StatelessWidget {
  final Excursion excursion;
  final int rating;
  final int index;
  final BuildContext context;

  const FirstCard({
    Key? key,
    required this.excursion,
    required this.rating,
    required this.index,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 44),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: Image.asset(
                    excursion.imageUrl,
                    height: 375,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Row(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text(
                            excursion.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (starIndex) {
                              final isFilled = starIndex < rating;
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    isFilled
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color:
                                        isFilled
                                            ? Colors.orange
                                            : Colors.orange.withOpacity(0.5),
                                    size: 16,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Text(
                    excursion.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 80,
            child: ListView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildCharacteristicCircle(),
                SizedBox(width: 24),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
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
                  padding: const EdgeInsets.only(left: 47),
                  child: Text(
                    ' 30 € ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF Pro Display",
                      color: BaseColors.accent,
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
        ],
      ),
    );
  }

  Widget _buildCharacteristicCircle() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 241, 244),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        "assets/file/menu.svg",
        color: Color.fromARGB(255, 85, 97, 178),
      ),
    );
  }
}
