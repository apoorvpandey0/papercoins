import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MarketPage extends StatefulWidget {
  @override
  MarketPageState createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            // construct the profile details widget here
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(height: 50, child: CupertinoSearchTextField()),
            ),

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                // backgroundColor: Colors.transparent,
                elevation: 0,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "My Watchlist",
                    ),
                    Tab(
                      text: "All Coins",
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  AllCoinsListWidget(),
                  AllCoinsListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllCoinsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // A list of items
    return ListView.builder(
      itemCount: CoinsProvider.coins.length,
      itemBuilder: (context, index) {
        return CoinListTileWidget(coin: CoinsProvider.coins[index]);
      },
    );
  }
}

class CoinDetailsBottomSheet extends StatefulWidget {
  final Coin coin;

  CoinDetailsBottomSheet({required this.coin});

  @override
  _CoinDetailsBottomSheetState createState() => _CoinDetailsBottomSheetState();
}

class _CoinDetailsBottomSheetState extends State<CoinDetailsBottomSheet> {
  int chartIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(widget.coin.imageUrl),
          ),
          title: Text(
            widget.coin.name,
            style: TextStyle(fontSize: 20),
          ),
          trailing: IconButton(
            icon: Icon(LineIcons.heart),
            onPressed: () {},
          ),
        ),
      ),
      // Graph section starts here
      BottomNavigationBar(
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          currentIndex: chartIndex,
          onTap: (value) {
            setState(() {
              chartIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Text("1 Hour"),
              activeIcon: Text(
                "1 Hour",
                style: TextStyle(color: Colors.blue),
              ),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Text("1 Day"),
              activeIcon: Text(
                "1 Day",
                style: TextStyle(color: Colors.blue),
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Text("1 Week"),
              activeIcon: Text(
                "1 Week",
                style: TextStyle(color: Colors.blue),
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Text("1 Year"),
              activeIcon: Text(
                "1 Year",
                style: TextStyle(color: Colors.blue),
              ),
              title: Container(
                height: 0.0,
              ),
            ),
          ]),
      Spacer(),
      SfSparkLineChart(
        axisLineColor: Colors.transparent,
        data: [1, 2, 3, 4, 8, 9, 10, 9, 6, 5, 8, 3, 7, 34, 8, 90, 3, 0],
      ),
      SizedBox(height: 20),
      //  Coin performance section
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Market Cap",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "coin.marketCap",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "24h Volume",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "coin.volume",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),

      Spacer(),
      _buildBuySellButtons()
    ]);
  }

  Padding _buildBuySellButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            // Add a buy and sell button
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text("BUY"),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("SELL"),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class CoinListTileWidget extends StatelessWidget {
  Coin coin;
  CoinListTileWidget({required this.coin});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => CoinDetailsBottomSheet(coin: coin));
      },
      leading: CircleAvatar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(coin.imageUrl),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            coin.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            coin.priceUsd,
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            coin.symbol,
          ),
          Spacer(),
          Text(
            coin.percentChange24h,
          ),
        ],
      ),
      enableFeedback: true,
      // trailing: Text("-10%"),
    );
  }
}

class AllCoinsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: Center(
          child: Text(
            'All Coins',
          ),
        ));
  }
}
