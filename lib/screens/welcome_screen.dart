import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/screens/login_screen.dart';
import 'package:riskprediction/screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  WelcomeScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 5),
            Text(
              'Risk Prediction',
              style: AppStyles.headingStyle.copyWith(color: Color(0xFF0F44FF)),
            ),
            SizedBox(height: 10),
            Text(
              'When you report risks, you’re building a foundation for safety and trust.',
              textAlign: TextAlign.center,
              style: AppStyles.bodyStyle.copyWith(color: Color(0xFF0F44FF)),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      onLocaleChange: onLocaleChange,
                      currentLocale: currentLocale,
                    ),
                  ),
                );
              },
              child: Text(
                'Log In',
                style: AppStyles.bodyStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFBB127),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  SignupScreen(
                      onLocaleChange: onLocaleChange,
                      currentLocale: currentLocale,
                    ),
                  ),
                );

              },
              child: Text(
                'Sign Up',
                style: AppStyles.bodyStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFFBB127)),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                backgroundColor: Color(0xFFE3EAFE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
