import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String labelText;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {super.key, required this.formKey, required this.labelText, this.validator});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
