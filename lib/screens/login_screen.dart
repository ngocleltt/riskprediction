import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riskprediction/screens/home_screen.dart';
import 'package:riskprediction/screens/license.dart';
import 'package:riskprediction/screens/signup_screen.dart';
import 'package:riskprediction/screens/welcome_screen.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  LoginScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final user = userCredential.user;
        if (user != null) {
          final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          if (!userDoc.exists) {
            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              'fullName': user.displayName ?? 'No Name',
              'email': user.email ?? '',
              'createdAt': FieldValue.serverTimestamp(),
              'profileImageBase64': '',
              'mobileNumber': "",
              'dob': "",
              'bio' : "",
              'isNormalDiet': true,
              'isVegetarianDiet': false,
              'isAllergyDiet': false,
              'isCantEat': false,
              'allergyDetails': "",
              'cantEatFood': "",
              'cantEatReason': "",
            });
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LicenseScreen(
              onLocaleChange: widget.onLocaleChange,
              currentLocale: widget.currentLocale,
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = 'Login failed. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        final user = userCredential.user;

        // Thêm người dùng vào Firestore nếu chưa tồn tại
        if (user != null) {
          final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
          final docSnapshot = await userRef.get();

          if (!docSnapshot.exists) {
            await userRef.set({
              'fullName': user.displayName ?? 'No Name',
              'email': user.email ?? '',
              'createdAt': FieldValue.serverTimestamp(),
              'profileImageBase64': '',
            });
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LicenseScreen(
              onLocaleChange: widget.onLocaleChange,
              currentLocale: widget.currentLocale,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
          LanguageSelector(onLocaleChange: widget.onLocaleChange),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('login') ?? 'Log In',
                style: AppStyles.headingStyle.copyWith(color: Color(0xFF0F44FF)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.translate('email_or_mobile') ??
                      'Email or Mobile Number',
                  hintText: 'example@example.com',
                  labelStyle: AppStyles.bodyStyle.copyWith(
                      color: AppStyles.bodyStyle.color?.withOpacity(0.3)),
                  hintStyle: AppStyles.bodyStyle.copyWith(
                      color: AppStyles.bodyStyle.color?.withOpacity(0.5)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.translate('email_required') ??
                        'Please enter your email';
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
                  labelStyle: AppStyles.bodyStyle.copyWith(
                      color: AppStyles.bodyStyle.color?.withOpacity(0.3)),
                  hintStyle: AppStyles.bodyStyle.copyWith(
                      color: AppStyles.bodyStyle.color?.withOpacity(0.5)),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.translate('password_required') ??
                        'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)?.translate('forget_password') ?? 'Forget Password',
                    style: AppStyles.bodyStyle.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
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
                    onPressed: _isLoading ? null : _signInWithGoogle,
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
                      builder: (context) => SignupScreen(
                        onLocaleChange: widget.onLocaleChange,
                        currentLocale: widget.currentLocale,
                      ),
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
      ),
    );
  }
}
