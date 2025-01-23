import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const BottomNavigationBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabChange,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: 'assets/images/home.png',
              label: 'Home',
              isSelected: selectedIndex == 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: 'assets/images/pay.png',
              label: 'Ekub',
              isSelected: selectedIndex == 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
              iconPath: 'assets/images/setting.png',
              label: 'Setting',
              isSelected: selectedIndex == 2,
            ),
            label: '',
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    final selectedColor = const Color(0xFF1A3552);
    final unselectedColor = Colors.grey.shade400;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isSelected ? 8 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: isSelected ? 28 : 24,
            width: isSelected ? 28 : 24,
            child: Image.asset(
              iconPath,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
