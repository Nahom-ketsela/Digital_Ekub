import 'package:flutter/material.dart';
import 'package:ekub/views/pages/spinWheel_page.dart';
import 'package:ekub/views/pages/lostpersondetail_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAmountHidden = true;
  int _currentIndex = 0;

  // List of Lost Persons data
  final List<Map<String, dynamic>> lostPersons = [
    {'id': 1, 'name': 'Alex Daniel', 'age': 5, 'lostDate': 'Sep 12, 2023'},
    {'id': 2, 'name': 'Elsa Daniel', 'age': 3, 'lostDate': 'Nov 12, 2023'},
  ];

  final List<String> _dates = [
    'Mar 18, 2024',
    'Apr 22, 2024',
    'May 15, 2024',
  ];

  final List<String> _titles = [
    'Ekub Announcement Group 10 birr',
    'Ekub Announcement Group 2k birr',
    'Ekub Announcement Group 500 birr',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
      
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 200.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      SizedBox(
                    height: 16
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton(
                        icon: 'assets/images/heart.png',
                        text: 'Donate',
                        onTap: () {
                          Get.toNamed('donate-page');
                        },
                      ),
                      SizedBox(width: 10),
                      _buildButton(
                        icon: 'assets/images/lost.png',
                        text: 'Lost People',
                        onTap: () {
                          Get.toNamed('lostpeople-page');
                        },
                      ),
                      SizedBox(width: 10),
                      _buildButton(
                        icon: 'assets/images/pay.png',
                        text: 'Lottery',
                        onTap: () {
                          //  Get.toNamed('');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Ekub Announcement Carousel
                  _buildAnnouncementCarousel(),

                  SizedBox(height: 20),

                  // Lost People Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lost people',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Lost People Cards in ListView.builder
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lostPersons.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _buildLostPersonCard(
                            context: context,
                            id: lostPersons[index]['id'],
                            name: lostPersons[index]['name'],
                            age: lostPersons[index]['age'],
                            lostDate: lostPersons[index]['lostDate'],
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: 20),

                  // // Lottery Card
                  // _buildLotteryCard(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
             padding: EdgeInsets.fromLTRB(16, 30, 16, 30),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A3552), Color(0xFF3A77B8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligns the Row contents to the start
                          children: [
                            // Adding spacing between the icon and the text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Aligns the Column contents to the start
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Aligns the Row contents to the start
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Ethiopia, Addis Ababa',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Abebech Daniel',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed('settings-page');
                        //   },
                        //   child: Image.asset(
                        //     'assets/images/setting.png',
                        //     width: 24,
                        //     height: 24,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align children to the start
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ekub Amount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Use a SizedBox to ensure the height of the Row is consistent
                              SizedBox(
                                height: 24, // Adjust the height as needed
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Align vertically
                                  children: [
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit
                                            .scaleDown, // Adjusts content size to fit
                                        child: Text(
                                          _isAmountHidden
                                              ? '*****'
                                              : '100,000.0 ETB',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Handles overflow
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            4), // Space between text and icon
                                    IconButton(
                                      icon: Icon(
                                        _isAmountHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                        size: 16, // Consistent icon size
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isAmountHidden = !_isAmountHidden;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ekub Points',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 24,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '20 pts',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, height: 20),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _dates.length,
          itemBuilder: (context, index, realIndex) {
            return _buildAnnouncementCard(_titles[index], _dates[index]);
          },
          options: CarouselOptions(
            height: 120.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 8.0),
        _buildDotIndicators(),
      ],
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _dates.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(String title, String date) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLostPersonCard({
    required BuildContext context,
    required int id,
    required String name,
    required int age,
    required String lostDate,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Container(
        
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[400]!,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: $name',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                        fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Age: $age years old',
                    style: TextStyle(
                      color: Colors.black54,
                        fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lost Date: $lostDate',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LostPersonDetailPage(id: id),
                        ),
                      );
                    },
                    child: Text(
                      'View more',
                      style: TextStyle(
                        color: Color(0xFF3A77B8),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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

  // Widget _buildLotteryCard() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SpinWheelPage()),
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black12,
  //             blurRadius: 10,
  //             spreadRadius: 2,
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Image.asset(
  //             'assets/images/wheel.png',
  //             width: 100,
  //             height: 100,
  //           ),
  //           SizedBox(width: 20),
  //           Expanded(
  //             child: Text(
  //               'Spin the wheel to win your lottery',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
