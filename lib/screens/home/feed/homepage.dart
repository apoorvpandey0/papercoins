import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:papercoins/providers/models/coins.dart';
import 'package:papercoins/screens/home/market/coin-details-screen.dart';
import 'package:papercoins/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(
      builder: (context, value, child) => Container(
        child: RefreshIndicator(
          onRefresh: () => value.fetchCoinsFromCoinGecko(),
          child: ListView(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/844124/pexels-photo-844124.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                                fit: BoxFit.cover)),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
                child: Column(
                  children: [
                    CoinsList(
                      title: "Top Gainers",
                      subtitle: "24 Hours",
                      coins: value.topGainers,
                    ),
                    CoinsList(
                      title: "Top Losers",
                      subtitle: "24 Hours",
                      coins: value.topLosers,
                    ),
                    CoinsList(
                      title: "Market Capitalization",
                      subtitle: "Coins with biggest market capitalization",
                      coins: value.biggestMarketCap,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CoinsList extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<CoinGeckoCoinModel> coins;

  CoinsList({required this.title, required this.subtitle, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(
      builder: (context, value, child) => value.isLoading
          ? CoinsListShimmer(title: title, subtitle: subtitle)
          : Container(
              height: 200,
              // color: Colors.amber,
              margin: EdgeInsets.only(left: 8, right: 8, top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 5),
                  Text(subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.black)),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: coins.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    CoinDetailsPage(coin: coins[index]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 130,
                                width: 130,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              NetworkImage(coins[index].image),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            coins[index].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Spacer(),
                                    Text(
                                      currencyFormatter(
                                          coins[index].currentPrice),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    // Spacer(),
                                    Text(
                                      (coins[index]
                                                  .priceChange_24h
                                                  .contains('-')
                                              ? '▾'
                                              : '▴') +
                                          double.parse(coins[index]
                                                  .priceChangePercentage_24h)
                                              .toStringAsFixed(2) +
                                          "%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: coins[index]
                                                .priceChange_24h
                                                .contains('-')
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CoinsListShimmer extends StatelessWidget {
  const CoinsListShimmer({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 20),
      height: 210,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey,
        // enabled: _enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 5),
            Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.black)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      width: 130,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
