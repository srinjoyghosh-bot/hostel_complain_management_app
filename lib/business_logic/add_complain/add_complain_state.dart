import 'package:equatable/equatable.dart';

class AddComplainState extends Equatable {
  const AddComplainState();

  @override
  List<Object> get props => [];
}

class LoadingState extends AddComplainState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class InitialState extends AddComplainState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class AddSuccessState extends AddComplainState {
  const AddSuccessState();

  @override
  List<Object> get props => [];
}

class AddFailureState extends AddComplainState {
  const AddFailureState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
