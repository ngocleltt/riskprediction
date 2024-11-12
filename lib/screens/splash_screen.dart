import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBB127),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/welcome');
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
                style: AppStyles.headingStyle,
              ),
              Text(
                'Huỳnh Trần An Bình',
                style: AppStyles.subHeadingStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
