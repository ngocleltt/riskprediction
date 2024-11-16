import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart'; // Import LanguageSelector

class StoreScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  StoreScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)?.translate('store') ?? 'Store',
          style: AppStyles.headingStyle.copyWith(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: onLocaleChange,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/profile.jpg'), // Avatar
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)
                                ?.translate('you_have') ??
                                'You have ',
                            style: AppStyles.subbodyStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '20 ' +
                                (AppLocalizations.of(context)
                                    ?.translate('points') ??
                                    'points!'),
                            style: AppStyles.bodyStyle.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildStoreItem(
                    context,
                    'assets/images/auchan.png',
                    AppLocalizations.of(context)?.translate('points_required') ??
                        '2 Points',
                        () {
                      print('Redeem Auchan');
                    },
                  ),
                  _buildStoreItem(
                    context,
                    'assets/images/yves_rocher.png',
                    AppLocalizations.of(context)?.translate('points_required') ??
                        '4 Points',
                        () {
                      print('Redeem Yves Rocher');
                    },
                  ),
                  _buildStoreItem(
                    context,
                    'assets/images/perekrestok.png',
                    AppLocalizations.of(context)?.translate('points_required') ??
                        '2 Points',
                        () {
                      print('Redeem Perekrestok');
                    },
                  ),
                  _buildStoreItem(
                    context,
                    'assets/images/etoile.png',
                    AppLocalizations.of(context)?.translate('points_required') ??
                        '5 Points',
                        () {
                      print('Redeem L\'Etoile');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreItem(
      BuildContext context, String imagePath, String points, VoidCallback onGetPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              points,
              style: AppStyles.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onGetPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)?.translate('get') ?? 'Get',
              style: AppStyles.subbodyStyle.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
