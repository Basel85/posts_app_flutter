import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/helpers/app_regex.dart';
import 'package:posts_app_flutter/core/theme/app_colors.dart';
import 'package:posts_app_flutter/core/utils/snack_bar_viewer.dart';
import 'package:posts_app_flutter/core/widgets/custom_appbar.dart';
import 'package:posts_app_flutter/core/widgets/custom_button.dart';
import 'package:posts_app_flutter/core/widgets/custom_text_form_field.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_states.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> with SnackBarViewer {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add Post',
      ),
      body: BlocListener<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is AddPostSuccessState) {
            showSnackBar(
                context: context,
                message: state.message,
                backgroundColor: AppColors.greenColor);
            PostsBloc.get(context).add(GetPostsEvent());
            Navigator.pop(context);
          }
          if (state is AddPostErrorState) {
            showSnackBar(
                context: context,
                message: state.message,
                backgroundColor: AppColors.redColor);
          }
          const AlertDialog(
            title: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        },
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: CustomTextFormField(
                          controller: _titleController,
                          labelText: 'title',
                          validator: (value) {
                            if (AppRegex.isEmpty(value)) {
                              return 'Please enter some text';
                            }
                            return null;
                          })),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: CustomTextFormField(
                          controller: _bodyController,
                          labelText: 'body',
                          validator: (value) {
                            if (AppRegex.isEmpty(value)) {
                              return 'Please enter some text';
                            }
                            return null;
                          })),
                  CustomButton(
                    buttonText: 'Add Post',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        AddPostBloc.get(context).add(AddPostButtonEvent(
                          post: Post(
                            title: _titleController.text,
                            body: _bodyController.text,
                          ),
                        ));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
