import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:papercoins/providers/models/coins.dart';
import 'package:papercoins/screens/home/market/coin-details-screen.dart';
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
                backgroundColor: Colors.grey[200],
                elevation: 0,
                bottom: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
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
      itemCount: 1,
      itemBuilder: (context, index) {
        return Text("data");
        // return CoinListTileWidget(coin: );
      },
    );
  }
}

class CoinListTileWidget extends StatelessWidget {
  final CoinGeckoCoinModel coin;
  CoinListTileWidget({required this.coin});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => CoinDetailsPage(coin: coin));
        // showCupertinoModalBottomSheet(
        //     context: context, builder: (context) => Container());
      },
      leading: CircleAvatar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(coin.image),
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
            coin.currentPrice.toString(),
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
            coin.priceChangePercentage_24h.toString(),
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
