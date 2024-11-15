import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  HomeScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('welcome_back') ?? 'Hi, Welcome Back',
              style: AppStyles.bodyStyle.copyWith(color: Colors.orange),
            ),
            Text(
              'An Binh',
              style: AppStyles.headingStyle.copyWith(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.orange),
            onPressed: () {},
          ),
          LanguageSelector(onLocaleChange: widget.onLocaleChange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.orange),
                hintText: AppLocalizations.of(context)?.translate('search') ?? 'Search',
                hintStyle: AppStyles.subbodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildRiskButton(AppLocalizations.of(context)?.translate('emergency') ?? 'Emergency', Icons.warning),
                _buildRiskButton(AppLocalizations.of(context)?.translate('review_needed') ?? 'Review Needed', Icons.rate_review),
                _buildRiskButton(AppLocalizations.of(context)?.translate('more_info_needed') ?? 'More Info Needed', Icons.info),
                _buildRiskButton(AppLocalizations.of(context)?.translate('potential_risk') ?? 'Potential Risk', Icons.shield),
                _buildRiskButton(AppLocalizations.of(context)?.translate('poison') ?? 'Poison', Icons.science),
                _buildRiskButton(AppLocalizations.of(context)?.translate('other_risks') ?? 'Other Risks', Icons.chat),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard(AppLocalizations.of(context)?.translate('rating') ?? 'Rating', '5'),
                SizedBox(width: 10),
                _buildStatCard(AppLocalizations.of(context)?.translate('points') ?? 'Points', '20'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('no_tasks_description') ?? 'We have no tasks for you to complete right now, but if you notice any danger, please let us know.',
                    style: AppStyles.bodyStyle,
                  ),
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

  Widget _buildRiskButton(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFBB127),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          SizedBox(height: 10),
          Text(label, style: AppStyles.subbodyStyle.copyWith(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: AppStyles.headingStyle.copyWith(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
