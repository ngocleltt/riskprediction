import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In', style: AppStyles.headingStyle.copyWith(color: Colors.white)),
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
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              child: Text('Log In', style: AppStyles.bodyStyle.copyWith(color: Colors.white)),
              style: AppStyles.elevatedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}