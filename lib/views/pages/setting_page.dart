import 'package:ekub/views/auth/login_page.dart';
import 'package:ekub/views/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends StatelessWidget {
  static String route = 'settings-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          _buildSettingTile(
            context,
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Get.toNamed('profile-page');
            },
          ),
          _buildSettingTile(
            context,
            icon: Icons.settings,
            title: 'General Settings',
            onTap: () {
              Get.toNamed('generalsettings-page');
            },
          ),
          _buildSettingTile(
            context,
            icon: Icons.security,
            title: 'Privacy Settings',
            onTap: () {
              Get.toNamed('privacysettings-page');
            },
          ),
          _buildSettingTile(
            context,
            icon: Icons.help_outline,
            title: 'Help and About',
            onTap: () {
              Get.toNamed('helpabout-page');
            },
          ),
          _buildSettingTile(
            context,
            icon: Icons.logout,
            title: 'Log Out',
            onTap: () {
              handleSignOut(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context,
      {required IconData icon,
      required String title,
      required Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing:
          Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
      onTap: onTap,
    );
  }

  void handleSignOut(BuildContext context) {
    final GetStorage storage = GetStorage();
    try {
      storage.remove('loggedIn');
      storage.remove('onboardingCompleted');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully signed out')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $error')),
      );
    }
  }
}
