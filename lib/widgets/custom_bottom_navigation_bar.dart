import 'package:flutter/material.dart';
import 'package:riskprediction/screens/home_screen.dart';
import 'package:riskprediction/screens/reports/report.dart';
import 'package:riskprediction/screens/settings/settings_screen.dart';
import 'package:riskprediction/screens/user_screen.dart';
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
        if (currentIndex != index) {
          onTap(index);
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    onLocaleChange: onLocaleChange,
                    currentLocale: currentLocale,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportScreen(
                    onLocaleChange: onLocaleChange,
                    currentLocale: currentLocale,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(
                    onLocaleChange: onLocaleChange,
                    currentLocale: currentLocale,
                  ),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    onLocaleChange: onLocaleChange,
                    currentLocale: currentLocale,
                  ),
                ),
              );
              break;
          }
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
          label: AppLocalizations.of(context)?.translate('home') ?? 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.report,
            color: currentIndex == 1 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: AppLocalizations.of(context)?.translate('report') ?? 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: currentIndex == 2 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: AppLocalizations.of(context)?.translate('user') ?? 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: currentIndex == 3 ? Color(0xFFFBB127) : Colors.grey,
          ),
          label: AppLocalizations.of(context)?.translate('settings') ?? 'Settings',
        ),
      ],
    );
  }
}
