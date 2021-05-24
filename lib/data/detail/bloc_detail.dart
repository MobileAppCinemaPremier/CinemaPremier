import 'package:cinema_premier/data/api_connect.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailLoading());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailEventStated) {
      yield* _mapMovieEventStartedToState(event.id);
    }
  }

  Stream<DetailState> _mapMovieEventStartedToState(int id) async* {
    final apiRepo = ApiConnect();
    yield DetailLoading();
    try {
      final detail = await apiRepo.getMovieDetail(id);

      yield DetailLoaded(detail);
    } on Exception catch (e) {
      print(e);
      yield DetailError();
    }
  }
}
