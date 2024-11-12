import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Risk Prediction',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F44FF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'When you report risks, you’re building a foundation for safety and trust.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to Login Screen
              },
              child: Text('Log In'),
              style: AppStyles.elevatedButtonStyle,
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // Navigate to Sign Up Screen
              },
              child: Text('Sign Up'),
              style: AppStyles.elevatedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
