import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app_flutter/core/helpers/app_route_paths.dart';
import 'package:posts_app_flutter/core/router/app_router.dart';

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App Using Clean Architecture',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutePaths.home,
      ),
    );
  }
}
