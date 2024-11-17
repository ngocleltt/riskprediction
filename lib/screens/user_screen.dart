import 'package:flutter/material.dart';
import 'package:riskprediction/screens/faq.dart';
import 'package:riskprediction/screens/license.dart';
import 'package:riskprediction/screens/profile_screen.dart';
import 'package:riskprediction/screens/settings/settings_screen.dart';
import 'package:riskprediction/screens/splash_screen.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class UserScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  UserScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFBB127)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('user') ?? '',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'An Binh',
              style: AppStyles.subHeadingStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildUserOption(context, Icons.person, AppLocalizations.of(context)?.translate('profile') ?? ''),
                  _buildUserOption(context, Icons.history, AppLocalizations.of(context)?.translate('favorite') ?? ''),
                  _buildUserOption(context, Icons.book_outlined, AppLocalizations.of(context)?.translate('payment_method') ?? ''),
                  _buildUserOption(context, Icons.privacy_tip, AppLocalizations.of(context)?.translate('privacy_policy') ?? ''),
                  _buildUserOption(context, Icons.settings, AppLocalizations.of(context)?.translate('settings') ?? ''),
                  _buildUserOption(context, Icons.help_outline, AppLocalizations.of(context)?.translate('help') ?? ''),
                  _buildUserOption(context, Icons.logout, AppLocalizations.of(context)?.translate('logout') ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }

  Widget _buildUserOption(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orangeAccent[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Color(0xFFFBB127)),
      ),
      title: Text(
        title,
        style: AppStyles.bodyStyle.copyWith(color: Color(0xFFFBB127), fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {
        if (title == AppLocalizations.of(context)?.translate('logout')) {
          _showLogoutDialog(context);
        } else  if (title == AppLocalizations.of(context)?.translate('profile')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                onLocaleChange: widget.onLocaleChange,
                currentLocale: widget.currentLocale,
              ),
            ),
          );
        } else  if (title == AppLocalizations.of(context)?.translate('privacy_policy')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LicenseScreen(
                onLocaleChange: widget.onLocaleChange,
                currentLocale: widget.currentLocale,
              ),
            ),
          );
        } else if (title == AppLocalizations.of(context)?.translate('help')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FAQScreen(
                onLocaleChange: widget.onLocaleChange,
                currentLocale: widget.currentLocale,
              ),
            ),
          );
        } else if (title == AppLocalizations.of(context)?.translate('settings')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(
                onLocaleChange: widget.onLocaleChange,
                currentLocale: widget.currentLocale,
              ),
            ),
          );
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Logout',
            style: AppStyles.subHeadingStyle.copyWith(color: Color(0xFFFBB127), fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: AppStyles.bodyStyle.copyWith(color: Colors.black87, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: AppStyles.bodyStyle.copyWith(color: Color(0xFF0F44FF), fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes, Logout',
                style:  AppStyles.bodyStyle.copyWith(color: Color(0xFFFBB127), fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen(
                    onLocaleChange: widget.onLocaleChange,
                    currentLocale: widget.currentLocale,
                  ),),
                );
              },
            ),
          ],
        );
      },
    );
  }


}
