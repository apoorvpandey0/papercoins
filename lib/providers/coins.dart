import 'package:flutter/foundation.dart';

class Coin {
  late String id;
  late String name;
  late String imageUrl;
  late String symbol;
  late String priceUsd;
  late String percentChange24h;

  Coin(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.symbol,
      required this.priceUsd,
      required this.percentChange24h});
}

class CoinsProvider with ChangeNotifier {
  static List<Coin> _coins = [
    Coin(
        id: "1",
        name: "Bitcoin",
        imageUrl: "https://www.cryptocompare.com/media/19633/btc.png",
        symbol: "BTC",
        priceUsd: "55,230",
        percentChange24h: "-10%"),
    Coin(
        id: "2",
        name: "Ethereum",
        imageUrl: "https://cryptologos.cc/logos/ethereum-eth-logo.png?v=014",
        symbol: "ETH",
        priceUsd: "10,230",
        percentChange24h: "-10%"),
    Coin(
        id: "3",
        name: "Solana",
        imageUrl: "https://cryptologos.cc/logos/solana-sol-logo.png?v=014",
        symbol: "SOL",
        priceUsd: "10,230",
        percentChange24h: "-10%"),
    Coin(
        id: "4",
        name: "Litecoin",
        imageUrl: "https://cryptologos.cc/logos/litecoin-ltc-logo.png?v=014",
        symbol: "LTC",
        priceUsd: "10,230",
        percentChange24h: "-10%"),
    Coin(
        id: "5",
        name: "Shiba INU Cash",
        imageUrl: "https://cryptologos.cc/logos/shiba-inu-shib-logo.png?v=014",
        symbol: "SHIB",
        priceUsd: "10,230",
        percentChange24h: "-10%"),
    Coin(
        id: "6",
        name: "Uniswap",
        imageUrl: "https://cryptologos.cc/logos/uniswap-uni-logo.png?v=014",
        symbol: "UNI",
        priceUsd: "10,230",
        percentChange24h: "-10%"),
  ];

  static List<Coin> get coins {
    return [..._coins];
  }

  void fetchCoins() async {}
}
