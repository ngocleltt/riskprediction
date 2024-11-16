import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class NotificationScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  NotificationScreen({required this.onLocaleChange, required this.currentLocale});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('notification') ?? 'Notification',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
        actions: [
          LanguageSelector(onLocaleChange: onLocaleChange),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildNotificationSection(context, 'today', [
            _buildNotificationItem(
              context,
              title: AppLocalizations.of(context)?.translate('report_accepted_title') ?? 'Report Accepted',
              time: '23m',
              description: AppLocalizations.of(context)?.translate('report_accepted_description') ?? 'your report has been accepted by administrator and will soon be processed',
              icon: Icons.event,
            ),
            _buildNotificationItem(
              context,
              title: AppLocalizations.of(context)?.translate('moscow_5_title') ?? '"Moscow 5.0"',
              time: '1h',
              description: AppLocalizations.of(context)?.translate('moscow_5_description') ?? 'conference on new generation technology safety will take place in moscow on 20.10.2024 at 20:00',
              icon: Icons.event,
              highlighted: true,
            ),
            _buildNotificationItem(
              context,
              title: AppLocalizations.of(context)?.translate('whats_new_title') ?? "What's New ?",
              time: '3h',
              description: AppLocalizations.of(context)?.translate('whats_new_description') ?? "dear user, don't forget to update your recent life, no matter if it's safe or risky at the moment. we're here to help you!",
              icon: Icons.event,
            ),
          ]),
          _buildNotificationSection(context, 'yesterday', [
            _buildNotificationItem(
              context,
              title: AppLocalizations.of(context)?.translate('points_title') ?? 'Points',
              time: '1d',
              description: AppLocalizations.of(context)?.translate('points_description') ?? 'you have 20 points and can effort for some gift at the store.',
              icon: Icons.event,
            ),
          ]),
          _buildNotificationSection(context, '15_april', [
            _buildNotificationItem(
              context,
              title: AppLocalizations.of(context)?.translate('feedback_title') ?? 'Feedback',
              time: '5d',
              description: AppLocalizations.of(context)?.translate('feedback_description') ?? "how do you think with the last report's respond? let us know! ^^",
              icon: Icons.question_answer,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildNotificationSection(BuildContext context, String title, List<Widget> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            AppLocalizations.of(context)?.translate(title) ?? title,
            style: AppStyles.headingStyle.copyWith(fontSize: 18, color: Colors.orange),
          ),
        ),
        ...notifications,
      ],
    );
  }

  Widget _buildNotificationItem(BuildContext context, {
    required String title,
    required String time,
    required String description,
    required IconData icon,
    bool highlighted = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted ? Colors.blue[50] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange[100],
            child: Icon(icon, color: Colors.orange),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.headingStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: AppStyles.subbodyStyle,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Text(
            time,
            style: AppStyles.subbodyStyle.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
