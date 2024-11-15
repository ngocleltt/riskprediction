import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  HomeScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              'Hi, Welcome Back',
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
                hintText: 'Search',
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
                _buildRiskButton('Emergency', Icons.warning),
                _buildRiskButton('Review Needed', Icons.rate_review),
                _buildRiskButton('More Info Needed', Icons.info),
                _buildRiskButton('Potential Risk', Icons.shield),
                _buildRiskButton('Poison', Icons.science),
                _buildRiskButton('Other Risks', Icons.chat),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard('Rating', '5'),
                SizedBox(width: 10),
                _buildStatCard('Points', '20'),
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
                    'Dear Binh,',
                    style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We have no tasks for you to complete right now, but if you notice any danger, please let us know.',
                    style: AppStyles.bodyStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.orange),
            label: '',
          ),
        ],
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
          Text(label, style: AppStyles.bodyStyle.copyWith(color: Colors.white)),
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
