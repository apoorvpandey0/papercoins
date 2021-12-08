import 'package:flutter/cupertino.dart';

class ItemModel {
  String name;
  String symbol;
  String quantity;
  String currentPrice;
  String investedAmount;
  String imageUrl;
  String coinAmount;
  String returns;
  bool inProfit;
  ItemModel({
    required this.name,
    required this.symbol,
    required this.quantity,
    required this.currentPrice,
    required this.investedAmount,
    required this.imageUrl,
    required this.coinAmount,
    required this.returns,
    required this.inProfit,
  });
}

class PortfolioModel {
  String currentValue;
  String totalInvested;
  String changeInINR;
  String changeInPercent;
  bool inProfit;
  PortfolioModel(
      {required this.currentValue,
      required this.totalInvested,
      required this.changeInINR,
      required this.changeInPercent,
      required this.inProfit});
}

class InvestmentsProvider with ChangeNotifier {
  PortfolioModel _portfolioModel = PortfolioModel(
    currentValue: '14900',
    totalInvested: '10000',
    changeInINR: '600',
    changeInPercent: '14',
    inProfit: true,
  );
  List<ItemModel> _items = [
    ItemModel(
      symbol: "BTC",
      quantity: "15",
      name: 'Bitcoin',
      currentPrice: '12000',
      investedAmount: '4000',
      imageUrl: 'assets/images/bitcoin.png',
      coinAmount: '1',
      returns: '10000',
      inProfit: true,
    ),
    ItemModel(
      symbol: "ETH",
      quantity: "15",
      name: 'Ethereum',
      currentPrice: '12000',
      investedAmount: '1000',
      imageUrl: 'assets/images/ethereum.png',
      coinAmount: '1',
      returns: '10000',
      inProfit: true,
    ),
    ItemModel(
      symbol: "XRP",
      quantity: "15",
      name: 'Ripple',
      currentPrice: '12000',
      investedAmount: '2000',
      imageUrl: 'assets/images/ripple.png',
      coinAmount: '1',
      returns: '10000',
      inProfit: true,
    ),
    ItemModel(
      symbol: "LTC",
      quantity: "15",
      name: 'Bitcoin Cash',
      currentPrice: '12000',
      investedAmount: '1000',
      imageUrl: 'assets/images/bitcoin-cash.png',
      coinAmount: '1',
      returns: '10000',
      inProfit: true,
    ),
    ItemModel(
      symbol: "BCH",
      quantity: "15",
      name: 'Litecoin',
      currentPrice: '12000',
      investedAmount: '500',
      imageUrl: 'assets/images/litecoin.png',
      coinAmount: '1',
      returns: '10000',
      inProfit: true,
    ),
    ItemModel(
        symbol: "XLM",
        quantity: "15",
        name: 'EOS',
        currentPrice: '12000',
        investedAmount: '500',
        imageUrl: 'assets/images/eos.png',
        coinAmount: '1',
        returns: '10000',
        inProfit: true)
  ];
  // getters
  PortfolioModel get portfolioModel => _portfolioModel;
  List<ItemModel> get items => _items;
}