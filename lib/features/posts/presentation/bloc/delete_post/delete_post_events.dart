import 'package:equatable/equatable.dart';

abstract class DeletePostEvent extends Equatable {
  const DeletePostEvent();

  @override
  List<Object> get props => [];
}

class DeletePostButtonEvent extends DeletePostEvent {
  final int postId;

  const DeletePostButtonEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
