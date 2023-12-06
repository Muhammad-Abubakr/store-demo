import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsRow extends StatelessWidget {
  final String label;
  final String detail;

  const DetailsRow({super.key, required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.spMax),
      child: Row(
        children: [
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 36.w),
          Text(
            detail,
            style: textTheme.bodySmall?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
