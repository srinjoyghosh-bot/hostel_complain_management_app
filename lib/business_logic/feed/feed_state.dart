import 'package:equatable/equatable.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoadingState extends FeedState {
  const FeedLoadingState();
}

class FeedSuccessState extends FeedState {
  final List<Complain> complains;

  const FeedSuccessState(this.complains);

  @override
  List<Object> get props => [complains];
}

class FeedErrorState extends FeedState {
  final String message;

  const FeedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
