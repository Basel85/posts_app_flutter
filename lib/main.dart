import 'package:flutter/material.dart';
import 'package:posts_app_flutter/core/injection_container/injection_container.dart';
import 'package:posts_app_flutter/posts_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(const PostsApp());
}
