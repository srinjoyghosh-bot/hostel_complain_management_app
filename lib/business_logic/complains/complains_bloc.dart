import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_event.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_state.dart';
import 'package:hostel_complain_management_app/data/repositories/complains_repository.dart';

import '../../data/models/complain.dart';

class ComplainsBloc extends Bloc<ComplainsEvent, ComplainsState> {
  final ComplainsRepository repo;

  ComplainsBloc({required this.repo}) : super(const ComplainsLoadingState()) {
    on<ComplainsFetchingEvent>((event, emit) async {
      try {
        List<Complain> selfComplains = await repo.getSelfComplains();
        emit(ComplainsSuccessState(complains: selfComplains));
      } on Exception catch (e) {
        emit(ComplainsFailureState(message: e.toString()));
      }
    });
  }
}
