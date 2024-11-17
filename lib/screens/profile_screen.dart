import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class EditableProfileField extends StatelessWidget {
  final String label;
  final String initialValue;
  final String? hintText;
  final int maxLines;

  const EditableProfileField({
    required this.label,
    required this.initialValue,
    this.hintText,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue.isNotEmpty ? initialValue : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
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
}

class ProfileScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  ProfileScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;
  bool isNormalDiet = true;
  bool isVegetarianDiet = false;
  bool isAllergyDiet = false;
  bool isCantEat = false;

  String allergyDetails = '';
  String cantEatFood = '';
  String cantEatReason = '';

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
          AppLocalizations.of(context)?.translate('profile') ?? '',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange, iconColor: Colors.white,),
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
            EditableProfileField(
              label: AppLocalizations.of(context)?.translate('full_name') ?? '',
              initialValue: 'Huynh Tran An Binh',
            ),
            SizedBox(height: 10),
            EditableProfileField(
              label: AppLocalizations.of(context)?.translate('phone_number') ?? '',
              initialValue: '+123 567 89000',
            ),
            SizedBox(height: 10),
            EditableProfileField(
              label: AppLocalizations.of(context)?.translate('email') ?? '',
              initialValue: 'anbinh@example.com',
            ),
            SizedBox(height: 10),
            EditableProfileField(
              label: AppLocalizations.of(context)?.translate('date_of_birth') ?? '',
              initialValue: 'DD / MM / YYYY',
            ),
            SizedBox(height: 20),
            _buildDietOptions(),
            SizedBox(height: 20),
            EditableProfileField(
              label: AppLocalizations.of(context)?.translate('bio') ?? '',
              initialValue: '',
              hintText: AppLocalizations.of(context)?.translate('write_bio') ?? '',
              maxLines: 5,
            ),
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

              },
              child: Text(
                AppLocalizations.of(context)?.translate('update_profile') ?? '',
                style: AppStyles.bodyStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: _onTabTapped,
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }

  Widget _buildDietOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.translate('diet') ?? '',
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildSwitchRow('normal', isNormalDiet, (value) {
          setState(() {
            isNormalDiet = value;
          });
        }),
        _buildSwitchRow('vegetarian', isVegetarianDiet, (value) {
          setState(() {
            isVegetarianDiet = value;
          });
        }),
        _buildSwitchRow('allergy', isAllergyDiet, (value) {
          setState(() {
            isAllergyDiet = value;
          });
        }),
        if (isAllergyDiet) ...[
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                allergyDetails = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('what_allergy') ??
                  'What kind of food are you allergic to?',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
        _buildSwitchRow("cant_eat", isCantEat, (value) {
          setState(() {
            isCantEat = value;
          });
        }),
        if (isCantEat) ...[
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                cantEatFood = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('cant_eat_food') ??
                  "Can't eat food...",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                cantEatReason = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('cant_eat_reason') ??
                  'Lý do',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSwitchRow(String key, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)?.translate(key) ?? '',
          style: AppStyles.bodyStyle.copyWith(fontSize: 16),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
        ),
      ],
    );
  }
}
