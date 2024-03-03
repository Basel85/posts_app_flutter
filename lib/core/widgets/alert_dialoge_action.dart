import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertDialogeAction extends StatelessWidget {
  final void Function() onPressed;
  final String actionText;
  const AlertDialogeAction(
      {super.key, required this.onPressed, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(actionText,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
    );
  }
}
