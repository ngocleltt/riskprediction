import 'package:flutter/material.dart';
import 'package:riskprediction/screens/home_screen.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class LicenseScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  LicenseScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _LicenseScreenState createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('license_title') ?? 'License Agreement',
          style: AppStyles.subHeadingStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  AppLocalizations.of(context)?.translate('license_content') ?? '',
                  style: AppStyles.subbodyStyle,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreed = value ?? false;
                    });
                  },
                  activeColor: Colors.orange,
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)?.translate('agree_terms') ?? 'I agree to the terms of service',
                    style: AppStyles.bodyStyle.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _agreed
                    ? () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        onLocaleChange: widget.onLocaleChange,
                        currentLocale: widget.currentLocale,
                      ),
                    ),
                        (route) => false,
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  AppLocalizations.of(context)?.translate('continue') ?? 'Continue',
                  style: AppStyles.bodyStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
