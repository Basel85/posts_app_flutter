import 'package:equatable/equatable.dart';

abstract class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

class DeletePostInitialState extends DeletePostState {}

class DeletePostLoadingState extends DeletePostState {}

class DeletePostSuccessState extends DeletePostState {
  final String message;

  const DeletePostSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeletePostErrorState extends DeletePostState {
  final String message;

  const DeletePostErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

