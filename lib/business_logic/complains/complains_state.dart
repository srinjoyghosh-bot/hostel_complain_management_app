import 'package:equatable/equatable.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class ComplainsState extends Equatable {
  const ComplainsState();

  @override
  List<Object> get props => [];
}

class ComplainsLoadingState extends ComplainsState {
  const ComplainsLoadingState();
}

class ComplainsSuccessState extends ComplainsState {
  const ComplainsSuccessState({required this.complains});

  final List<Complain> complains;

  @override
  List<Object> get props => [complains];
}

class ComplainsFailureState extends ComplainsState {
  final String message;

  const ComplainsFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
