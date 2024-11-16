import 'package:flutter/material.dart';
import 'package:riskprediction/screens/profile_screen.dart';
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
  int _currentIndex = 0;

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
                  _buildUserOption(context, Icons.favorite, AppLocalizations.of(context)?.translate('favorite') ?? ''),
                  _buildUserOption(context, Icons.payment, AppLocalizations.of(context)?.translate('payment_method') ?? ''),
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
          color: Colors.orangeAccent[10],
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
        if (title == AppLocalizations.of(context)?.translate('profile')) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
            onLocaleChange: widget.onLocaleChange,
            currentLocale: widget.currentLocale,
          )));
        }
      },
    );
  }
}
