import 'package:equatable/equatable.dart';

class ComplainsEvent extends Equatable {
  const ComplainsEvent();

  @override
  List<Object> get props => [];
}

class ComplainsFetchingEvent extends ComplainsEvent {
  const ComplainsFetchingEvent();
}
