import 'package:flutter/material.dart';
import 'package:riskprediction/screens/welcome_screen.dart';
import 'package:riskprediction/styles/app_style.dart';

class SplashScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  SplashScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBB127),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>WelcomeScreen(
                onLocaleChange: onLocaleChange,
                currentLocale: currentLocale,
              ),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo1.png',
                width: 300,
                height: 300,
              ),
              SizedBox(height: 5),
              Text(
                'Risk Prediction',
                style: AppStyles.headingStyle.copyWith(color: Colors.white),
              ),
              Text(
                'Huỳnh Trần An Bình',
                style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
