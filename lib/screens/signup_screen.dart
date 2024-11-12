import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: AppStyles.headingStyle.copyWith(color: Colors.white)),
        backgroundColor: Color(0xFF0F44FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle sign up
              },
              child: Text('Sign Up', style: AppStyles.bodyStyle.copyWith(color: Colors.white)),
              style: AppStyles.elevatedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
