class Student {
  final String id;
  final String name;
  final String hostelName;
  final String email;
  final String password;
  bool isSecretary;
  String secretaryDepartment;

  List<String>? complains;

  Student({
    required this.id,
    required this.name,
    required this.hostelName,
    required this.email,
    required this.password,
    this.complains,
    this.isSecretary = false,
    this.secretaryDepartment = 'None',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'hostel': hostelName,
        'email': email,
        'password': password,
        'isSecretary': isSecretary,
        'secretaryOf': secretaryDepartment,
        'complains': complains != null
            ? List.from(complains!.map((e) => {'docId': e}))
            : null,
      };

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      hostelName: json['hostel'],
      email: json['email'],
      password: json['password'],
      isSecretary: json['isSecretary'],
      secretaryDepartment: json['secretaryOf'] ?? 'None',
      complains: json['complains'] == null
          ? null
          : List.from(json['complains'].map((e) => e['docId'])),
    );
  }
}
