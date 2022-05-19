import 'package:hostel_complain_management_app/data/enums.dart';

class Complain {
  final String title;
  final String body;
  final ComplainType type;
  final String complainantId;

  Complain({
    required this.title,
    required this.body,
    required this.type,
    required this.complainantId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'by': complainantId,
        'body': body,
        'type': type.name,
      };
}
