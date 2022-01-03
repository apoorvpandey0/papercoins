import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:papercoins/providers/models/coins.dart';
import 'package:papercoins/screens/home/market/coin-details-screen.dart';
import 'package:papercoins/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MarketPage extends StatefulWidget {
  @override
  MarketPageState createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(
      builder: (context, value, child) => DefaultTabController(
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
                    AllCoinsListWidget(coins: value.coins),
                    AllCoinsListWidget(coins: value.coins),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllCoinsListWidget extends StatelessWidget {
  final List<CoinGeckoCoinModel> coins;

  const AllCoinsListWidget({Key? key, required this.coins}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // A list of items
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return CoinListTileWidget(coin: coins[index]);
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
            currencyFormatter(coin.currentPrice),
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            coin.symbol.toUpperCase(),
          ),
          Spacer(),
          Text(
            currencyFormatter(coin.priceChangePercentage_24h),
            style: TextStyle(
              color: coin.priceChangePercentage_24h.contains("-")
                  ? Colors.red
                  : Colors.green,
            ),
          ),
        ],
      ),
      enableFeedback: true,
      // trailing: Text("-10%"),
    );
  }
}

// class AllCoinsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.amber,
//         child: Center(
//           child: Text(
//             'All Coins',
//           ),
//         ));
//   }
// }
