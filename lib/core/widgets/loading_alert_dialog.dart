import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingAlertDialog extends StatelessWidget {
  const LoadingAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Loading...', style: TextStyle(fontSize: 16.sp)),
    );
  }
}
