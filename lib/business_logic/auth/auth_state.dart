import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends AuthState {
  const LoginSuccessState();
}

class SignUpSuccessState extends AuthState {
  const SignUpSuccessState();
}

class LogOutSuccessState extends AuthState {
  const LogOutSuccessState();
}

class LoginFailureState extends AuthState {
  final String message;

  const LoginFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpFailureState extends AuthState {
  final String message;

  const SignUpFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogOutFailureState extends AuthState {
  final String message;

  const LogOutFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SwitchFormState extends AuthState {
  final bool showLogin;

  const SwitchFormState({required this.showLogin});

  @override
  List<Object?> get props => [showLogin];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class LoadingState extends AuthState {
  const LoadingState();
}
