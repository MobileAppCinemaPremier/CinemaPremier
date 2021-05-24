import 'dart:developer';

import 'package:cinema_premier/data/api_connect.dart';
import 'package:cinema_premier/data/movie/bloc_eventm.dart';
import 'package:cinema_premier/data/movie/bloc_statem.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStart) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final connect = ApiConnect();
    yield MovieLoading();
    try {
      List<Movie> movieList;
      if (movieId == 0) {
        movieList = await connect.getNowPlayingMovie();
      }
      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      yield MovieLoadFailed();
    }
  }
}
