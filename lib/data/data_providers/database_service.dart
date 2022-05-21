import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';
import 'package:hostel_complain_management_app/data/models/student.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalStorageService _service = LocalStorageService.instance;

  Future<String> addComplain(Complain complain) async {
    try {
      String docId, uid = _service.uid;
      _firestore
          .collection('complains')
          .add(complain.toJson())
          .then((value) async {
        docId = value.id;
        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('students').doc(uid);
        final snapshot = await userDoc.get();
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        List<String> newComplainList = [];
        if (userData['complains'] == null) {
          newComplainList = [docId];
        } else {
          newComplainList =
              List.from(userData['complains'].map((e) => e['docId']));
          newComplainList.add(docId);
        }
        userData['complains'] =
            List.from(newComplainList.map((e) => {'docId': e}));
        userDoc.set(userData);
      });
    } on Exception catch (e) {
      return e.toString();
    }
    return 'Success';
  }

  Future<List<Complain>> getAllComplains({required ComplainType type}) async {
    final snapShot = await _firestore.collection('complains').get();
    if (snapShot.size > 0) {
      final data =
          snapShot.docs.map((doc) => Complain.fromJson(doc.data())).toList();
      if (type == ComplainType.none) {
        return data;
      } else {
        return data.where((complain) => complain.type == type).toList();
      }
    } else {
      return [];
    }
  }

  Future<Student> getStudentFromId(String id) async {
    final snap = await _firestore.collection('students').doc(id).get();
    return Student.fromJson(snap.data() as Map<String, dynamic>);
  }
}
