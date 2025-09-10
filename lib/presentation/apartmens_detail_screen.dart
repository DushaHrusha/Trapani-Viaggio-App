import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';
import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/presentation/dates_guests_screen.dart';

class ApartmentsDetailScreenDetailScreen extends StatefulWidget {
  final Apartment apartments;

  const ApartmentsDetailScreenDetailScreen({
    super.key,
    required this.apartments,
  });

  @override
  State<ApartmentsDetailScreenDetailScreen> createState() =>
      _ApartmentsDetailScreenDetailScreenState();
}

class _ApartmentsDetailScreenDetailScreenState
    extends State<ApartmentsDetailScreenDetailScreen> {
  final PageController _pageController = PageController();
  late int displayedIconsCount;
  int _currentPage = 0;
  final List<IconData> icons = [
    CupertinoIcons.wifi,
    CupertinoIcons.map,
    Icons.luggage,
    Icons.edit,
    Icons.wb_sunny,
    Icons.pets,
    Icons.smoke_free,
  ];
  bool showAllIcons = false;
  late final Apartment _apartment;
  final ScrollController _scrollController = ScrollController();
  final MapController _mapController = MapController();
  final LatLng _targetLocation = LatLng(55.0084, 82.9348);
  int _currentPage1 = 0;

  @override
  void initState() {
    super.initState();
    displayedIconsCount = showAllIcons ? icons.length : 5;
    _apartment = widget.apartments;
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
            CustomAppBar(label: "apartments"),
            Divider(height: 0),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DatesGuestsScreen(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color.fromARGB(1, 255, 38, 0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BaseColors.line,
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
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BaseColors.line,
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
                  ),
                  SizedBox(height: 16),
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
                                itemCount: _apartment.imageUrl.length,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    _apartment.imageUrl[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 16,
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(87, 255, 255, 255),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5.0,
                                    sigmaY: 5.0,
                                  ),
                                  child: Icon(
                                    Icons.bookmark_outline,
                                    color: Color.fromARGB(255, 251, 251, 253),
                                    size: 25,
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
                              _apartment.title,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                fontFamily: "SF Pro Display",
                                color: BaseColors.text,
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
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SF Pro Display",
                                    color: BaseColors.text,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _apartment.price.toString(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "SF Pro Display",
                                        color: BaseColors.text,
                                      ),
                                    ),
                                    Text(
                                      " €",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "SF Pro Display",
                                        color: BaseColors.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        _apartment.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 21),
                  Row(
                    children: [
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
                            itemCount: _apartment.iconServices.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 12),
                                height: 48,
                                width: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    width: 1,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color.fromARGB(0, 1, 1, 1),
                                  child: Icon(
                                    _apartment.iconServices[index],
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
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                          onPressed: _scrollRight,
                        ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(height: 0),
                  SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _apartment.rating.toString(),
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.accent,
                            ),
                          ),
                          SizedBox(width: 6),
                          StarRating(rating: _apartment.rating),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${_apartment.numberReviews} guest reviews",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro Display",
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 27),
                  Divider(height: 0),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: FlutterMap(
                        mapController: MapController(),
                        options: MapOptions(
                          initialCenter: LatLng(
                            51.509364,
                            -0.128928,
                          ), // Center the map over London
                          initialZoom: 9,
                        ),
                        children: [
                          TileLayer(
                            // Bring your own tiles
                            urlTemplate:
                                'https://tile.openstreetmap.org/{zoom}/{x}/{y}.png', // For demonstration only
                            userAgentPackageName:
                                'com.example.app', // Add your app identifier
                            minZoom: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address:',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      Container(
                        width: 167,
                        child: Text(
                          _apartment.address,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "SF Pro Display",
                            color: Color.fromARGB(255, 109, 109, 109),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomTextFieldWithGradientButton(
                    text: "278 € / 2 days",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF Pro Display",
                      color: BaseColors.text,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(currentScreen: widget),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final filledStars = (rating / 2).round().clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (starIndex) {
        final isFilled = starIndex < filledStars;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_border_rounded,
            color: BaseColors.accent,
            size: 17,
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Рейтинг звезд')),
        body: Center(child: StarRating(rating: 7)),
      ),
    ),
  );
}
