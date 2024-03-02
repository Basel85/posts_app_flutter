import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/exceptions.dart';
import 'package:posts_app_flutter/core/error/failures.dart';
import 'package:posts_app_flutter/core/network/network_info.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImplementation implements PostsRepository {
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  PostsRepositoryImplementation(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  Future<Either<Failure, Unit>> _implementNonGetterPostOperation(
      {required Future<Unit> nonGetterImplementation}) async {
    if (await _networkInfo.isConnected) {
      try {
        await nonGetterImplementation;
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost({required Post post}) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return _implementNonGetterPostOperation(
        nonGetterImplementation: _remoteDataSource.createPost(post: postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return _implementNonGetterPostOperation(
        nonGetterImplementation: _remoteDataSource.deletePost(postId: postId));
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await _networkInfo.isConnected) {
      try {
        final remotePosts = await _remoteDataSource.getPosts();
        _localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await _localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return _implementNonGetterPostOperation(
        nonGetterImplementation: _remoteDataSource.updatePost(post: postModel));
  }
}
