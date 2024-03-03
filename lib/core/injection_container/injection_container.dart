import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:posts_app_flutter/core/helpers/dio_helper.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/repositories/posts_repository_implementation.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/get_all_posts_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjectionContainer {
  final getIt = GetIt.instance;
  void init() {
    getIt.registerLazySingleton(
        () => PostsRemoteDataSource(DioHelper(dio: Dio()).configureDio()));
    getIt.registerLazySingleton(() async => PostsLocalDataSourceImplementation(
        sharedPreferences: await SharedPreferences.getInstance()));
    getIt.registerLazySingleton(() => PostsRepositoryImplementation(
        getIt<PostsRemoteDataSource>(),
        getIt<PostsLocalDataSourceImplementation>()));
    getIt.registerLazySingleton(
        () => GetAllPostsUseCase(getIt<PostsRepositoryImplementation>()));
    getIt.registerFactory(
        () => PostsBloc(getAllPostsUseCase: getIt<GetAllPostsUseCase>()));
  }
}
