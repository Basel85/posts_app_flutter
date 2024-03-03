import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_app_flutter/core/injection_container/injection_container.dart';
import 'package:posts_app_flutter/observer.dart';
import 'package:posts_app_flutter/posts_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = Observer();
  await initDependency();
  runApp(const PostsApp());
}
