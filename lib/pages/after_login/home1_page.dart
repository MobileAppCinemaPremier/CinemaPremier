import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_premier/data/movie/bloc_eventm.dart';
import 'package:cinema_premier/data/movie/bloc_movie.dart';
import 'package:cinema_premier/data/movie/bloc_statem.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/after_login/detail1_page.dart';
import 'package:cinema_premier/pages/after_login/genre1_page.dart';
import 'package:cinema_premier/pages/detail_page.dart';
import 'package:cinema_premier/pages/genre_page.dart';
import 'package:cinema_premier/pages/home_page.dart';
import 'package:cinema_premier/pages/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage1 extends StatelessWidget {
  static const routeName = '/home1';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
            create: (_) => MovieBloc()..add(MovieEventStart(0, ''))),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'CINEMA PREMIER',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.yellow[800],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Member',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                accountEmail: Text('Member of Cinema Premier'),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.yellow[900],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'What is Cinema Premier?',
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                leading: Icon(
                  Icons.developer_board,
                  color: Colors.yellow[900],
                ),
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('What is Cinema Premier?'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Cinema Premier is a movie ticket booking app made by group of UNTARs college student for UAS Mobile Programming UNTAR. This app made to simulate movie ticket booking app. All the movies title and details are fetched from themoviedb API. If you want to start booking some movie ticket, please be sure to log in first and become a member of the Cinema Premier. Please Enjoy'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )),
              ),
            ],
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    List<Movie> movies = state.movieList;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (BuildContext context, int index, int) {
                            Movie movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage1(movie: movie),
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                    ),
                                    child: Text(
                                      movie.title.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 700),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              CategoryWidget1(),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container(
                      child: Text('Error'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
