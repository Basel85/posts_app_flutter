import 'package:equatable/equatable.dart';

abstract class UpdatePostState extends Equatable {
  const UpdatePostState();

  @override
  List<Object> get props => [];
}

class UpdatePostInitialState extends UpdatePostState {}

class UpdatePostLoadingState extends UpdatePostState {}

class UpdatePostSuccessState extends UpdatePostState {
  final String message;

  const UpdatePostSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdatePostErrorState extends UpdatePostState {
  final String message;

  const UpdatePostErrorState({required this.message});

  @override
  List<Object> get props => [message];
}