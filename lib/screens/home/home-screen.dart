import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:papercoins/screens/home/feed/homepage.dart';
import 'package:papercoins/screens/home/history/historypage.dart';
import 'package:papercoins/screens/home/market/marketspage.dart';
import 'package:papercoins/screens/home/portfolio/portfoliopage.dart';
import 'package:papercoins/screens/home/settings/settingspage.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PaperCoins'),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          MarketPage(),
          HistoryPage(),
          PortfolioPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() => pageIndex = value);
          _pageController.jumpToPage(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.landmark),
            title: Text('Markets'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.history),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.wallet),
            title: Text('Investments'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}