import 'package:flutter/material.dart';
import 'package:posts_app_flutter/core/helpers/app_regex.dart';
import 'package:posts_app_flutter/core/widgets/custom_text_form_field/custom_text_form_field.dart';

class TitleTextFormField extends StatelessWidget {
  final TextEditingController titleController;
  const TitleTextFormField({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        controller: titleController,
        labelText: 'title',
        validator: (value) {
          if (AppRegex.isEmpty(value)) {
            return 'Please enter some text';
          }
          return null;
        });
  }
}
