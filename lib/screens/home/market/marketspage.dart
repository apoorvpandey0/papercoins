import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:papercoins/providers/coins.dart';

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

class CoinListTileWidget extends StatelessWidget {
  Coin coin;
  CoinListTileWidget({required this.coin});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
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
