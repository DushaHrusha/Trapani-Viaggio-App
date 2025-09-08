import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_task/app_cubit.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/custom_app_bar.dart';
import 'package:test_task/custom_background_with_gradient.dart';

class ApartmensDetailScreen extends StatefulWidget {
  final Apartments apartments;

  const ApartmensDetailScreen({super.key, required this.apartments});

  @override
  State<ApartmensDetailScreen> createState() => _ApartmensDetailScreenState();
}

class _ApartmensDetailScreenState extends State<ApartmensDetailScreen> {
  final PageController _pageController = PageController();
  late int displayedIconsCount;
  int _currentPage = 0;
  final List<IconData> icons = [
    Icons.wifi,
    Icons.map,
    Icons.luggage,
    Icons.edit,
    Icons.wb_sunny,
    Icons.pets,
    Icons.smoke_free,
  ];
  bool showAllIcons = false;
  @override
  void initState() {
    super.initState();
    displayedIconsCount = showAllIcons ? icons.length : 5;

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index
                    ? BaseColors.accent
                    : BaseColors.background,
          ),
        );
      }),
    );
  }
  // Список иконок

  // Контроллер для прокрутки
  final ScrollController _scrollController = ScrollController();
  final MapController _mapController = MapController();
  final LatLng _targetLocation = LatLng(
    55.0084,
    82.9348,
  ); // Замените на нужные координаты
  // Текущая позиция прокрутки
  int _currentPage1 = 0;

  // Метод прокрутки вправо
  void _scrollRight() {
    setState(() {
      if (_currentPage1 < icons.length - 5) {
        _currentPage1++;
        _scrollController.animateTo(
          _currentPage1 * 80.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Метод прокрутки влево
  void _scrollLeft() {
    setState(() {
      if (_currentPage1 > 0) {
        _currentPage1--;
        _scrollController.animateTo(
          _currentPage1 * 80.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            CustomAppBar(lable: "Apartmens"),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color.fromARGB(1, 255, 38, 0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BaseColors.primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                bottomLeft: Radius.circular(32),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "19 -21 Aug `20",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Правая часть
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BaseColors.primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "2 adualts + 1 child",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            child: SizedBox(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    "assets/file/images.jpg",
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 24,
                            top: 24,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(
                                  87,
                                  255,
                                  255,
                                  255,
                                ), // Полупрозрачный цвет
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5.0,
                                    sigmaY: 5.0,
                                  ), // Эффект размытия
                                  child: Icon(
                                    Icons.bookmark_outline,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: _buildIndicator(
                              widget.apartments.imageUrl.length,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Orizzonte Mare Beachside Suites",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Per night:",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "139 ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Close to the sea apartment complex. Broadly speaking, a hotel is a managed building or establishment, which provides guests with a place to stay overnight – on a short-term basis", // Замените на правильный текст
                        style: TextStyle(
                          fontSize: 12,
                          color: BaseColors.primary,
                        ),
                      ),
                      SizedBox(height: 21),
                    ],
                  ),
                  Row(
                    children: [
                      // Кнопка влево (показывается только если не в начале)
                      if (_currentPage1 > 0)
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: _scrollLeft,
                        ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: icons.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 12),
                                height: 48,
                                width: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: BaseColors.primary,
                                    width: 1,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color.fromARGB(0, 1, 1, 1),
                                  child: Icon(
                                    icons[index],
                                    color: BaseColors.text,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (_currentPage1 < icons.length - 5)
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 12),
                          onPressed: _scrollRight,
                        ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(height: 0),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("8.6"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (starIndex) {
                              final isFilled = starIndex < 5;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  isFilled
                                      ? Icons.star
                                      : Icons.star_border_outlined,
                                  color:
                                      isFilled
                                          ? BaseColors.accent
                                          : Colors.orange.withOpacity(0.5),
                                  size: 16,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("121 guest reviews"),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios, size: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Divider(height: 0),
                  SizedBox(
                    height: 180,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          51.509364,
                          -0.128928,
                        ), // Center the map over London
                        initialZoom: 9.2,
                      ),
                      children: [
                        TileLayer(
                          // Bring your own tiles
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                          userAgentPackageName:
                              'com.example.app', // Add your app identifier
                          // And many more recommended properties!
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.apartments.imageUrl[0]),
                        SizedBox(height: 16),
                        Text(
                          widget.apartments.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(widget.apartments.description),
                        SizedBox(height: 8),
                        Text(
                          'Price: ${widget.apartments.price} €',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
