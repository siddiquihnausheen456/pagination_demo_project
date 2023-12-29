import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_demo/pagination/bloc/pagination_event.dart';
import 'package:pagination_demo/pagination/bloc/pagination_repo.dart';
import 'package:pagination_demo/pagination/bloc/pagination_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataRepositoryImp? repository;

  FetchDataBloc(this.repository) : super(FetchDataInitialState()) {
    on<FetchDataEvent>(onMapEvent);
  }

  void onMapEvent(FetchDataEvent event, Emitter<FetchDataState> emit) async {
    emit(FetchDataInitialState());

    if (event is FetchPaginationData) {
      try {
        var data = await repository?.getData(event.offset ?? 0);
        if (data != null) {
          emit(FetchDataSuccessState(data));
        } else {
          emit(FetchDataErrorState(""));
        }
      } catch (e) {
        emit(FetchDataErrorState(e.toString()));
      }
    }
  }
}
