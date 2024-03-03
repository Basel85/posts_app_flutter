import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/helpers/app_route_paths.dart';
import 'package:posts_app_flutter/core/utils/snack_bar_viewer.dart';
import 'package:posts_app_flutter/core/widgets/alert_dialoge_action.dart';
import 'package:posts_app_flutter/core/widgets/body_text.dart';
import 'package:posts_app_flutter/core/widgets/custom_appbar.dart';
import 'package:posts_app_flutter/core/widgets/custom_button.dart';
import 'package:posts_app_flutter/core/widgets/loading_alert_dialog.dart';
import 'package:posts_app_flutter/core/widgets/title_text.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_states.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';

class PostDetailsScreen extends StatelessWidget with SnackBarViewer {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Post Details',
        ),
        body: BlocListener<DeletePostBloc, DeletePostState>(
          listener: (context, state) {
            if (state is DeletePostSuccessState) {
              showSnackBar(
                  context: context,
                  message: state.message,
                  backgroundColor: Colors.green);
              Navigator.pop(context);
              PostsBloc.get(context).add(GetPostsEvent());
              Navigator.pop(context);
            } else if (state is DeletePostErrorState) {
              showSnackBar(
                  context: context,
                  message: state.message,
                  backgroundColor: Colors.red);
              Navigator.pop(context);
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const LoadingAlertDialog();
                  });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(title: post.title),
                Divider(
                  height: 20.h,
                ),
                BodyText(body: post.body),
                Divider(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutePaths.updatePost,
                              arguments: post);
                        },
                        buttonText: 'Edit'),
                    CustomButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (contxt) {
                              return AlertDialog(
                                title: Text('Are you sure?',
                                    style: TextStyle(fontSize: 20.sp)),
                                content: Text(
                                    'Do you want to delete this post?',
                                    style: TextStyle(fontSize: 16.sp)),
                                actions: [
                                  AlertDialogeAction(
                                      onPressed: () {
                                        Navigator.pop(contxt);
                                      },
                                      actionText: 'No'),
                                  AlertDialogeAction(
                                      onPressed: () {
                                        DeletePostBloc.get(context).add(
                                            DeletePostButtonEvent(
                                                postId: post.id!));
                                        Navigator.pop(contxt);
                                      },
                                      actionText: 'Yes'),
                                ],
                              );
                            });
                      },
                      buttonText: 'Delete',
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
