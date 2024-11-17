import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/screens/submit_success.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class AnonymousReportScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  AnonymousReportScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  _AnonymousReportScreenState createState() => _AnonymousReportScreenState();
}

class _AnonymousReportScreenState extends State<AnonymousReportScreen> {
  File? _selectedImage;
  String? _selectedRiskType;

  List<String> get _localizedRiskTypes {
    return [
      AppLocalizations.of(context)?.translate('emergency') ?? 'Emergency',
      AppLocalizations.of(context)?.translate('review_needed') ?? 'Review Needed',
      AppLocalizations.of(context)?.translate('more_info_needed') ?? 'More Info Needed',
      AppLocalizations.of(context)?.translate('potential_risk') ?? 'Potential Risk',
      AppLocalizations.of(context)?.translate('poison') ?? 'Poison',
      AppLocalizations.of(context)?.translate('other_risks') ?? 'Other Risks',
    ];
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.grey[100],
          title: Center(
            child: Text(
              AppLocalizations.of(context)?.translate('choose_image_source') ?? 'Choose Image Source',
              style: AppStyles.headingStyle.copyWith(
                fontSize: 18,
                color: Color(0xFFFBB127),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
                icon: Icon(Icons.photo_library, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)?.translate('gallery') ?? 'Gallery',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBB127),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
                icon: Icon(Icons.camera_alt, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)?.translate('camera') ?? 'Camera',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBB127),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)?.translate('cancel') ?? 'Cancel',
                  style: AppStyles.bodyStyle.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBB127),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('anonymous_report') ?? 'Anonymous Report',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange, iconColor: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)?.translate('anonymous_report_description') ??
                    'Your name and personal information will be kept confidential from everyone.',
                textAlign: TextAlign.center,
                style: AppStyles.subbodyStyle.copyWith(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),

              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(color: Color(0xFFFBB127), width: 2),
                  ),
                  child: _selectedImage != null
                      ? ClipOval(
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      height: 140,
                      width: 140,
                    ),
                  )
                      : Icon(Icons.add, size: 50, color: Color(0xFFFBB127)),
                ),
              ),
              SizedBox(height: 10),

              Text(
                AppLocalizations.of(context)?.translate('your_picture_here') ?? 'Your picture here',
                style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold, color: Color(0xFFFBB127)),
              ),
              SizedBox(height: 20),

              Column(
                children: _localizedRiskTypes.map((type) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: RadioListTile<String>(
                      value: type,
                      groupValue: _selectedRiskType,
                      onChanged: (value) {
                        setState(() {
                          _selectedRiskType = value;
                        });
                      },
                      title: Text(
                        type,
                        style: AppStyles.bodyStyle.copyWith(color: Colors.black87),
                      ),
                      activeColor: Color(0xFFFBB127),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.translate('enter_your_comment') ?? 'Enter Your Comment Here...',
                    hintStyle: AppStyles.subbodyStyle.copyWith(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_selectedRiskType == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)?.translate('please_select_risk_type') ?? 'Please select a risk type.',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  print('Anonymous report submitted with risk type: $_selectedRiskType');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubmitSuccessScreen(
                        onLocaleChange: widget.onLocaleChange,
                        currentLocale: widget.currentLocale,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBB127),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                child: Text(
                  AppLocalizations.of(context)?.translate('add_report') ?? 'Add Report',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }
}
