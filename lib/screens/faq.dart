import 'package:flutter/material.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';

class FAQScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  FAQScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBB127), // Thay đổi màu cam chủ đạo
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('help_center') ?? 'Help Center',
          style: AppStyles.headingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(
            onLocaleChange: widget.onLocaleChange,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFFBB127),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('how_can_we_help') ?? 'How Can We Help You?',
                  style: AppStyles.bodyStyle.copyWith(color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.translate('search') ?? 'Search...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFFBB127)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tabs for FAQ and Contact Us
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTab = 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.only(right: 8), // Tách nút ra
                      decoration: BoxDecoration(
                        color: _currentTab == 0 ? Color(0xFFFBB127) : Colors.white,
                        borderRadius: BorderRadius.circular(20), // Bo tròn góc
                        border: Border.all(color: Color(0xFFFBB127)),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)?.translate('faq') ?? 'FAQ',
                          style: AppStyles.bodyStyle.copyWith(
                            color: _currentTab == 0 ? Colors.white : Color(0xFFFBB127),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTab = 1),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.only(left: 8), // Tách nút ra
                      decoration: BoxDecoration(
                        color: _currentTab == 1 ? Color(0xFFFBB127) : Colors.white,
                        borderRadius: BorderRadius.circular(20), // Bo tròn góc
                        border: Border.all(color: Color(0xFFFBB127)),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)?.translate('contact_us') ?? 'Contact Us',
                          style: AppStyles.bodyStyle.copyWith(
                            color: _currentTab == 1 ? Colors.white : Color(0xFFFBB127),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content for FAQ or Contact Us
          Expanded(
            child: _currentTab == 0
                ? ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                final questionKey = 'question_${index + 1}';
                final answerKey = 'answer_${index + 1}';
                return _buildFAQItem(
                  context,
                  AppLocalizations.of(context)?.translate(questionKey) ?? '',
                  AppLocalizations.of(context)?.translate(answerKey) ?? '',
                );
              },
            )
                : ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final contactKey = 'contact_${index + 1}_title';
                final infoKey = 'contact_${index + 1}_info';
                return _buildContactItem(
                  context,
                  AppLocalizations.of(context)?.translate(contactKey) ?? '',
                  AppLocalizations.of(context)?.translate(infoKey) ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          question,
          style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              answer,
              style: AppStyles.subbodyStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String title, String info) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.info_outline, color: Color(0xFFFBB127)),
        title: Text(
          title,
          style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          info,
          style: AppStyles.subbodyStyle,
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
