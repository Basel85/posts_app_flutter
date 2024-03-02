import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/failures.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository _postRepository;

  DeletePostUseCase(this._postRepository);

  Future<Either<Failure,Unit>> call({required int postId}) async {
    return await _postRepository.deletePost(postId: postId);
  }
}