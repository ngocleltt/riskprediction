import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class SubmitReportScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  SubmitReportScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  _SubmitReportScreenState createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  int _selectedStars = 0; // Biến để lưu số sao được chọn

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
          AppLocalizations.of(context)?.translate('risk_report') ?? 'Risk Report',
          style: AppStyles.headingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: widget.onLocaleChange,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mô tả ngắn
            Text(
              AppLocalizations.of(context)?.translate('risk_report_description') ??
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              textAlign: TextAlign.center,
              style: AppStyles.subbodyStyle,
            ),
            SizedBox(height: 20),

            // Hình ảnh
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/sample_picture.jpg'), // Đường dẫn hình ảnh mẫu
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 10),

            // Dòng chữ "Your picture here"
            Text(
              AppLocalizations.of(context)?.translate('your_picture_here') ?? 'Your picture here',
              style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Đánh giá sao
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                  icon: Icon(
                    index < _selectedStars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedStars = index + 1; // Cập nhật số sao khi người dùng chọn
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Hộp nhập bình luận
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

            // Nút "Add Report"
            ElevatedButton(
              onPressed: () {
                // Thêm logic xử lý khi nhấn nút
                print('Add Report button pressed');
                print('Selected stars: $_selectedStars'); // In ra số sao được chọn
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
            ),
          ],
        ),
      ),
    );
  }
}
