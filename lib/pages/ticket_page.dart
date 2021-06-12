import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_premier/data/detail/bloc_detail.dart';
import 'package:cinema_premier/data/detail/bloc_eventd.dart';
import 'package:cinema_premier/data/detail/bloc_stated.dart';
import 'package:cinema_premier/data/detail/cast.data.dart';
import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:cinema_premier/data/movie/movie_data.dart';
import 'package:cinema_premier/pages/after_login/home1_page.dart';
import 'package:cinema_premier/pages/book_page/date.dart';
import 'package:cinema_premier/pages/book_page/seat.dart';
import 'package:cinema_premier/pages/book_page/theater.dart';
import 'package:cinema_premier/pages/book_page/time.dart';
import 'package:cinema_premier/pages/payment_page/paymentui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketScreen extends StatelessWidget {
  final Movie movie;
  const TicketScreen({Key key, this.movie}) : super(key: key);
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
          body: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
              child: ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png'),
                        ),
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      '${movieDetail.originalTitle.toUpperCase()}',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'date'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                                fontSize: 16),
                          ),
                          Text(
                            '17 Jun 2021',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cinema'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                                fontSize: 16),
                          ),
                          Text(
                            'Cinema XXI',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Time'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                                fontSize: 16),
                          ),
                          Text(
                            '1:30 PM',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Seat'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                                fontSize: 16),
                          ),
                          Text(
                            'B2',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Booking ID'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                                fontSize: 16),
                          ),
                          Text(
                            '410${movieDetail.id}',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: FlatButton(
                      color: Colors.yellow[800],
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/qrcode.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              )),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        width: 130,
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.qr_code,
                                color: Colors.white,
                              ),
                              Text(
                                'QR CODE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: FlatButton(
                      color: Colors.yellow[800],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage1(),
                          ),
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              Text(
                                'BACK TO MENU',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      }
    });
  }
}
