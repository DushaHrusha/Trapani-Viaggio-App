import 'package:flutter/material.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/grey_line.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            CustomAppBar(label: "profile"),
            GreyLine(),
            SizedBox(height: context.adaptiveSize(32)),
            _buildProfileHeader(context),
            Expanded(child: _buildMenuList(context)),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentScreen: ProfileScreen()),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: context.adaptiveSize(36),
            backgroundImage: AssetImage("assets/file/volga.jpg"),
          ),
          SizedBox(height: context.adaptiveSize(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Alex',
                style: context.adaptiveTextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: BaseColors.text,
                  fontFamily: "SF Pro Display",
                ),
              ),
              Text(
                'Moscow, Russia',
                style: context.adaptiveTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: BaseColors.text,
                  fontFamily: "SF Pro Display",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final menuItems = [
      {'title': 'Personal information'},
      {'title': 'Payment method'},
      {'title': 'Booking history'},
      {'title': 'Bookmarks'},
      {'title': 'Online assistant'},
      {'title': 'Settings'},
      {'title': 'Log Out'},
    ];

    return ListView.separated(
      padding: EdgeInsets.only(top: context.adaptiveSize(40)),
      itemCount: menuItems.length,
      separatorBuilder:
          (context, index) => Padding(
            padding: context.adaptivePadding(
              EdgeInsets.symmetric(horizontal: 30),
            ),
            child: GreyLine(),
          ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Padding(
          padding: context.adaptivePadding(
            EdgeInsets.symmetric(horizontal: 30),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            title: Text(
              item['title'] as String,
              style: context.adaptiveTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: BaseColors.text,
                fontFamily: "SF Pro Display",
              ),
            ),
            trailing:
                index == menuItems.length - 1
                    ? Icon(
                      Icons.logout_rounded,
                      size: context.adaptiveSize(16),
                      color: BaseColors.text,
                    )
                    : Icon(
                      Icons.arrow_forward_ios,
                      size: context.adaptiveSize(14),
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

extension AdaptiveSizeExtension on BuildContext {
  static const baseWidth = 390.0;
  static const baseHeight = 844.0;

  double get widthRatio => MediaQuery.of(this).size.width / baseWidth;
  double get heightRatio => MediaQuery.of(this).size.height / baseHeight;

  // Метод для получения адаптивного размера
  double adaptiveSize(
    double baseSize, {
    bool useWidth = true,
    double? maxSize,
    double? minSize,
  }) {
    double adaptedSize = baseSize * (useWidth ? widthRatio : heightRatio);

    // Опциональное ограничение размера
    if (maxSize != null) {
      adaptedSize = adaptedSize > maxSize ? maxSize : adaptedSize;
    }

    if (minSize != null) {
      adaptedSize = adaptedSize < minSize ? minSize : adaptedSize;
    }

    return adaptedSize;
  }

  // Получение адаптивных отступов
  EdgeInsets adaptivePadding(EdgeInsets basePadding, {bool useWidth = true}) {
    return EdgeInsets.only(
      left: adaptiveSize(basePadding.left, useWidth: useWidth),
      right: adaptiveSize(basePadding.right, useWidth: useWidth),
      top: adaptiveSize(basePadding.top, useWidth: useWidth),
      bottom: adaptiveSize(basePadding.bottom, useWidth: useWidth),
    );
  }

  // Получение адаптивного TextStyle
  TextStyle adaptiveTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: adaptiveSize(fontSize),
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }
}
