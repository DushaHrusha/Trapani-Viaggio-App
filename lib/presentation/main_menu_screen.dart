import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_background_with_image.dart';
import 'package:test_task/core/constants/custom_gradient_button.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/presentation/circular_menu_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomBackgroundWithImage(
        image: Image.asset(
          'assets/file/city_header.jpg',
          height: context.adaptiveSize(400),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        children: [
          SizedBox(height: context.adaptiveSize(38)),
          Text(
            'Hello. Welcome to Trapani!',
            textAlign: TextAlign.center,
            style: context.adaptiveTextStyle(
              fontSize: 22,
              fontFamily: 'Berlin Sans FB',
              fontWeight: FontWeight.w400,
              color: BaseColors.text,
            ),
          ),
          SizedBox(height: context.adaptiveSize(16)),
          Container(
            margin: context.adaptivePadding(
              EdgeInsets.symmetric(horizontal: 30),
            ),
            child: Text(
              'Place with a lively atmosphere due to its position as the capital and its economic activities as a port.',
              textAlign: TextAlign.center,
              style: context.adaptiveTextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: BaseColors.text,
              ),
            ),
          ),
          SizedBox(height: context.adaptiveSize(40)),
          Padding(
            padding: context.adaptivePadding(
              EdgeInsets.symmetric(horizontal: 30),
            ),
            child: const CustomGradientButton(
              text: 'Services',
              path: CircularMenuScreen(),
            ),
          ),

          SizedBox(height: context.adaptiveSize(32)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.adaptiveSize(30.0),
            ),
            child: GreyLine(),
          ),
          SizedBox(height: context.adaptiveSize(32)),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: context.adaptiveSize(23),
            crossAxisSpacing: context.adaptiveSize(23),
            padding: context.adaptivePadding(
              EdgeInsets.symmetric(horizontal: 30),
            ),
            childAspectRatio: 2.6,
            children: [
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  "assets/file/exclamation.svg",
                  color: BaseColors.secondary,
                  width: context.adaptiveSize(24),
                  height: context.adaptiveSize(24),
                ),
                label: 'City info',
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  "assets/file/paths.svg",
                  color: BaseColors.secondary,
                  width: context.adaptiveSize(24),
                  height: context.adaptiveSize(24),
                ),
                label: 'Places',
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  "assets/file/star.svg",
                  color: BaseColors.secondary,
                  width: context.adaptiveSize(24),
                  height: context.adaptiveSize(24),
                ),
                label: 'Events',
              ),
              _buildGridButton(
                context,
                icon: SvgPicture.asset(
                  "assets/file/gallery.svg",
                  color: BaseColors.secondary,
                  width: context.adaptiveSize(24),
                  height: context.adaptiveSize(24),
                ),
                label: 'Gallery',
              ),
            ],
          ),

          SizedBox(height: context.adaptiveSize(30)),
        ],
      ),
      bottomNavigationBar: BottomBar(currentScreen: widget),
    );
  }

  Widget _buildGridButton(
    BuildContext context, {
    required Widget icon,
    required String label,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(0, 1, 1, 1),
        backgroundColor: BaseColors.backgroundCircles,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.adaptiveSize(32)),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: context.adaptiveSize(13)),
          Text(
            label,
            style: context.adaptiveTextStyle(
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
