import 'package:cinema_premier/data/detail/bloc_detail.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/book_page/date.dart';
import 'package:cinema_premier/pages/book_page/seat.dart';
import 'package:cinema_premier/pages/book_page/theater.dart';
import 'package:cinema_premier/pages/book_page/time.dart';
import 'package:cinema_premier/pages/payment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookTicketPage extends StatelessWidget {
  static const routeName = '/bookticket';
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
    Size size = MediaQuery.of(context).size;
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
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    DateSelect(),
                    TimeSelect(),
                    Theater(),
                    SeatSelect(),
                    Expanded(
                      flex: 13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20 * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 15.0,
                                      width: 15.0,
                                      margin: EdgeInsets.only(right: 8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      "Available",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 15.0,
                                      width: 15.0,
                                      margin: EdgeInsets.only(right: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Resvered",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 15.0,
                                      width: 15.0,
                                      margin: EdgeInsets.only(right: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Color(0xffF9B015)),
                                    ),
                                    Text(
                                      "Selected",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: Center(
                                  child: Text(
                                    'Rp. 50.000,00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              FlatButton(
                                color: Color(0xffF9B015),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Paymentscreen(movie: movie),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: size.width * 0.45,
                                  height: size.width * 0.08,
                                  child: Center(
                                    child: Text(
                                      'Pay',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )));
      }
    });
  }
}
