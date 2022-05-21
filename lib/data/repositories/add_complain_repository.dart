import 'package:hostel_complain_management_app/data/data_providers/database_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';
import 'package:hostel_complain_management_app/data/models/student.dart';
import 'package:intl/intl.dart';

import '../data_providers/local_storage_service.dart';

class AddComplainRepository {
  final LocalStorageService _service = LocalStorageService.instance;
  final DatabaseService _databaseService = DatabaseService();

  Future<String> addComplain(
      String title, String body, ComplainType type) async {
    Student student = await _databaseService.getStudentFromId(_service.uid);
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    Complain complain = Complain(
      title: title,
      body: body,
      type: type,
      complainant: student.name,
      date: formattedDate,
    );
    return await _databaseService.addComplain(complain);
  }
}
