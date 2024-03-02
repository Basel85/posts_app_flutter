import 'package:equatable/equatable.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsSuccessState extends PostsState {
  final List<Post> posts;

  const PostsSuccessState({required this.posts});

  @override
  List<Object> get props => [posts];

}

class PostsErrorState extends PostsState {
  final String message;

  const PostsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
