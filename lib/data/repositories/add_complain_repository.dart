import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_complain_management_app/data/data_providers/database_service.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';
import 'package:hostel_complain_management_app/data/models/student.dart';
import 'package:intl/intl.dart';

class AddComplainRepository {
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageService _storageService = LocalStorageService.instance;

  Future<String> addComplain(
      String title, String body, ComplainType type) async {
    User? user = _auth.currentUser;
    await user?.reload();
    Student student = await _databaseService.getStudentFromId(user!.uid);
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    Complain complain = Complain(
      title: title,
      body: body,
      type: type,
      complainant: student.name,
      date: formattedDate,
      hostelName: _storageService.hostelName,
    );
    return await _databaseService.addComplain(complain);
  }
}
