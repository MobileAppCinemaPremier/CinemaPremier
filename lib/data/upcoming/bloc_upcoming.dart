import 'package:cinema_premier/data/api_connect.dart';
import 'package:cinema_premier/data/upcoming/bloc_eventu.dart';
import 'package:cinema_premier/data/upcoming/bloc_stateu.dart';
import 'package:cinema_premier/data/upcoming/upcoming_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  UpcomingBloc() : super(UpcomingLoading());

  @override
  Stream<UpcomingState> mapEventToState(UpcomingEvent event) async* {
    if (event is UpcomingEventStart) {
      yield* _mapMovieEventStateToState(event.upcomingId, event.query);
    }
  }

  Stream<UpcomingState> _mapMovieEventStateToState(
      int upcomingId, String query) async* {
    final connect = ApiConnect();
    yield UpcomingLoading();
    try {
      List<Upcoming> movieList;
      if (upcomingId == 0) {
        movieList = await connect.getUpcomingMovie();
      }
      yield UpcomingLoaded(movieList);
    } on Exception catch (e) {
      yield UpcomingLoadFailed();
    }
  }
}
