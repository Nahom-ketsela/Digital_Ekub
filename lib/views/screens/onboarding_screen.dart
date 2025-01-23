import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart'; 

class OnboardingScreen extends StatefulWidget {
   static String route = 'onboarding-screen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  Timer? _autoSlideTimer;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Automatic sliding timer is handled by CarouselSlider's autoPlay functionality
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.55, // Adjust height based on screen size
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100), // Adjusted padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLottieAnimation(
                          _currentIndex, screenHeight), // Lottie animation
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.45, // Adjust height based on screen size
              child: SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPageIndicator(),
                      Expanded(
                        child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _getTitleForIndex(index),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _getDescriptionForIndex(index),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: screenWidth * 0.04,
                                    height: 1.5,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                            height: screenHeight * 0.55,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            enlargeCenterPage: true,
                            viewportFraction:
                                1.0, // Ensures only one card is shown at a time
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('Login', screenWidth, 'login-page'),
                          _buildButton('Sign up', screenWidth, 'signup-page'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, double screenWidth, String routeName) {
    return Flexible(
      flex: 3,
      child: Container(
        width: screenWidth * 0.35,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(routeName);
            box.write('onboardingCompleted', true);
          },
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              height: 20 / 14,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFEEEFF0),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ).copyWith(
            side: MaterialStateProperty.all(
              BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to return title based on index
  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Become a Force for Good with Abugida';
      case 1:
        return 'Save, Contribute, and improve yourself';
      case 2:
        return 'Together for a Better World';
      default:
        return '';
    }
  }

  // Helper method to return description based on index
  String _getDescriptionForIndex(int index) {
    switch (index) {
      case 0:
        return 'Join Us in Changing Lives and making a smile :)';
      case 1:
        return 'Learn how you can save money while contributing to meaningful charitable causes with Abugida.';
      case 2:
        return 'Experience the power of collaboration as we work together to support charity and achieve success.';
      default:
        return '';
    }
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 6.0,
          width: _currentIndex == index ? 24.0 : 6.0,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(3.0),
          ),
        );
      }),
    );
  }

  Widget _buildLottieAnimation(int index, double screenHeight) {
    double animationHeight = screenHeight * 0.35;
    switch (index) {
      case 0:
        return Image.asset(
          'assets/images/first.png',
          height: animationHeight,
        );
      case 1:
        return Lottie.network(
          'https://lottie.host/9551618d-b30d-4977-b5b1-b583b8e042e9/16w0pk9k1I.json',
          height: animationHeight,
        );
      case 2:
        return Lottie.network(
          'https://lottie.host/e47707ba-2981-4d0d-88d8-fb05a1ce2db5/snjbC2hNhc.json',
          height: animationHeight,
        );
      default:
        return SizedBox.shrink();
    }
  }
}
