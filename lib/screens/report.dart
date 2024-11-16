import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/screens/submit_report.dart';

class ReportScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  ReportScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

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
          AppLocalizations.of(context)?.translate('report') ?? 'Report',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt, size: 50, color: Color(0xFFFBB127)),
              onPressed: () {
                print("Camera button pressed");
              },
            ),
            IconButton(
              icon: Icon(Icons.send, size: 50, color: Color(0xFFFBB127)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubmitReportScreen(
                      onLocaleChange: onLocaleChange,
                      currentLocale: currentLocale,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
