import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:papercoins/providers/history.dart';
import 'package:papercoins/providers/investments.dart';
import 'package:papercoins/screens/home/home-screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(
          create: (context) => InvestmentsProvider(),
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
