import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:posts_app_flutter/core/helpers/dio_helper.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/repositories/posts_repository_implementation.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/get_all_posts_use_case.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> initDependency() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(
      () => PostsRemoteDataSource(DioHelper(dio: Dio()).configureDio()));
  getIt.registerLazySingleton(() =>
      PostsLocalDataSourceImplementation(sharedPreferences: sharedPreferences));
  getIt.registerLazySingleton(() => PostsRepositoryImplementation(
      getIt<PostsRemoteDataSource>(),
      getIt<PostsLocalDataSourceImplementation>()));

  getIt.registerLazySingleton(
      () => GetAllPostsUseCase(getIt<PostsRepositoryImplementation>()));
  getIt.registerLazySingleton(
      () => PostsBloc(getAllPostsUseCase: getIt<GetAllPostsUseCase>()));

  getIt.registerFactory(
      () => CreatePostUseCase(getIt<PostsRepositoryImplementation>()));

  getIt.registerLazySingleton(
      () => UpdatePostUseCase(getIt<PostsRepositoryImplementation>()));
  
  getIt.registerLazySingleton(
      () => DeletePostUseCase(getIt<PostsRepositoryImplementation>()));

  getIt.registerFactory(() => AddPostBloc(getIt<CreatePostUseCase>()));

  getIt.registerFactory(() => UpdatePostBloc(getIt<UpdatePostUseCase>()));

  getIt.registerFactory(() => DeletePostBloc(getIt<DeletePostUseCase>()));
}
