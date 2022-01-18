import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../providers/models/coins.dart';
import '../../utils/data.dart';

class CoinsProvider with ChangeNotifier {
  CoinsProvider() {
    fetchCoinsFromCoinGecko();
  }
  bool isLoading = true;
  Map<String, CoinGeckoCoinModel> _coins = {};
  Set<String> _favCoins = {};

  Future getCoin(String id) async {
    CoinGeckoCoinModel coin;
    id = COINS_DATA[id]!;
    final BASE_URL = "https://api.coingecko.com/api/v3/coins/$id";
    final url = Uri.parse(
        "$BASE_URL?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=true");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      coin = CoinGeckoCoinModel.fromCoinDetailsAPI(json.decode(response.body));
    } else {
      throw Exception('Failed to load coin');
    }
    _coins[id] = coin;
    notifyListeners();
    return coin;
  }

  List<CoinGeckoCoinModel> get topGainers {
    return _coins.values
        .where((coin) => double.parse(coin.priceChangePercentage_24h) > 0)
        .toList()
      ..sort((a, b) =>
          b.priceChangePercentage_24h.compareTo(a.priceChangePercentage_24h));
  }

  List<CoinGeckoCoinModel> get topLosers {
    return (_coins.values
            .where((coin) => double.parse(coin.priceChangePercentage_24h) < 0)
            .toList()
          ..sort((a, b) => a.priceChangePercentage_24h
              .compareTo(b.priceChangePercentage_24h)))
        .reversed
        .toList();
  }

  List<CoinGeckoCoinModel> get biggestMarketCap {
    return _coins.values
        .where((coin) => double.parse(coin.marketCap) > 1000000000)
        .toList()
      ..sort((a, b) => b.marketCap.compareTo(a.marketCap));
  }

  List<CoinGeckoCoinModel> get getfavCoins {
    List<CoinGeckoCoinModel> coins = [];
    for (var id in _favCoins) {
      if (_coins.containsKey(id)) {
        if (_coins[id] == null) {
          _coins.remove(id);
          _favCoins.remove(id);
          continue;
        } else
          coins.add(_coins[id]!);
      }
    }
    return coins;
  }

  bool isFavourite(String id) {
    return _favCoins.contains(id);
  }

  void addToFavourites(String id) {
    _favCoins.add(id);
    notifyListeners();
  }

  void removeFromFavourites(String id) {
    _favCoins.remove(id);
    notifyListeners();
  }

  List<CoinGeckoCoinModel> get coins {
    return _coins.values.toList();
  }

  Future<void> fetchCoinsFromCoinGecko() async {
    _coins.clear();
    isLoading = true;
    notifyListeners();

    final BASE_URL = "https://api.coingecko.com/api/v3/coins/markets";
    final vs_currency = "usd";
    final order = "market_cap_desc";
    final per_page = "20";
    final page = 1;
    final sparkline = true;
    final price_change_percentage = "7d";
    final url = Uri.parse(
        "$BASE_URL?vs_currency=$vs_currency&order=$order&per_page=$per_page&page=$page&sparkline=$sparkline&price_change_percentage=$price_change_percentage");

    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    final Map<String, CoinGeckoCoinModel> loadedCoins = {};
    for (var coin in extractedData) {
      loadedCoins[coin['id']] = (CoinGeckoCoinModel.fromJson(coin));
      // print("loaded");
    }
    _coins = loadedCoins;
    log(_coins.length.toString());
    isLoading = false;
    notifyListeners();
  }
}
