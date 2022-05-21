import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_event.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_state.dart';
import 'package:hostel_complain_management_app/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository repo})
      : _authRepository = repo,
        super(const AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(const LoadingState());
      try {
        final status = await _authRepository.logIn(event.email, event.password);
        if (status == 'Success') {
          emit(const LoginSuccessState());
        } else {
          emit(LoginFailureState(message: status));
        }
      } on Exception catch (e) {
        emit(LoginFailureState(message: e.toString()));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(const LoadingState());
      try {
        final status = await _authRepository.signUp(
          event.name,
          event.hostel,
          event.email,
          event.password,
        );
        if (status == 'Success') {
          emit(const SignUpSuccessState());
        } else {
          emit(SignUpFailureState(message: status));
        }
      } on Exception catch (e) {
        emit(SignUpFailureState(message: e.toString()));
      }
    });

    on<SwitchFormEvent>(
        (event, emit) => emit(SwitchFormState(showLogin: event.showLogin)));

    on<LogOutEvent>((event, emit) async {
      try {
        final status = await _authRepository.logOut();
        if (status == 'Success') {
          emit(const LogOutSuccessState());
        } else {
          emit(LogOutFailureState(message: status));
        }
      } on Exception catch (e) {
        emit(LogOutFailureState(message: e.toString()));
      }
    });
  }
}
