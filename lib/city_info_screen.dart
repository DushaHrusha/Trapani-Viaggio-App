import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/bottom_bar.dart';
import 'package:test_task/car_catalog.dart';
import 'package:test_task/custom_background_with_image.dart';
import 'package:test_task/custom_gradient_button.dart';

class CityInfoScreen extends StatelessWidget {
  const CityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomBackgroundWithImage(
        image: Image.asset(
          'assets/file/city_header.jpg',
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        children: [
          SizedBox(height: 38),
          Text(
            'Hello. Welcome to Trapani!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Berlin Sans FB',
              fontWeight: FontWeight.w400,
              color: BaseColors.text,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Place with a lively atmosphere due to its position as the capital and its economic activities as a port.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'San Francisco Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: BaseColors.text,
              ),
            ),
          ),
          SizedBox(height: 40),
          CustomGradientButton(),
          SizedBox(height: 32),
          Divider(height: 1, color: Colors.grey[300], thickness: 1),
          SizedBox(height: 32),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 23,
            crossAxisSpacing: 23,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            childAspectRatio: 2.6,
            children: [
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  'assets/file/home.svg',
                  color: BaseColors.secondary,
                ),
                label: 'City info',
                path: CarCatalog(),
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  'assets/file/home.svg',
                  color: BaseColors.secondary,
                ),
                label: 'Places',
                path: CarCatalog(),
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  'assets/file/home.svg',
                  color: BaseColors.secondary,
                ),
                label: 'Events',
                path: CarCatalog(),
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  'assets/file/home.svg',
                  color: BaseColors.secondary,
                ),
                label: 'Gallery',
                path: CarCatalog(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildGridButton(
    BuildContext context, {
    required SvgPicture icon,
    required String label,
    required Widget path,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Color.fromARGB(0, 1, 1, 1),
        backgroundColor: BaseColors.backgroundCircles,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => path),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/file/home.svg',
            color: BaseColors.secondary,
            height: 24,
          ),
          const SizedBox(width: 13),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'San Francisco Pro Display',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: BaseColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
