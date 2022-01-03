import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:papercoins/providers/models/coins.dart';

class CoinsProvider with ChangeNotifier {
  CoinsProvider() {
    fetchCoinsFromCoinGecko();
  }
  bool isLoading = true;
  Map<String, CoinGeckoCoinModel> _coins = {};
  Set<String> _favCoins = {};

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
    print(_favCoins);
    notifyListeners();
  }

  void removeFromFavourites(String id) {
    _favCoins.remove(id);
    notifyListeners();
  }

  List<CoinGeckoCoinModel> get coins {
    return _coins.values.toList();
  }

  void fetchCoinsFromCoinGecko() async {
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
