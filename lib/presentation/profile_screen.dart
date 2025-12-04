// lib/presentation/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/auth_cubit.dart';
import 'package:test_task/user_model.dart';

import '../core/adaptive_size_extension.dart';
import '../core/constants/base_colors.dart';
import '../core/constants/bottom_bar.dart';
import '../core/constants/custom_app_bar.dart';
import '../core/constants/custom_background_with_gradient.dart';
import '../core/constants/grey_line.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/sign-up');
        }
      },
      builder: (context, state) {
        if (state is! AuthAuthenticated) {
          return _buildUnauthenticatedView(context);
        }

        final user = state.user;

        return Scaffold(
          backgroundColor: BaseColors.background,
          body: CustomBackgroundWithGradient(
            child: Column(
              children: [
                const CustomAppBar(label: "Profile"),
                const GreyLine(),
                SizedBox(height: context.adaptiveSize(32)),
                _buildProfileHeader(context, user),
                Expanded(child: _buildMenuList(context)),
              ],
            ),
          ),
          bottomNavigationBar: const BottomBar(currentScreen: ProfileScreen()),
        );
      },
    );
  }

  Widget _buildUnauthenticatedView(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            const CustomAppBar(label: "Profile"),
            const GreyLine(),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(context.adaptiveSize(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: context.adaptiveSize(80),
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: context.adaptiveSize(24)),
                      Text(
                        'Sign in to access your profile',
                        style: context.adaptiveTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: BaseColors.text,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.adaptiveSize(12)),
                      Text(
                        'View your bookings, manage settings, and more',
                        style: context.adaptiveTextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.adaptiveSize(32)),
                      SizedBox(
                        width: double.infinity,
                        height: context.adaptiveSize(50),
                        child: ElevatedButton(
                          onPressed: () => context.go('/sign-up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BaseColors.accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.adaptiveSize(25),
                              ),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: context.adaptiveTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
      bottomNavigationBar: const BottomBar(currentScreen: ProfileScreen()),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'profile_avatar',
            child: CircleAvatar(
              radius: context.adaptiveSize(36),
              backgroundColor: BaseColors.accent.withOpacity(0.1),
              backgroundImage:
                  user.hasAvatar ? NetworkImage(user.avatar!) : null,
              child:
                  !user.hasAvatar
                      ? Text(
                        user.initials,
                        style: context.adaptiveTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: BaseColors.accent,
                        ),
                      )
                      : null,
            ),
          ),
          SizedBox(height: context.adaptiveSize(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: context.adaptiveTextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: BaseColors.text,
                ),
              ),
              SizedBox(height: context.adaptiveSize(4)),
              Text(
                user.displayIdentifier,
                style: context.adaptiveTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              // Provider badge
              Padding(
                padding: EdgeInsets.only(top: context.adaptiveSize(8)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.adaptiveSize(12),
                    vertical: context.adaptiveSize(4),
                  ),
                  decoration: BoxDecoration(
                    color: _getProviderColor(user.provider).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      context.adaptiveSize(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getProviderIcon(user.provider),
                        size: context.adaptiveSize(16),
                        color: _getProviderColor(user.provider),
                      ),
                      SizedBox(width: context.adaptiveSize(4)),
                      Text(
                        _getProviderLabel(user.provider),
                        style: context.adaptiveTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getProviderIcon(String? provider) {
    switch (provider) {
      case 'google':
        return Icons.g_mobiledata;
      case 'apple':
        return Icons.apple;
      case 'phone':
        return Icons.phone_android;
      default:
        return Icons.person;
    }
  }

  Color _getProviderColor(String? provider) {
    switch (provider) {
      case 'google':
        return Colors.blue;
      case 'apple':
        return Colors.black;
      case 'phone':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getProviderLabel(String? provider) {
    switch (provider) {
      case 'google':
        return 'Signed in with Google';
      case 'apple':
        return 'Signed in with Apple';
      case 'phone':
        return 'Signed in with Phone';
      default:
        return 'Signed in';
    }
  }

  Widget _buildMenuList(BuildContext context) {
    final menuItems = [
      {'title': 'Personal information', 'icon': Icons.person_outline},
      {'title': 'Payment method', 'icon': Icons.payment_outlined},
      {'title': 'Booking history', 'icon': Icons.history_outlined},
      {'title': 'Bookmarks', 'icon': Icons.bookmark_outline},
      {'title': 'Online assistant', 'icon': Icons.chat_bubble_outline},
      {'title': 'Settings', 'icon': Icons.settings_outlined},
      {'title': 'Log Out', 'icon': Icons.logout_rounded, 'isLogout': true},
    ];

    return ListView.separated(
      padding: EdgeInsets.only(top: context.adaptiveSize(40)),
      itemCount: menuItems.length,
      separatorBuilder:
          (context, index) => Padding(
            padding: context.adaptivePadding(
              const EdgeInsets.symmetric(horizontal: 30),
            ),
            child: const GreyLine(),
          ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isLogout = item['isLogout'] == true;

        return Padding(
          padding: context.adaptivePadding(
            const EdgeInsets.symmetric(horizontal: 30),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 0,
            ),
            leading: Icon(
              item['icon'] as IconData,
              size: context.adaptiveSize(22),
              color: isLogout ? Colors.red : BaseColors.text,
            ),
            title: Text(
              item['title'] as String,
              style: context.adaptiveTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : BaseColors.text,
              ),
            ),
            trailing:
                isLogout
                    ? null
                    : Icon(
                      Icons.arrow_forward_ios,
                      size: context.adaptiveSize(14),
                      color: const Color.fromARGB(255, 189, 189, 189),
                    ),
            onTap: () {
              if (isLogout) {
                _showLogoutDialog(context);
              } else {
                _handleMenuTap(context, item['title'] as String);
              }
            },
          ),
        );
      },
    );
  }

  void _handleMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'Personal information':
        // context.push('/profile/personal');
        break;
      case 'Payment method':
        // context.push('/profile/payment');
        break;
      case 'Booking history':
        context.push('/booking-history');
        break;
      case 'Bookmarks':
        context.push('/bookmarks');
        break;
      case 'Online assistant':
        context.push('/chat');
        break;
      case 'Settings':
        // context.push('/profile/settings');
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.adaptiveSize(16)),
            ),
            title: Text(
              'Log Out',
              style: context.adaptiveTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: BaseColors.text,
              ),
            ),
            content: Text(
              'Are you sure you want to log out?',
              style: context.adaptiveTextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  'Cancel',
                  style: context.adaptiveTextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.read<AuthCubit>().logout();
                },
                child: Text(
                  'Log Out',
                  style: context.adaptiveTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
