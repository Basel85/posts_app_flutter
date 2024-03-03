import 'package:equatable/equatable.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();
  @override
  List<Object> get props => [];
}

class AddPostInitialState extends AddPostState {}

class AddPostLoadingState extends AddPostState {}

class AddPostSuccessState extends AddPostState {
  final String message;
  const AddPostSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class AddPostErrorState extends AddPostState {
  final String message;
  const AddPostErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
