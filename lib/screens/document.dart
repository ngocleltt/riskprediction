import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:riskprediction/styles/app_style.dart';

class DocumentScreen extends StatelessWidget {
  final List<Map<String, String>> pdfFiles = [
    {"title": "Risk Analysis Report", "path": "assets/documents/d1.pdf"},
    {"title": "Safety Guidelines", "path": "assets/documents/d1.pdf"},
    {"title": "Project Overview", "path": "assets/documents/d1.pdf"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFBB127)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Documents',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: pdfFiles.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.picture_as_pdf, color: Color(0xFFFBB127)),
              ),
              title: Text(
                pdfFiles[index]["title"]!,
                style: AppStyles.bodyStyle.copyWith(
                  color: Color(0xFFFBB127),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PdfViewerScreen(pdfPath: pdfFiles[index]["path"]!),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  PdfViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFBB127)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PDF Viewer',
          style: AppStyles.subHeadingStyle.copyWith(color: Colors.orange),
        ),
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
