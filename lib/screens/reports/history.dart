import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _reports = [];
  bool _isLoading = false;
  DocumentSnapshot? _lastDocument;
  bool _hasMoreReports = true;

  @override
  void initState() {
    super.initState();
    _fetchMoreReports();
  }

  Future<void> _fetchMoreReports() async {
    if (_isLoading || !_hasMoreReports) return;

    setState(() {
      _isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      String userName = (userDoc.data() as Map<String, dynamic>)['fullName'] ?? 'Unknown';

      Query query = _firestore
          .collection('reports')
          .orderBy('timestamp', descending: true)
          .limit(10);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      List<QuerySnapshot> snapshots = [];

      if (userName == "Admin") {
        print("Admin fetching all reports and anonymous_reports");
        snapshots = await Future.wait([
          query.get(),
          _firestore
              .collection('anonymous_reports')
              .orderBy('timestamp', descending: true)
              .limit(10)
              .get(),
        ]);
      } else {
        print("User fetching own reports");
        Query userQuery = _firestore
            .collection('reports')
            .where('userId', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .limit(10);

        if (_lastDocument != null) {
          userQuery = userQuery.startAfterDocument(_lastDocument!);
        }

        snapshots = [
          await userQuery.get(),
        ];
      }


      for (var snapshot in snapshots) {
        if (snapshot.docs.isNotEmpty) {
          _lastDocument = snapshot.docs.last;
          _reports.addAll(snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            String userName = snapshots.length > 1 && snapshot == snapshots[1]
                ? "anonymous"
                : (data['userName'] ?? 'Unknown');
            return {
              'userName': userName,
              'riskType': data['riskType'] ?? 'Unknown',
              'stars': data['stars'] ?? 0,
              'imageBase64': data['imageBase64'] ?? '',
              'comment': data['comment'] ?? 'No comment',
              'timestamp': (data['timestamp'] as Timestamp).toDate(),
            };
          }).toList());
        } else {
          _hasMoreReports = false;
        }
      }

    } catch (e) {
      print("Error fetching reports: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildReportItem(Map<String, dynamic> report) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(report['timestamp']);
    return GestureDetector(
      onTap: () => _showReportDetails(report),
      child: Card(
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
            report['riskType'],
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
        ),
      ),
    );
  }

  void _showReportDetails(Map<String, dynamic> report) {
    String detailedDate =
    DateFormat('dd/MM/yyyy HH:mm:ss').format(report['timestamp']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)?.translate('report_details') ?? 'Report Details',
            style: AppStyles.subHeadingStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppLocalizations.of(context)?.translate('username') ?? 'Username'}: ${report['userName']}",
                style: AppStyles.bodyStyle,
              ),
              SizedBox(height: 5),
              Text(
                "${AppLocalizations.of(context)?.translate('comment') ?? 'Comment'}: ${report['comment']}",
                style: AppStyles.bodyStyle,
              ),
              SizedBox(height: 5),
              Text(
                "${AppLocalizations.of(context)?.translate('date') ?? 'Date'}: $detailedDate",
                style: AppStyles.bodyStyle,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)?.translate('close') ?? 'Close'),
            ),
          ],
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
          AppLocalizations.of(context)?.translate('report_history') ?? 'Report History',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.white),
        ),
        actions: [
          LanguageSelector(onLocaleChange: widget.onLocaleChange, iconColor: Colors.white),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent &&
              !_isLoading) {
            _fetchMoreReports();
          }
          return false;
        },
        child: _reports.isEmpty && !_isLoading
            ? Center(
          child: Text(
            AppLocalizations.of(context)?.translate('no_reports') ?? 'No reports available',
            style: AppStyles.bodyStyle,
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _reports.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _reports.length) {
              return Center(child: CircularProgressIndicator());
            }
            return _buildReportItem(_reports[index]);
          },
        ),
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
