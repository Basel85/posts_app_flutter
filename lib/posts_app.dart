import 'package:flutter/material.dart';
import 'package:posts_app_flutter/core/helpers/app_route_paths.dart';
import 'package:posts_app_flutter/core/router/app_router.dart';

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts App Using Clean Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutePaths.home,
    );
  }
}