import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImplementation implements PostsRepository {
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocalDataSource _localDataSource;

  PostsRepositoryImplementation(
    this._remoteDataSource,
    this._localDataSource,
  );

  Future<Either<NetworkExceptions, void>> _implementNonGetterPostOperation(
      {required Future<void> nonGetterImplementation}) async {
    try {
      await nonGetterImplementation;
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> createPost(
      {required Post post}) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _implementNonGetterPostOperation(
        nonGetterImplementation: _remoteDataSource.createPost(post: postModel));
  }

  @override
  Future<Either<NetworkExceptions, void>> deletePost(
      {required int postId}) async {
    return await _implementNonGetterPostOperation(
        nonGetterImplementation: _remoteDataSource.deletePost(postId: postId));
  }

  @override
  Future<Either<NetworkExceptions, List<Post>>> getPosts() async {
    try {
      final remotePosts = await _remoteDataSource.getPosts();
      _localDataSource.cachePosts(remotePosts);
      return Right(remotePosts);
    } catch (e) {
      if (e is Exception &&
          e is DioException &&
          e.type == DioExceptionType.connectionError) {
        try {
          final localPosts = await _localDataSource.getCachedPosts();
          return Right(localPosts);
        } catch (e) {
          return Left(NetworkExceptions.getDioException(e));
        }
      } else {
        return Left(NetworkExceptions.getDioException(e));
      }
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> updatePost(
      {required Post post}) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _implementNonGetterPostOperation(
        nonGetterImplementation:
            _remoteDataSource.updatePost(post: postModel, postId: post.id!));
  }
}
