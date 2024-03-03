import 'package:equatable/equatable.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostButtonEvent extends AddPostEvent {
  final Post post;
  const AddPostButtonEvent({required this.post});
  @override
  List<Object> get props => [post];
}
