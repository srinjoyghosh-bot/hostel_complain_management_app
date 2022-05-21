import 'package:equatable/equatable.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class AddComplainEvent extends Equatable {
  final String title, body;
  final ComplainType complainType;

  const AddComplainEvent({
    required this.title,
    required this.body,
    required this.complainType,
  });

  @override
  List<Object> get props => [title, body, complainType];
}
