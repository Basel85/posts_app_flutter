import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/injection_container/injection_container.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/add_post_screen.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/post_details_screen.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/posts_screen.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/update_post_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      case '/add-post':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => getIt<AddPostBloc>()),
                ], child: const AddPostScreen()));
      case '/post-details':
        final post = settings.arguments as Post;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => getIt<DeletePostBloc>()),
                ], child: PostDetailsScreen(post: post)));
      case '/update-post':
        final post = settings.arguments as Post;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => getIt<UpdatePostBloc>()),
                ], child: UpdatePostScreen(post: post)));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
