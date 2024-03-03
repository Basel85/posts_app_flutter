import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/theme/app_colors.dart';
import 'package:posts_app_flutter/core/utils/snack_bar_viewer.dart';
import 'package:posts_app_flutter/core/widgets/custom_appbar.dart';
import 'package:posts_app_flutter/core/widgets/custom_button.dart';
import 'package:posts_app_flutter/core/widgets/custom_text_form_field/body_text_form_field.dart';
import 'package:posts_app_flutter/core/widgets/custom_text_form_field/title_text_form_field.dart';
import 'package:posts_app_flutter/core/widgets/loading_alert_dialog.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_states.dart';

class UpdatePostScreen extends StatefulWidget {
  final Post post;
  const UpdatePostScreen({super.key, required this.post});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen>
    with SnackBarViewer {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.post.title;
    _bodyController.text = widget.post.body;
    super.initState();
  }

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
        title: 'Update Post',
      ),
      body: BlocListener<UpdatePostBloc, UpdatePostState>(
        listener: (context, state) {
          if (state is UpdatePostSuccessState) {
            showSnackBar(
                context: context,
                message: state.message,
                backgroundColor: AppColors.greenColor);
            Navigator.pop(context);
            PostsBloc.get(context).add(GetPostsEvent());
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is UpdatePostErrorState) {
            showSnackBar(
                context: context,
                message: state.message,
                backgroundColor: AppColors.redColor);
            Navigator.pop(context);
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return const LoadingAlertDialog();
                });
          }
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
                      child: TitleTextFormField(
                        titleController: _titleController,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child:
                          BodyTextFormField(bodyController: _bodyController)),
                  CustomButton(
                    buttonText: 'Update Post',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        UpdatePostBloc.get(context).add(UpdatePostButtonEvent(
                          post: Post(
                            title: _titleController.text,
                            body: _bodyController.text,
                            id: widget.post.id,
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
