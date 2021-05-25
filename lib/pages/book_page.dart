import 'package:cinema_premier/data/detail/bloc_detail.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/book_page/date.dart';
import 'package:cinema_premier/pages/book_page/payment.dart';
import 'package:cinema_premier/pages/book_page/seat.dart';
import 'package:cinema_premier/pages/book_page/theater.dart';
import 'package:cinema_premier/pages/book_page/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookTicketPage extends StatelessWidget {
  final Movie movie;
  const BookTicketPage({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailBloc()..add(DetailEventStated(movie.id)),
      child: WillPopScope(
        child: Scaffold(
          body: bookTicketPageBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget bookTicketPageBody(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      if (state is DetailLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is DetailLoaded) {
        Detail movieDetail = state.detail;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              '${movieDetail.title.toUpperCase()}',
              style: TextStyle(
                  color: Colors.yellow[800], fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  DateSelect(),
                  TimeSelect(),
                  Theater(),
                  SeatSelect(),
                  Payment(),
                ],
              )),
        );
      }
    });
  }
}
