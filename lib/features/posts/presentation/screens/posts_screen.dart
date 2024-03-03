import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/injection_container/injection_container.dart';
import 'package:posts_app_flutter/core/widgets/custom_appbar.dart';
import 'package:posts_app_flutter/core/widgets/get_error_message.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_states.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Posts',),
        body: BlocProvider(
          create: (context) => getIt<PostsBloc>()..add(GetPostsEvent()),
          child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
            if (state is PostsSuccessState) {
              final posts = state.posts;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostsBloc>().add(GetPostsEvent());
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
                    context.read<PostsBloc>().add(GetPostsEvent());
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your logic here
          },
          child: const Icon(Icons.add),
        )
        );
  }
}
