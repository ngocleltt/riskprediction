import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riskprediction/app_localizations.dart';
import 'package:riskprediction/styles/app_style.dart';
import 'package:riskprediction/widgets/language_selector.dart';
import 'package:riskprediction/widgets/custom_bottom_navigation_bar.dart';

class HistoryScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  HistoryScreen({
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Map<String, dynamic>>> _userReports;

  @override
  void initState() {
    super.initState();
    _userReports = _fetchUserReports();
  }

  Future<List<Map<String, dynamic>>> _fetchUserReports() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reports')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'riskType': data['riskType'],
          'stars': data['stars'],
          'imageBase64': data['imageBase64'],
          'timestamp': (data['timestamp'] as Timestamp).toDate(),
        };
      }).toList();
    } catch (e) {
      print("Error fetching reports: $e");
      return [];
    }
  }

  Widget _buildReportItem(Map<String, dynamic> report) {
    String formattedDate = "${report['timestamp'].day}/${report['timestamp'].month}/${report['timestamp'].year}";
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: report['imageBase64'] != null && report['imageBase64'].isNotEmpty
            ? CircleAvatar(
          backgroundImage: MemoryImage(base64Decode(report['imageBase64'])),
          radius: 25,
        )
            : CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.image_not_supported, color: Colors.grey),
          radius: 25,
        ),
        title: Text(
          report['riskType'] ?? AppLocalizations.of(context)?.translate('unknown') ?? 'Unknown',
          style: AppStyles.subHeadingStyle.copyWith(fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)?.translate('stars') ?? 'Stars'}: ${report['stars']}",
              style: AppStyles.bodyStyle.copyWith(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              "${AppLocalizations.of(context)?.translate('date') ?? 'Date'}: $formattedDate",
              style: AppStyles.bodyStyle.copyWith(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Handle tap on report item if needed
        },
      ),
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
          AppLocalizations.of(context)?.translate('report_history') ?? 'Report History',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange, iconColor: Colors.white),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _userReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.translate('error_loading') ?? 'Error loading reports',
                style: AppStyles.bodyStyle.copyWith(color: Colors.red),
              ),
            );
          }

          final reports = snapshot.data ?? [];

          if (reports.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.translate('no_reports') ?? 'No reports found',
                style: AppStyles.bodyStyle.copyWith(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return _buildReportItem(reports[index]);
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {},
        onLocaleChange: widget.onLocaleChange,
        currentLocale: widget.currentLocale,
      ),
    );
  }
}
