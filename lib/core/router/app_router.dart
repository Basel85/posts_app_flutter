import 'package:flutter/material.dart';
import 'package:posts_app_flutter/features/posts/presentation/screens/posts_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No route defined'),
                  ),
                ));
    }
  }
}
