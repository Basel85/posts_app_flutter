import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/failures.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure,List<Post>>> getPosts();
  Future<Either<Failure,Unit>> createPost({required Post post});
  Future<Either<Failure,Unit>> deletePost({required int postId});
  Future<Either<Failure,Unit>> updatePost({required Post post});
}
