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
  List<CoinGeckoCoinModel> _coins = [];

  List<CoinGeckoCoinModel> get coins {
    return [..._coins];
  }

  void fetchCoinsFromCoinGecko() async {
    _coins.clear();
    isLoading = true;
    notifyListeners();

    final BASE_URL = "https://api.coingecko.com/api/v3/coins/markets";
    final vs_currency = "inr";
    final order = "market_cap_desc";
    final per_page = "20";
    final page = 1;
    final sparkline = true;
    final price_change_percentage = "7d";
    final url = Uri.parse(
        "$BASE_URL?vs_currency=$vs_currency&order=$order&per_page=$per_page&page=$page&sparkline=$sparkline&price_change_percentage=$price_change_percentage");

    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    final List<CoinGeckoCoinModel> loadedCoins = [];
    for (var coin in extractedData) {
      loadedCoins.add(CoinGeckoCoinModel.fromJson(coin));
      // print("loaded");
    }
    _coins = loadedCoins;
    log(_coins.length.toString());
    isLoading = false;
    notifyListeners();
  }
}
