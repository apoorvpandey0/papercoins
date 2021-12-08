import 'package:flutter/material.dart';

class OrderModel {
  String name;
  String type;
  DateTime date;
  String coinPrice;
  String total;
  String quantity;
  String imageUrl;

  OrderModel(
      {required this.name,
      required this.date,
      required this.type,
      required this.coinPrice,
      required this.total,
      required this.quantity,
      required this.imageUrl});
}

class HistoryProvider with ChangeNotifier {
  List<OrderModel> _orders = [
    OrderModel(
        name: "Bitcoin",
        type: "BUY",
        date: DateTime.now(),
        coinPrice: "50,000 USD",
        total: "10,000",
        quantity: "10",
        imageUrl: "https://www.cryptocompare.com/media/19633/btc.png"),
    OrderModel(
        name: "Ethereum",
        type: "SELL",
        date: DateTime.now(),
        coinPrice: "50,000 USD",
        total: "10,000",
        quantity: "10",
        imageUrl: "https://cryptologos.cc/logos/ethereum-eth-logo.png?v=014"),
  ];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(
      {required String coin,
      required DateTime date,
      required String type,
      required String coinPrice,
      required String total,
      required String quantity,
      required String imageUrl}) {
    _orders.add(OrderModel(
        name: coin,
        date: date,
        type: type,
        coinPrice: coinPrice,
        total: total,
        quantity: quantity,
        imageUrl: imageUrl));
    notifyListeners();
  }
}
