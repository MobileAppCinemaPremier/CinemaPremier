class Movie {
  final int id;
  final String title;
  final String backdropPath;
  final String originalLang;
  final String overview;
  final double popular;
  final String poster;
  final String releaseDate;
  final bool video;
  final int voteC;
  final String voteA;

  String error;

  Movie(
      {this.id,
      this.title,
      this.backdropPath,
      this.originalLang,
      this.overview,
      this.popular,
      this.poster,
      this.releaseDate,
      this.video,
      this.voteC,
      this.voteA});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
        id: json['id'],
        title: json['title'],
        backdropPath: json['backdrop_path'],
        originalLang: json['original_language'],
        overview: json['overview'],
        popular: json['popularity'],
        poster: json['poster_path'],
        releaseDate: json['release_date'],
        video: json['video'],
        voteA: json['vote_average'].toString(),
        voteC: json['vote_count']);
  }
}
