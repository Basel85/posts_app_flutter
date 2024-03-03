import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyText extends StatelessWidget {
  final String body;
  const BodyText({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      style: TextStyle(fontSize: 16.sp),
    );
  }
}
