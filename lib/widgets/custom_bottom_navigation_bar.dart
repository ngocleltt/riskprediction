import 'package:flutter/material.dart';
import 'package:riskprediction/screens/home_screen.dart';
import 'package:riskprediction/screens/user_screen.dart';
import 'package:riskprediction/screens/settings_screen.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/app_localizations.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(onLocaleChange: onLocaleChange, currentLocale: currentLocale)),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(onLocaleChange: onLocaleChange, currentLocale: currentLocale)),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserScreen(onLocaleChange: onLocaleChange, currentLocale: currentLocale)),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen(onLocaleChange: onLocaleChange, currentLocale: currentLocale)),
            );
            break;
        }
      },
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
            Icons.camera_alt,
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
