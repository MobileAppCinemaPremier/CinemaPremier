import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_premier/data/movie/bloc_eventm.dart';
import 'package:cinema_premier/data/movie/bloc_movie.dart';
import 'package:cinema_premier/data/movie/bloc_statem.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/data/upcoming/bloc_eventu.dart';
import 'package:cinema_premier/data/upcoming/bloc_stateu.dart';
import 'package:cinema_premier/data/upcoming/bloc_upcoming.dart';
import 'package:cinema_premier/data/upcoming/upcoming_data.dart';
import 'package:cinema_premier/pages/after_login/detail1_page.dart';
import 'package:cinema_premier/pages/detail_page.dart';
import 'package:cinema_premier/pages/udetail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget1 extends StatefulWidget {
  final int selectGenre;
  const CategoryWidget1({Key key, this.selectGenre = 4}) : super(key: key);
  @override
  CategoryWidgetState1 createState() => CategoryWidgetState1();
}

class CategoryWidgetState1 extends State<CategoryWidget1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStart(0, '')),
        ),
        BlocProvider<UpcomingBloc>(
          create: (_) => UpcomingBloc()..add(UpcomingEventStart(0, '')),
        ),
      ],
      child: genrePage1(context),
    );
  }

  Widget genrePage1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          child: Row(
            children: [
              Icon(
                Icons.local_movies,
                color: Colors.yellow[800],
              ),
              Text(
                'NOW IN CINEMA',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[800],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Center();
            } else if (state is MovieLoaded) {
              List<Movie> movieList = state.movieList;

              return Container(
                height: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    Movie movie = movieList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage1(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 180,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 180,
                                height: 250,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 180,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${movie.voteA}/10',
                                style: TextStyle(
                                  color: Colors.yellow[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          child: Row(
            children: [
              Icon(
                Icons.movie_creation,
                color: Colors.yellow[800],
              ),
              Text(
                'UPCOMING MOVIES',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[800],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<UpcomingBloc, UpcomingState>(
          builder: (context, state) {
            if (state is UpcomingLoading) {
              return Center();
            } else if (state is UpcomingLoaded) {
              List<Upcoming> upcomingList = state.upcomingList;

              return Container(
                height: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: upcomingList.length,
                  itemBuilder: (context, index) {
                    Upcoming upcoming = upcomingList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpcomingDetailPage(upcoming: upcoming),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${upcoming.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 180,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 180,
                                height: 250,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 180,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            upcoming.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${upcoming.voteA}/10',
                                style: TextStyle(
                                  color: Colors.yellow[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
