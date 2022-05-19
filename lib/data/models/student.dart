import 'package:hostel_complain_management_app/data/models/complain.dart';

class Student {
  final String id;
  final String name;
  final String hostelName;
  final String email;
  final String password;
  bool isSecretary = false;
  List<Complain>? complains;

  Student({
    required this.id,
    required this.name,
    required this.hostelName,
    required this.email,
    required this.password,
    this.complains,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'hostel': hostelName,
        'email': email,
        'password': password,
        'isSecretary': isSecretary,
        'complains': complains != null
            ? List.from(complains!.map((e) => e.toJson()))
            : null,
      };
}
