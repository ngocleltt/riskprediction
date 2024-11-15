import 'package:flutter/material.dart';
import 'package:riskprediction/screens/welcome_screen.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  SplashScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_progress >= 1) {
        timer.cancel();
        _navigateToWelcomeScreen();
      } else {
        setState(() {
          _progress += 0.01;
        });
      }
    });
  }

  void _navigateToWelcomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(
          onLocaleChange: widget.onLocaleChange,
          currentLocale: widget.currentLocale,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBB127),
      body: Center(
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
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
