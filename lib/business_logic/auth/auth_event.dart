import 'package:equatable/equatable.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.hostel,
  });

  final String name, email, password;
  final Hostel hostel;

  @override
  List<Object> get props => [email, password, name, hostel];
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();
}

class SwitchFormEvent extends AuthEvent {
  final bool showLogin;

  const SwitchFormEvent({required this.showLogin});

  @override
  List<Object> get props => [showLogin];
}
