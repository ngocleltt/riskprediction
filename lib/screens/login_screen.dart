import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/screens/welcome_screen.dart';
import 'package:riskprediction/screens/signup_screen.dart';
import 'package:riskprediction/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  LoginScreen({required this.onLocaleChange});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    if (_usernameController.text == 'admin' && _passwordController.text == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(onLocaleChange: widget.onLocaleChange),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.translate('invalid_credentials') ??
                'Invalid username or password',
          ),
        ),
      );
    }
  }

  void _changeLanguage(Locale locale) {
    widget.onLocaleChange(locale);
    Navigator.pop(context);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.orange),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context)?.translate('choose_language') ??
                          'Choose Language',
                      style: AppStyles.subHeadingStyle,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English'),
                          onTap: () => _changeLanguage(Locale('en')),
                        ),
                        ListTile(
                          title: Text('Русский'),
                          onTap: () => _changeLanguage(Locale('ru')),
                        ),
                        ListTile(
                          title: Text('Tiếng Việt'),
                          onTap: () => _changeLanguage(Locale('vi')),
                        ),
                        ListTile(
                          title: Text('Deutsch'),
                          onTap: () => _changeLanguage(Locale('de')),
                        ),
                        ListTile(
                          title: Text('Français'),
                          onTap: () => _changeLanguage(Locale('fr')),
                        ),
                        ListTile(
                          title: Text('عربي'),
                          onTap: () => _changeLanguage(Locale('ar')),
                        ),
                        ListTile(
                          title: Text('中文'),
                          onTap: () => _changeLanguage(Locale('zh')),
                        ),
                        ListTile(
                          title: Text('Español'),
                          onTap: () => _changeLanguage(Locale('es')),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('login') ?? 'Log In',
              style: AppStyles.headingStyle.copyWith(color: Color(0xFF0F44FF)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.translate('email_or_mobile') ??
                    'Email or Mobile Number',
                hintText: 'example@example.com',
                labelStyle: AppStyles.bodyStyle,
                hintStyle: AppStyles.bodyStyle,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.translate('password') ?? 'Password',
                hintText: '********',
                labelStyle: AppStyles.bodyStyle,
                hintStyle: AppStyles.bodyStyle,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)?.translate('forget_password') ??
                      'Forget Password',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(
                AppLocalizations.of(context)?.translate('login') ?? 'Log In',
                style: AppStyles.bodyStyle.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFBB127),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)?.translate('or_sign_up_with') ?? 'or sign up with',
              style: AppStyles.bodyStyle.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.g_mobiledata_rounded, color: Colors.orange),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.orange),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.fingerprint, color: Colors.orange),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(onLocaleChange: widget.onLocaleChange),
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)?.translate('dont_have_account') ??
                    "Don't have an account? Sign Up",
                style: AppStyles.bodyStyle.copyWith(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
