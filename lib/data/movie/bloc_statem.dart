import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;
  const MovieLoaded(this.movieList);
  @override
  List<Object> get props => [movieList];
}

class MovieLoadFailed extends MovieState {}
