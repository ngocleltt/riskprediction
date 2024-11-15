import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  SettingsScreen({required this.onLocaleChange, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('settings') ?? 'Settings',
          style: AppStyles.headingStyle.copyWith(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          LanguageSelector(onLocaleChange: onLocaleChange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsOption(
              context,
              icon: Icons.notifications,
              labelKey: 'notification_setting',
              onTap: () {},
            ),
            Divider(),
            _buildSettingsOption(
              context,
              icon: Icons.vpn_key,
              labelKey: 'password_manager',
              onTap: () {},
            ),
            Divider(),
            _buildSettingsOption(
              context,
              icon: Icons.person_remove,
              labelKey: 'delete_account',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, {required IconData icon, required String labelKey, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        AppLocalizations.of(context)?.translate(labelKey) ?? labelKey,
        style: AppStyles.bodyStyle.copyWith(color: Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
      onTap: onTap,
    );
  }
}
