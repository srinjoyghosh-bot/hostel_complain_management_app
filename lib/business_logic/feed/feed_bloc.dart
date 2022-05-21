import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_event.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_state.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';
import 'package:hostel_complain_management_app/data/repositories/feed_repository.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repo;

  FeedBloc({required this.repo}) : super(const FeedLoadingState()) {
    on<FeedFetchingEvent>((event, emit) async {
      emit(const FeedLoadingState());
      try {
        List<Complain> complains = await repo.getComplains(event.type);
        emit(FeedSuccessState(complains));
      } on Exception catch (e) {
        emit(FeedErrorState(message: e.toString()));
      }
    });
  }
}
