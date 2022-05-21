import 'package:hostel_complain_management_app/data/constants.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class Complain {
  final String title;
  final String body;
  final ComplainType type;
  final String complainant;
  final String date;

  Complain({
    required this.title,
    required this.body,
    required this.type,
    required this.complainant,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'by': complainant,
        'body': body,
        'type': type.name,
        'date': date,
      };

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
      title: json['title'],
      body: json['body'],
      type: COMPLAIN_TYPE[json['type']]!,
      complainant: json['by'],
      date: json['date'],
    );
  }
}
