import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/failures.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository _postsRepository;

  GetAllPostsUseCase(this._postsRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await _postsRepository.getPosts();
  }
}