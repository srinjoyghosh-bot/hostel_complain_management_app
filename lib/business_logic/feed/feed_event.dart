import 'package:equatable/equatable.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FeedFetchingEvent extends FeedEvent {
  final ComplainType type;

  const FeedFetchingEvent({required this.type});

  @override
  List<Object> get props => [type];
}
