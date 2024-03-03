import 'package:flutter/material.dart';
import 'package:posts_app_flutter/core/helpers/app_regex.dart';
import 'package:posts_app_flutter/core/widgets/custom_text_form_field/custom_text_form_field.dart';

class BodyTextFormField extends StatelessWidget {
  final TextEditingController bodyController;
  const BodyTextFormField({super.key, required this.bodyController});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        controller: bodyController,
        labelText: 'body',
        maxLines: 5,
        validator: (value) {
          if (AppRegex.isEmpty(value)) {
            return 'Please enter some text';
          }
          return null;
        });
  }
}
