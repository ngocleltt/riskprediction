import 'package:flutter/material.dart';
import 'package:riskprediction/styles/app_style.dart';

class EditableProfileField extends StatelessWidget {
  final String label;
  final String initialValue;
  final String? hintText;
  final int maxLines;

  const EditableProfileField({
    required this.label,
    required this.initialValue,
    this.hintText,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.subHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue.isNotEmpty ? initialValue : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.orange.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppStyles.bodyStyle.copyWith(fontSize: 16, color: Colors.black38),
        ),
      ],
    );
  }
}
