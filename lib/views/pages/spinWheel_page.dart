import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';

class SpinWheelPage extends StatefulWidget {
  @override
  _SpinWheelPageState createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  final List<String> items = [
    'Phone',
    'Washing Machine',
    'TV',
    'Laptop',
    '10,000 Birr',
    'Please Try Again',
  ];

  int selectedIndex = -1;

  final StreamController<int> _controller = StreamController<int>();

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void spinWheel() {
    setState(() {
      selectedIndex = Random().nextInt(items.length);

      _controller.add(selectedIndex);
    });
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You Won!"),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spin the Wheel"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FortuneWheel(
              selected: _controller.stream,
              items: [
                FortuneItem(
                  child: Text(items[0]),
                  style: FortuneItemStyle(
                    color: Color.fromARGB(255, 245, 231, 101),
                  ),
                ),
                FortuneItem(
                  child: Text(items[1]),
                  style: FortuneItemStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                FortuneItem(
                  child: Text(items[2]),
                  style: FortuneItemStyle(
                    color: Colors.lightGreen,
                  ),
                ),
                FortuneItem(
                  child: Text(items[3]),
                  style: FortuneItemStyle(
                    color: Color.fromARGB(255, 247, 98, 98),
                  ),
                ),
                FortuneItem(
                  child: Text(items[4]),
                  style: FortuneItemStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                FortuneItem(
                  child: Text(items[5]),
                  style: FortuneItemStyle(
                    color: Colors.lightGreen,
                  ),
                ),
              ],
              onAnimationEnd: () {
                _showResultDialog(items[selectedIndex]);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                spinWheel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A3552),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
              child: Text(
                "Spin It",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
