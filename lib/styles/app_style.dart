import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFFFBB127); // Màu cam
  static const Color secondaryColor = Color(0xFF0F44FF); // Màu xanh dương

  static const TextStyle headingStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: primaryColor,
    fontFamily: 'League Spartan',
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 24,
    color: primaryColor,
    fontFamily: 'League Spartan',
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: secondaryColor,
    fontFamily: 'League Spartan',
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
