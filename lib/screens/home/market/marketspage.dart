import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../providers/coins.dart';
import '../../../providers/models/coins.dart';
import '../../../screens/home/market/coin-details-screen.dart';
import '../../../utils/data.dart';
import '../../../utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final coins = Provider.of<CoinsProvider>(context);
    final suggestions = COINS_DATA.keys
        .where((coin) => coin.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (suggestions.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    }
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            CoinGeckoCoinModel coin =
                await Provider.of<CoinsProvider>(context, listen: false)
                    .getCoin(suggestions[index]) as CoinGeckoCoinModel;

            showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => CoinDetailsPage(coin: coin));
          },
          title: Text(suggestions[index].toString()),
        );
        // return CoinListTileWidget(
        //   coin: suggestions[index],
        // );
      },
    );
  }
}

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
              // Search field
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 50,
                  child: GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context, delegate: MySearchDelegate());
                      },
                      child: AbsorbPointer(child: CupertinoSearchTextField())),
                ),
              ),

              // All coins/ Watchlist  - the tab bar with two items
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
                        text: "All Coins",
                      ),
                      Tab(
                        text: "My Watchlist",
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
                    AllCoinsListWidget(coins: value.getfavCoins),
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
    if (Provider.of<CoinsProvider>(context).isLoading)
      return _buildAllCoinsListWidgetShimmer();
    // A list of items
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return CoinListTileWidget(coin: coins[index]);
        // return CoinListTileWidget(coin: );
      },
    );
  }

  Shimmer _buildAllCoinsListWidgetShimmer() {
    return Shimmer(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 15,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ],
                ),

                enableFeedback: true,
                // trailing: Text("-10%"),
              ),
            );
            // return CoinListTileWidget(coin: );
          },
        ),
        gradient: LinearGradient(colors: [Colors.grey.shade100, Colors.grey]));
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
            (coin.priceChange_24h.contains('-') ? '▾' : '▴') +
                double.parse(coin.priceChangePercentage_24h)
                    .toStringAsFixed(2) +
                "%",
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
