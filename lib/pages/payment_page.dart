import 'package:cinema_premier/data/detail/bloc_detail.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/payment_page/paymentui.dart';
import 'package:cinema_premier/pages/sucess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Paymentscreen extends StatelessWidget {
  final Movie movie;
  const Paymentscreen({Key key, this.movie}) : super(key: key);
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
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'PAYMENT',
                style: TextStyle(
                    color: Colors.yellow[800], fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'Choose Your Payment Method!',
                    style: TextStyle(
                        color: Colors.yellow[900],
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: PaymentUi()),
                FlatButton(
                  color: Colors.yellow[800],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessScreen(movie: movie),
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
                        'Pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      }
    });
  }
}
