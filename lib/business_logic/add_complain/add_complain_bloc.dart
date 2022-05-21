import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_event.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_state.dart';
import 'package:hostel_complain_management_app/data/repositories/add_complain_repository.dart';

class AddComplainBloc extends Bloc<AddComplainEvent, AddComplainState> {
  final AddComplainRepository repo;

  AddComplainBloc({required this.repo}) : super(const InitialState()) {
    on<AddComplainEvent>((event, emit) async {
      emit(const LoadingState());
      try {
        final status =
            await repo.addComplain(event.title, event.body, event.complainType);
        if (status == 'Success') {
          emit(const AddSuccessState());
        } else {
          emit(AddFailureState(message: status));
        }
      } on Exception catch (e) {
        emit(AddFailureState(message: e.toString()));
      }
    });
  }
}
