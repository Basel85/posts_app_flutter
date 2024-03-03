import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/helpers/app_route_paths.dart';
import 'package:posts_app_flutter/core/widgets/custom_appbar.dart';
import 'package:posts_app_flutter/core/widgets/get_error_message.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_states.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  initState() {
    super.initState();
    PostsBloc.get(context).add(GetPostsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Posts',),
        body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is PostsSuccessState) {
            final posts = state.posts;
            return RefreshIndicator(
              onRefresh: () async {
                PostsBloc.get(context).add(GetPostsEvent());
              },
              child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                      title: Text(
                        posts[index].title,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        posts[index].body,
                        style: TextStyle(fontSize: 16.sp),
                      )),
                  separatorBuilder: (context, _) => SizedBox(
                        height: 10.h,
                      ),
                  itemCount: posts.length),
            );
          }
          if (state is PostsErrorState) {
            return GetErrorMessage(
                errorMessage: state.message,
                onPressed: () {
                  PostsBloc.get(context).add(GetPostsEvent());
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutePaths.addPost);
          },
          child: const Icon(Icons.add),
        )
        );
  }
}
