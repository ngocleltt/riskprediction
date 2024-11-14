import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/screens/login_screen.dart';
import 'package:riskprediction/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  SignupScreen({required this.onLocaleChange});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Account', style: AppStyles.subHeadingStyle),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFBB127)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Color(0xFFFBB127)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context)?.translate('choose_language') ?? 'Choose Language',
                      style: AppStyles.subHeadingStyle,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('en')),
                        ),
                        ListTile(
                          title: Text('Русский', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('ru')),
                        ),
                        ListTile(
                          title: Text('Tiếng Việt', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('vi')),
                        ),
                        ListTile(
                          title: Text('Deutsch', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('de')),
                        ),
                        ListTile(
                          title: Text('Français', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('fr')),
                        ),
                        ListTile(
                          title: Text('عربي', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('ar')),
                        ),
                        ListTile(
                          title: Text('中文', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('zh')),
                        ),
                        ListTile(
                          title: Text('Español', style: AppStyles.upbarStyle),
                          onTap: () => widget.onLocaleChange(Locale('es')),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full name',
                hintText: 'Huynh Tran An Binh',
                labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(),
              ),
              style: AppStyles.bodyStyle,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: '********',
                labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              style: AppStyles.bodyStyle,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@example.com',
                labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(),
              ),
              style: AppStyles.bodyStyle,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                hintText: '+79031234567',
                labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(),
              ),
              style: AppStyles.bodyStyle,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date Of Birth',
                hintText: 'DD / MM / YYYY',
                labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(),
              ),
              style: AppStyles.bodyStyle,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'By continue, you agree to Terms of Use and Privacy Policy.',
                textAlign: TextAlign.center,
                style: AppStyles.bodyStyle.copyWith(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Sign Up', style: AppStyles.bodyStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBB127),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('or sign up with', style: AppStyles.bodyStyle.copyWith(color: Colors.grey)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.g_mobiledata, color: Color(0xFFFBB127), size: 35),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.facebook, color: Color(0xFFFBB127), size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.fingerprint,color: Color(0xFFFBB127), size: 30),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(onLocaleChange: widget.onLocaleChange),
                    ),
                  );
                },
                child: Text("already have an account? Log in", style: AppStyles.upbarStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
