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
          _buildPortfolioCard(value.portfolioModel, value.items),
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
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.network(itemModel.imageUrl),
                ),
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

  Container _buildPortfolioCard(
      PortfolioModel portfolioModel, List<ItemModel> items) {
    return Container(
        height: 400,
        width: double.infinity,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfCircularChart(
                legend: Legend(
                  isVisible: true,
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  duration: 1500,
                  canShowMarker: false,
                  format: 'point.x : point.y',
                ),
                series: [
                  DoughnutSeries<ItemModel, String>(
                    dataSource: items,
                    // explode: true,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      labelAlignment: ChartDataLabelAlignment.middle,
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    xValueMapper: (ItemModel data, _) => data.name,
                    yValueMapper: (ItemModel data, _) =>
                        int.parse(data.investedAmount),
                    enableTooltip: true,
                    dataLabelMapper: (ItemModel data, _) =>
                        (double.parse(data.investedAmount) /
                                double.parse(portfolioModel.totalInvested) *
                                100)
                            .toStringAsFixed(2) +
                        "%",
                  ),
                ],
              ),
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
