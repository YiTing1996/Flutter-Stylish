import 'package:flutter_stylish/helper/export/bloc_export.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final Repository _repository = Repository();

  DetailBloc(id)
      : super(DetailLoadingState()) {
    on<DetailInitialEvent>((event, emit) async {
      emit(DetailLoadingState());
      try {
        final details = await _repository.getDetail(id);
        emit(DetailLoadedState(details));
      } catch (e) {
        emit(DetailErrorState(e.toString()));
      }
    });
  }
}