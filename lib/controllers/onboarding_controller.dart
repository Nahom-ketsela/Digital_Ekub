import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ekub/views/auth/login_page.dart';
import 'package:ekub/core/constants/colors.dart';
import 'package:ekub/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final box = GetStorage();
  int currentPage = 0;
  bool _isNavigating = false; 

  final List<OnboardingContent> onboardingData = [
    OnboardingContent(
      imagePath: 'assets/images/first.png',
      title: 'Become a Force for Good with Abugida',
      description: 'Join Us in Changing Lives and making a smile :)',
    ),
    OnboardingContent(
      imagePath: 'https://lottie.host/9551618d-b30d-4977-b5b1-b583b8e042e9/16w0pk9k1I.json',
      title: 'Save ,Contribute and improve yourself',
      description:
          'Learn how you can save money while contributing to meaningful charitable causes with Abugida.',
    ),
    OnboardingContent(
      imagePath: 'https://lottie.host/e47707ba-2981-4d0d-88d8-fb05a1ce2db5/snjbC2hNhc.json',
      title: 'Together for a Better World',
      description:
          'Experience the power of collaboration as we work together to support charity and achieve success.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void navigateToLogin() {
    if (_isNavigating) return;
    _isNavigating = true;
    box.write('onboardingCompleted', true);
    Future.delayed(Duration(milliseconds: 300), () {
      Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
    })
        .whenComplete(() => _isNavigating = false);
  }

  Widget buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: currentPage == index ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Color(0xFF1A3552)
            : AppColors.textColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
