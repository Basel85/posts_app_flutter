import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/injection_container/injection_container.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/add_post_screen.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/posts_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      case '/add-post':
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AddPostBloc>()),
          ],
          child: const AddPostScreen()));
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
