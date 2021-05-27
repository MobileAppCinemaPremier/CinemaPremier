import 'package:cinema_premier/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/login_screen.dart';
import 'pages/signup_screen.dart';
import 'pages/book_page.dart';
import 'models/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Authentication(),
        )
      ],
      child: MaterialApp(
        title: 'Cinema Premier',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),
          BookTicketPage.routeName : (ctx) => BookTicketPage(),
          HomePage.routeName: (ctx)=> HomePage(),
        },
      ),
    );
  }
}
