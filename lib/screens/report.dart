import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/screens/submit_report.dart';
import 'package:riskprediction/screens/anonymous_report.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class ReportScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  ReportScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
          AppLocalizations.of(context)?.translate('report') ?? 'Report',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: widget.onLocaleChange,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('report_description') ??
                    'Choose an option to create a report:',
                textAlign: TextAlign.center,
                style: AppStyles.bodyStyle.copyWith(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubmitReportScreen(
                        onLocaleChange: widget.onLocaleChange,
                        currentLocale: widget.currentLocale,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)?.translate('submit_report') ?? 'Submit Report',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBB127),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnonymousReportScreen(
                        onLocaleChange: widget.onLocaleChange,
                        currentLocale: widget.currentLocale,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.no_accounts_outlined, color: Colors.white),
                label: Text(
                  AppLocalizations.of(context)?.translate('anonymous_report') ?? 'Anonymous Report',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }
}
