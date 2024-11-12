import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'League Spartan',
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontFamily: 'League Spartan',
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontFamily: 'League Spartan',
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFFBB127),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(color: Color(0xFFFBB127)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
