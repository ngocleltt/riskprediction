import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class SubmitSuccessScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;
  final String userName;
  final String riskType;
  final int stars;
  final DateTime timestamp;

  SubmitSuccessScreen({
    required this.onLocaleChange,
    required this.currentLocale,
    required this.userName,
    required this.riskType,
    required this.stars,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM d, yyyy').format(timestamp);
    final String formattedTime = DateFormat('h:mm a').format(timestamp);

    return Scaffold(
      backgroundColor: Color(0xFFFBB127),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBB127),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: onLocaleChange,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 180,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)?.translate('congratulation') ?? 'Congratulation',
              style: AppStyles.headingStyle.copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)?.translate('report_successfully') ?? 'Report is successfully submitted',
              style: AppStyles.subbodyStyle.copyWith(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('upload_success') ??
                        'You have successfully uploaded a report to the system',
                    style: AppStyles.subbodyStyle.copyWith(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: AppStyles.bodyStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            formattedDate, // Hiển thị ngày
                            style: AppStyles.subbodyStyle.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.black54),
                          SizedBox(width: 5),
                          Text(
                            formattedTime, // Hiển thị giờ
                            style: AppStyles.subbodyStyle.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.translate('risk_type') ?? 'Risk Type:',
                            style: AppStyles.bodyStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            riskType,
                            style: AppStyles.subbodyStyle.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.translate('stars') ?? 'Stars:',
                            style: AppStyles.bodyStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$stars',
                            style: AppStyles.subbodyStyle.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          } else if (index == 2) {
            Navigator.pushNamed(context, '/user');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          }
        },
        onLocaleChange: onLocaleChange,
        currentLocale: currentLocale,
      ),
    );
  }
}
