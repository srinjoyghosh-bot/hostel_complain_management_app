import 'package:hostel_complain_management_app/data/data_providers/auth_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class AuthRepository {
  Future<String> signUp(
      String name, Hostel hostel, String email, String password) {
    return AuthService().createUser(email, password, name, hostel);
  }

  Future<String> logIn(String email, String password) {
    return AuthService().loginUser(email, password);
  }

  Future<String> logOut() {
    return AuthService().logout();
  }
}
