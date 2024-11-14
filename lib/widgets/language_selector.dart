import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  LanguageSelector({required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language, color: Color(0xFFFBB127)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)?.translate('choose_language') ?? 'Choose Language',
                style: AppStyles.subHeadingStyle,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('English', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('en')),
                  ),
                  ListTile(
                    title: Text('Русский', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('ru')),
                  ),
                  ListTile(
                    title: Text('Tiếng Việt', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('vi')),
                  ),
                  ListTile(
                    title: Text('Deutsch', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('de')),
                  ),
                  ListTile(
                    title: Text('Français', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('fr')),
                  ),
                  ListTile(
                    title: Text('عربي', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('ar')),
                  ),
                  ListTile(
                    title: Text('中文', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('zh')),
                  ),
                  ListTile(
                    title: Text('Español', style: AppStyles.upbarStyle),
                    onTap: () => onLocaleChange(Locale('es')),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
