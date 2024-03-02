import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/failures.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class CreatePostUseCase {
  final PostsRepository _postRepository;

  CreatePostUseCase(this._postRepository);

  Future<Either<Failure, Unit>> call({required Post post}) async {
    return await _postRepository.createPost(post: post);
  }
}
