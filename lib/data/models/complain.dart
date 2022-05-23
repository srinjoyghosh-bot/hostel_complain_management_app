import 'package:hostel_complain_management_app/data/constants.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class Complain {
  final String title;
  final String body;
  final ComplainType type;
  final String complainant;
  final String date;
  bool isResolved;

  Complain({
    required this.title,
    required this.body,
    required this.type,
    required this.complainant,
    required this.date,
    this.isResolved = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'by': complainant,
        'body': body,
        'type': type.name,
        'date': date,
        'isResolved': isResolved,
      };

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
      title: json['title'],
      body: json['body'],
      type: COMPLAIN_TYPE[json['type']]!,
      complainant: json['by'],
      date: json['date'],
      isResolved: json['isResolved'] ?? false,
    );
  }
}
