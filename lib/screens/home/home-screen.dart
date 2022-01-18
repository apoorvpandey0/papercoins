import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../providers/coins.dart';
import '../../screens/home/feed/homepage.dart';
import '../../screens/home/history/historypage.dart';
import '../../screens/home/market/marketspage.dart';
import '../../screens/home/portfolio/portfoliopage.dart';
import '../../screens/home/settings/settingspage.dart';
import 'package:provider/provider.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            filterQuality: FilterQuality.high,
            height: 40,
          ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // await FirebaseFirestore.instance
            //     .collection('users')
            //     .add({"hi": 123});
            await Provider.of<CoinsProvider>(context, listen: false)
                .fetchCoinsFromCoinGecko();
          },
          child: Icon(LineIcons.plus),
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
      ),
    );
  }
}
