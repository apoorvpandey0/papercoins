import 'package:flutter/material.dart';
import 'package:papercoins/providers/investments.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PortfolioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<InvestmentsProvider>(
      builder: (context, value, child) => Container(
          child: Column(
        children: [
          // Portfolio value
          _buildPortfolioCard(value.portfolioModel),
          // List of all purchased coins
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                return _buildCoinCard(value.items[index]);
              },
            ),
          ),
        ],
      )),
    );
  }

  Card _buildCoinCard(ItemModel itemModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // image and name half of the card
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 10),
                Text(
                  itemModel.name,
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  itemModel.quantity + " " + itemModel.symbol,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            Divider(),
            // Bottom half of the card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Returns",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "₹ " + itemModel.returns.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color:
                              itemModel.inProfit ? Colors.green : Colors.red),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Current",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "₹ " + itemModel.currentPrice.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Invested",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "₹ " + itemModel.investedAmount.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPortfolioCard(PortfolioModel portfolioModel) {
    return Container(
        height: 200,
        width: double.infinity,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹ " + portfolioModel.currentValue.toString(),
                style: TextStyle(fontSize: 35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ " + portfolioModel.changeInINR.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: portfolioModel.inProfit
                            ? Colors.green
                            : Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    portfolioModel.changeInPercent.toString() + "%",
                    style: TextStyle(
                        fontSize: 12,
                        color: portfolioModel.inProfit
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
