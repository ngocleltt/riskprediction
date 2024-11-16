import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class ProfileScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  ProfileScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  bool isNormalDiet = true;
  bool isVegetarianDiet = false;
  bool isAllergyDiet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    // Add functionality to change profile picture
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildEditableProfileField('Full Name', 'Huynh Tran An Binh'),
            SizedBox(height: 10),
            _buildEditableProfileField('Phone Number', '+123 567 89000'),
            SizedBox(height: 10),
            _buildEditableProfileField('Email', 'anbinh@example.com'),
            SizedBox(height: 10),
            _buildEditableProfileField('Date Of Birth', 'DD / MM / YYYY'),
            SizedBox(height: 20),
            _buildDietOptions(),
            SizedBox(height: 20),
            _buildEditableProfileField('Bio', 'Write a short bio here...', maxLines: 5),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                // Add functionality to update profile
              },
              child: Text(
                'Update Profile',
                style: AppStyles.bodyStyle,
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

  Widget _buildEditableProfileField(String label, String initialValue, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.orange.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppStyles.bodyStyle.copyWith(fontSize: 16, color: Colors.black38),
        ),
      ],
    );
  }

  Widget _buildDietOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diet',
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            _buildDietOption('Normal', isNormalDiet, (value) {
              setState(() {
                isNormalDiet = value;
              });
            }),
            SizedBox(height: 10),
            _buildDietOption('Vegetarian', isVegetarianDiet, (value) {
              setState(() {
                isVegetarianDiet = value;
              });
            }),
            SizedBox(height: 10),
            _buildDietOption('Allergy', isAllergyDiet, (value) {
              setState(() {
                isAllergyDiet = value;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildDietOption(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
        ),
        Text(
          label,
          style: AppStyles.bodyStyle.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
