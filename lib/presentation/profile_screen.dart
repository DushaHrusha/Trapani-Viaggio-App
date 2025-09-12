import 'package:flutter/material.dart';
import 'package:test_task/presentation/chat_screen.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/presentation/main_menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _appBarFadeAnimation;

  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..forward();

    _appBarFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.3, curve: Curves.easeInOut),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.8, curve: Curves.easeOutQuad),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            FadeTransition(
              opacity: _appBarFadeAnimation,
              child: const CustomAppBar(
                label: "profile",
                returnPage: MainMenuScreen(),
              ),
            ),
            const GreyLine(),
            SizedBox(height: context.adaptiveSize(32)),
            _buildAnimatedProfileHeader(context),
            Expanded(child: _buildAnimatedMenuList(context)),
          ],
        ),
      ),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: const BottomBar(currentScreen: ProfileScreen()),
        ),
      ),
    );
  }

  Widget _buildAnimatedProfileHeader(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'profile_avatar',
              child: CircleAvatar(
                radius: context.adaptiveSize(36),
                backgroundImage: AssetImage('assets/file/avatars/me.jpg'),
              ),
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
      ),
    );
  }

  Widget _buildAnimatedMenuList(BuildContext context) {
    final menuItems = [
      {'title': 'Personal information'},
      {'title': 'Payment method'},
      {'title': 'Booking history'},
      {'title': 'Bookmarks'},
      {'title': 'Online assistant'},
      {'title': 'Settings'},
      {'title': 'Log Out'},
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ListView.separated(
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
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
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
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) => ChatScreen(),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: FadeTransition(
                            opacity: Tween<double>(
                              begin: 1.0,
                              end: 0.0,
                            ).animate(secondaryAnimation),
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
