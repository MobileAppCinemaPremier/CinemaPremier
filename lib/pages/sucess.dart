import 'package:cinema_premier/data/detail/bloc_detail.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/book_page/date.dart';
import 'package:cinema_premier/pages/book_page/seat.dart';
import 'package:cinema_premier/pages/book_page/theater.dart';
import 'package:cinema_premier/pages/book_page/time.dart';
import 'package:cinema_premier/pages/payment_page/paymentui.dart';
import 'package:cinema_premier/pages/ticket_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessScreen extends StatelessWidget {
  final Movie movie;
  const SuccessScreen({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailBloc()..add(DetailEventStated(movie.id)),
      child: WillPopScope(
        child: Scaffold(
          body: paymentPageBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget paymentPageBody(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      if (state is DetailLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is DetailLoaded) {
        Detail movieDetail = state.detail;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/success.gif'),
                height: 200,
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Your Payment Was Done Successfully',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: FlatButton(
                  color: Colors.yellow[800],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketScreen(movie: movie),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: 300,
                    height: 50,
                    child: Center(
                      child: Text(
                        'SEE TICKET',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
