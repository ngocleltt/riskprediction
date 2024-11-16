import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class PasswordManagerScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  PasswordManagerScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _PasswordManagerScreenState createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('password_manager') ?? 'Password Manager',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordField(
              labelKey: 'current_password',
              labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
              obscureText: _obscureCurrentPassword,
              toggleVisibility: () {
                setState(() {
                  _obscureCurrentPassword = !_obscureCurrentPassword;
                });
              },
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Add forgot password functionality
                },
                child: Text(
                  AppLocalizations.of(context)?.translate('forgot_password') ?? 'Forgot Password?',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildPasswordField(
              labelKey: 'new_password',
              labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
              obscureText: _obscureNewPassword,
              toggleVisibility: () {
                setState(() {
                  _obscureNewPassword = !_obscureNewPassword;
                });
              },
            ),
            SizedBox(height: 20),
            _buildPasswordField(
              labelKey: 'confirm_new_password',
              labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
              obscureText: _obscureConfirmPassword,
              toggleVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  // Add change password functionality
                },
                child: Text(
                  AppLocalizations.of(context)?.translate('change_password') ?? 'Change Password',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle bottom navigation tap
        },
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }

  Widget _buildPasswordField({
    required String labelKey,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    TextStyle? labelStyle,
  }) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)?.translate(labelKey) ?? labelKey,
        labelStyle: labelStyle ?? AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        filled: true,
        fillColor: Colors.orange.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      style: AppStyles.bodyStyle.copyWith(fontSize: 16, color: Colors.black),
    );
  }
}
