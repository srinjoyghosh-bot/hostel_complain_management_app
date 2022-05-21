import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addComplain(Complain complain) async {
    try {
      String docId, uid = complain.complainantId;
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
}
