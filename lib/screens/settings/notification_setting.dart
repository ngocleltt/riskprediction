import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class NotificationSettingScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  NotificationSettingScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool generalNotification = true;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = true;
  bool specialOffers = false;
  bool payments = true;
  bool promoAndDiscount = false;
  bool cashback = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('notification_setting') ?? 'Notification Setting',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildNotificationOption('general_notification', generalNotification, (value) {
              setState(() {
                generalNotification = value;
              });
            }),
            _buildNotificationOption('sound', sound, (value) {
              setState(() {
                sound = value;
              });
            }),
            _buildNotificationOption('sound_call', soundCall, (value) {
              setState(() {
                soundCall = value;
              });
            }),
            _buildNotificationOption('vibrate', vibrate, (value) {
              setState(() {
                vibrate = value;
              });
            }),
            _buildNotificationOption('special_offers', specialOffers, (value) {
              setState(() {
                specialOffers = value;
              });
            }),
            _buildNotificationOption('payments', payments, (value) {
              setState(() {
                payments = value;
              });
            }),
            _buildNotificationOption('promo_and_discount', promoAndDiscount, (value) {
              setState(() {
                promoAndDiscount = value;
              });
            }),
            _buildNotificationOption('cashback', cashback, (value) {
              setState(() {
                cashback = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(String labelKey, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)?.translate(labelKey) ?? labelKey,
          style: AppStyles.bodyStyle.copyWith(color: Colors.black, fontSize: 16),
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
