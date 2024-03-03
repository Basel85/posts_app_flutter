import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<NetworkExceptions,List<Post>>> getPosts();
  Future<Either<NetworkExceptions,void>> createPost({required Post post});
  Future<Either<NetworkExceptions,void>> deletePost({required int postId});
  Future<Either<NetworkExceptions,void>> updatePost({required Post post});
}
