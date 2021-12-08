import 'package:flutter/material.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:papercoins/providers/history.dart';
import 'package:papercoins/screens/home/home-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CoinsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
