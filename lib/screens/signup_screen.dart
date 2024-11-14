  import 'package:flutter/material.dart';
  import 'package:riskprediction/styles/app_style.dart';
  import 'package:riskprediction/screens/login_screen.dart';
  import 'package:riskprediction/app_localizations.dart';
  import 'package:riskprediction/widgets/language_selector.dart';

  class SignupScreen extends StatefulWidget {
    final Function(Locale) onLocaleChange;
    final Locale currentLocale;

    SignupScreen({required this.onLocaleChange, required this.currentLocale});
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
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onLocaleChange(widget.currentLocale);
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.translate('sign_up') ?? 'New Account',
            style: AppStyles.subHeadingStyle,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFFBB127)),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            LanguageSelector(onLocaleChange: widget.onLocaleChange),
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
                  labelText: AppLocalizations.of(context)?.translate('full_name') ?? 'Full name',
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
                  labelText: AppLocalizations.of(context)?.translate('password') ?? 'Password',
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
                  labelText: AppLocalizations.of(context)?.translate('email') ?? 'Email',
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
                  labelText: AppLocalizations.of(context)?.translate('mobile_number') ?? 'Mobile Number',
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
                  labelText: AppLocalizations.of(context)?.translate('date_of_birth') ?? 'Date Of Birth',
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
                  AppLocalizations.of(context)?.translate('terms_of_use') ??
                      'By continuing, you agree to Terms of Use and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: AppStyles.bodyStyle.copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)?.translate('sign_up') ?? 'Sign Up', style: AppStyles.bodyStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
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
                child: Text(AppLocalizations.of(context)?.translate('or_sign_up_with') ?? 'or sign up with',
                    style: AppStyles.bodyStyle.copyWith(color: Colors.grey)),
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
                        builder: (context) => LoginScreen(
                          onLocaleChange: widget.onLocaleChange,
                          currentLocale: widget.currentLocale,
                        ),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)?.translate('already_have_account') ?? "Already have an account? Log in", style: AppStyles.upbarStyle),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
