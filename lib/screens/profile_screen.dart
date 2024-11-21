import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';
import 'package:riskprediction/widgets/editable_profile_field.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class ProfileScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  ProfileScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 2;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  File? _profileImage;
  String? _profileImageBase64;
  bool isLoading = true;

  bool isNormalDiet = true;
  bool isVegetarianDiet = false;
  bool isAllergyDiet = false;
  bool isCantEat = false;

  String allergyDetails = '';
  String cantEatFood = '';
  String cantEatReason = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          _fullNameController.text = userData['fullName'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _mobileNumberController.text = userData['mobileNumber'] ?? '';
          _dobController.text = userData['dob'] ?? '';
          _bioController.text = userData['bio'] ?? '';
          _profileImageBase64 = userData['profileImageBase64'] ?? '';
          isNormalDiet = userData['isNormalDiet'] ?? true;
          isVegetarianDiet = userData['isVegetarianDiet'] ?? false;
          isAllergyDiet = userData['isAllergyDiet'] ?? false;
          isCantEat = userData['isCantEat'] ?? false;
          allergyDetails = userData['allergyDetails'] ?? '';
          cantEatFood = userData['cantEatFood'] ?? '';
          cantEatReason = userData['cantEatReason'] ?? '';
        });
      } catch (e) {
        print("Error fetching user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user data: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'fullName': _fullNameController.text.trim(),
            'email': _emailController.text.trim(),
            'mobileNumber': _mobileNumberController.text.trim(),
            'dob': _dobController.text.trim(),
            'bio': _bioController.text.trim(),
            'isNormalDiet': isNormalDiet,
            'isVegetarianDiet': isVegetarianDiet,
            'isAllergyDiet': isAllergyDiet,
            'isCantEat': isCantEat,
            'allergyDetails': allergyDetails,
            'cantEatFood': cantEatFood,
            'cantEatReason': cantEatReason,
            'profileImageBase64': _profileImageBase64 ?? '',
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully!')),
          );
        } catch (e) {
          print("Error updating profile: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: $e')),
          );
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final imageBase64 = await _convertImageToBase64(imageFile);

      setState(() {
        _profileImage = imageFile;
        _profileImageBase64 = imageBase64;
      });
    }
  }

  Future<String> _convertImageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('profile') ?? '',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: widget.onLocaleChange,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageBase64 != null && _profileImageBase64!.isNotEmpty
                    ? MemoryImage(base64Decode(_profileImageBase64!))
                    : AssetImage('assets/images/profile.jpg') as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              EditableProfileField(
                label: AppLocalizations.of(context)?.translate('full_name') ?? '',
                initialValue: _fullNameController.text,
                hintText: 'Enter your full name',
              ),
              SizedBox(height: 10),
              EditableProfileField(
                label: AppLocalizations.of(context)?.translate('phone_number') ?? '',
                initialValue: _mobileNumberController.text,
                hintText: 'Enter your phone number',
              ),
              SizedBox(height: 10),
              EditableProfileField(
                label: AppLocalizations.of(context)?.translate('email') ?? '',
                initialValue: _emailController.text,
                hintText: 'Enter your email',
              ),
              SizedBox(height: 10),
              EditableProfileField(
                label: AppLocalizations.of(context)?.translate('date_of_birth') ?? '',
                initialValue: _dobController.text,
                hintText: 'DD/MM/YYYY',
              ),
              SizedBox(height: 20),
              _buildDietOptions(),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  AppLocalizations.of(context)?.translate('update_profile') ?? '',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }

  Widget _buildDietOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.translate('diet') ?? 'Diet Preferences',
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildSwitchRow('normal', isNormalDiet, (value) {
          setState(() {
            isNormalDiet = value;
          });
        }),
        _buildSwitchRow('vegetarian', isVegetarianDiet, (value) {
          setState(() {
            isVegetarianDiet = value;
          });
        }),
        _buildSwitchRow('allergy', isAllergyDiet, (value) {
          setState(() {
            isAllergyDiet = value;
          });
        }),
        if (isAllergyDiet) ...[
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                allergyDetails = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('what_allergy') ??
                  'What kind of food are you allergic to?',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
        _buildSwitchRow("cant_eat", isCantEat, (value) {
          setState(() {
            isCantEat = value;
          });
        }),
        if (isCantEat) ...[
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                cantEatFood = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('cant_eat_food') ??
                  "Can't eat food...",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              setState(() {
                cantEatReason = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.translate('cant_eat_reason') ??
                  'Reason for not eating',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.orange.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSwitchRow(String key, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)?.translate(key) ?? key,
          style: AppStyles.bodyStyle.copyWith(fontSize: 16),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
        ),
      ],
    );
  }
}
