import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  const CustomButton({super.key,required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
    );
  }
}
