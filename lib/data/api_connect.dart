import 'package:cinema_premier/data/detail/cast.data.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/data/upcoming/upcoming_data.dart';
import 'package:dio/dio.dart';

class ApiConnect {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=b956606bb415e81f8f6ece28a06b84c2';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception('Error: $error stacktrace: $stacktrace');
    }
  }

  Future<List<Upcoming>> getUpcomingMovie() async {
    try {
      final url = '$baseUrl/movie/upcoming?$apiKey';
      final response = await _dio.get(url);
      var upcoming = response.data['results'] as List;
      List<Upcoming> upcomingList =
          upcoming.map((m) => Upcoming.fromJson(m)).toList();
      return upcomingList;
    } catch (error, stacktrace) {
      throw Exception('Error: $error stacktrace: $stacktrace');
    }
  }

  Future<Detail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      Detail detail = Detail.fromJson(response.data);

      detail.trailerId = await getYoutubeId(movieId);
      detail.castList = await getCastList(movieId);

      return detail;
    } catch (error, stacktrace) {
      throw Exception('Error: $error stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception('Error: $error stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception('Error: $error stacktrace: $stacktrace');
    }
  }
}
