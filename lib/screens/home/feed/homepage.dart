import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          CoinsList(
            title: "Top Gainers",
            subtitle: "24 Hours",
            coins: CoinsProvider.coins,
          ),
          CoinsList(
            title: "Top Losers",
            subtitle: "24 Hours",
            coins: CoinsProvider.coins,
          ),
          CoinsList(
            title: "Fundamentals",
            subtitle: "Coins with strong fundamentals",
            coins: CoinsProvider.coins,
          ),
          CoinsList(
            title: "Fundamentals",
            subtitle: "Coins with strong fundamentals",
            coins: CoinsProvider.coins,
          ),
        ],
      ),
    );
  }
}

class CoinsList extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Coin> coins;

  CoinsList({required this.title, required this.subtitle, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.black)),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: coins.length,
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(coins[index].imageUrl),
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
                          Spacer(),
                          Text(
                            coins[index].percentChange24h,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: coins[index].inProfit
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Spacer(),
                          Text(
                            "\$ " + coins[index].priceUsd.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Spacer(),
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
