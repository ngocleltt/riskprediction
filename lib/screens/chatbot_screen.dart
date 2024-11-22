import 'package:flutter/material.dart';
import 'package:riskprediction/screens/faq_data.dart';
import 'package:riskprediction/styles/app_style.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedLanguage = "vi"; // Default language
  List<Map<String, String>> chatHistory = [];

  String getFlexibleResponse(String input, String language) {
    input = input.toLowerCase();
    for (String question in faqKeywords[language]!.keys) {
      for (String keyword in faqKeywords[language]![question]!) {
        if (input.contains(keyword)) {
          return faqData[language]![question]!;
        }
      }
    }
    return "Xin lỗi, tôi không hiểu câu hỏi của bạn.";
  }

  void _sendMessage() {
    String userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    String botResponse = getFlexibleResponse(userInput, _selectedLanguage);

    setState(() {
      chatHistory.add({"user": userInput});
      chatHistory.add({"bot": botResponse});
    });

    _controller.clear();
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose Language",
            style: AppStyles.subHeadingStyle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Tiếng Việt', style: AppStyles.upbarStyle),
                onTap: () {
                  setState(() {
                    _selectedLanguage = "vi";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('English', style: AppStyles.upbarStyle),
                onTap: () {
                  setState(() {
                    _selectedLanguage = "en";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Русский', style: AppStyles.upbarStyle),
                onTap: () {
                  setState(() {
                    _selectedLanguage = "ru";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
          "Chatbot",
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.white),
            onPressed: _showLanguageSelector,
            tooltip: "Change Language",
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                bool isUser = chatHistory[index].keys.first == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      chatHistory[index].values.first,
                      style: AppStyles.bodyStyle,
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Nhập câu hỏi...",
                      hintStyle: AppStyles.subbodyStyle,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFFFBB127)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
