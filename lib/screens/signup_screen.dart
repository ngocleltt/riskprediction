import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riskprediction/screens/license.dart';
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
  final _formKey = GlobalKey<FormState>();
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

  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          try {
            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              'fullName': _fullNameController.text.trim(),
              'email': _emailController.text.trim(),
              'mobileNumber': _mobileNumberController.text.trim(),
              'dob': _dobController.text.trim(),
              'createdAt': FieldValue.serverTimestamp(),
              'bio' : "",
              'isNormalDiet': true,
              'isVegetarianDiet': false,
              'isAllergyDiet': false,
              'isCantEat': false,
              'allergyDetails': "",
              'cantEatFood': "",
              'cantEatReason': "",
              'profileImageBase64': ""
            });
          } catch (firestoreError) {
            print("Firestore Error: $firestoreError");
            throw Exception("Failed to save user data to Firestore");
          }

          print("User registered and data saved successfully");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LicenseScreen(
                onLocaleChange: widget.onLocaleChange,
                currentLocale: widget.currentLocale,
              ),
            ),
          );
          print("Navigation to LicenseScreen successful");
        }
      } on FirebaseAuthException catch (authError) {
        print("FirebaseAuth Error: $authError");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.translate('signup_failed') ??
                  'Sign up failed: ${authError.message}',
            ),
          ),
        );
      } catch (e) {
        print("Error during sign up: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.translate('signup_failed') ?? 'Sign up failed: $e',
            ),
          ),
        );
      }
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.translate('full_name') ?? 'Full name',
                  hintText: 'Huynh Tran An Binh',
                  labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                  hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                  border: OutlineInputBorder(),
                ),
                style: AppStyles.bodyStyle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.translate('name_required') ?? 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
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
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return AppLocalizations.of(context)?.translate('password_too_short') ??
                        'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.translate('email') ?? 'Email',
                  hintText: 'example@example.com',
                  labelStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                  hintStyle: AppStyles.bodyStyle.copyWith(color: Colors.grey.withOpacity(0.5)),
                  border: OutlineInputBorder(),
                ),
                style: AppStyles.bodyStyle,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return AppLocalizations.of(context)?.translate('invalid_email') ?? 'Invalid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
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
              TextFormField(
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
                child: ElevatedButton(
                  onPressed: _registerUser,
                  child: Text(
                    AppLocalizations.of(context)?.translate('sign_up') ?? 'Sign Up',
                    style: AppStyles.bodyStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
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
                  child: Text(
                    AppLocalizations.of(context)?.translate('already_have_account') ??
                        "Already have an account? Log in",
                    style: AppStyles.upbarStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
