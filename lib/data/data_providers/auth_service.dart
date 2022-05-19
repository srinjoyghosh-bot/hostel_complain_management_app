import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_complain_management_app/data/constants.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/student.dart';

class AuthService {
  final LocalStorageService _storageService = LocalStorageService.instance;

  Future<String> createUser(
      String emailAddress, String password, String name, Hostel hostel) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Student student = Student(
        id: credential.user!.uid,
        name: name,
        hostelName: HOSTEL_NAME[hostel.name]!,
        email: emailAddress,
        password: password,
      );
      CollectionReference students =
          FirebaseFirestore.instance.collection('students');
      students.doc(student.id).set(student.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }

    return 'Success';
  }

  Future<String> loginUser(String emailAddress, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    _storageService.uid = credential!.user!.uid;
    _storageService.isLoggedIn = true;
    return 'Success';
  }

  Future<String> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on Exception catch (e) {
      return e.toString();
    }
    _storageService.isLoggedIn = false;
    return 'Success';
  }

// String? getUserId() {
//   return FirebaseAuth.instance.currentUser?.uid;
// }
}
