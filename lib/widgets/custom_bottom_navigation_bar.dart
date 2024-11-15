import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Color(0xFFFBB127),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentIndex == 0 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: currentIndex == 1 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: currentIndex == 2 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: currentIndex == 3 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: '',
        ),
      ],
    );
  }
}
