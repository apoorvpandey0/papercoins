import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../providers/coins.dart';
import '../../../providers/models/coins.dart';
import '../../../screens/home/market/buy-sell-screen.dart';
import '../../../utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CoinDetailsPage extends StatefulWidget {
  final CoinGeckoCoinModel coin;

  CoinDetailsPage({required this.coin});

  @override
  _CoinDetailsPageState createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  int chartIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return BuyCoinPage();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
          child: ListView(children: [
            _buildHeader(),
            _buildGraphSection(),
            SizedBox(height: 20),
            _buildCoinPerformanceSection(),
            _buildCoinGauge(),
          ]),
        ),
      ),
      bottomNavigationBar: _buildBuySellButtons(),
    );
  }

  SfRadialGauge _buildCoinGauge() {
    double _getGaugePointer() {
      // log(widget.coin.priceChangePercentage_7dInCurrency);
      double x = double.parse(widget.coin.priceChangePercentage_7dInCurrency);
      double c = 2 * (100 / 6);
      return 1 * x + c;
    }

    return SfRadialGauge(
      title: GaugeTitle(
        text: 'Fear/Greed Index',
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      enableLoadingAnimation: true,
      axes: [
        RadialAxis(
            showLabels: true,
            startAngle: 180,
            endAngle: 360,
            radiusFactor: 0.8,
            interval: 100,
            ranges: [
              // First
              GaugeRange(
                startValue: 0,
                endValue: 1 * (100 / 6),
                color: Colors.red,
                startWidth: 20,
                endWidth: 20,
              ),
              // Second
              GaugeRange(
                  startValue: 1 * (100 / 6),
                  endValue: 2 * (100 / 6),
                  color: Colors.redAccent,
                  startWidth: 20,
                  endWidth: 20),
              // Third
              GaugeRange(
                  startValue: 2 * (100 / 6),
                  endValue: 3 * (100 / 6),
                  color: Colors.orange,
                  startWidth: 20,
                  endWidth: 20),
              // Fourth
              GaugeRange(
                  startValue: 3 * (100 / 6),
                  endValue: 4 * (100 / 6),
                  color: Colors.orangeAccent,
                  startWidth: 20,
                  endWidth: 20),
              // Fifth
              GaugeRange(
                  startValue: 4 * (100 / 6),
                  endValue: 5 * (100 / 6),
                  color: Colors.lightGreen,
                  startWidth: 20,
                  endWidth: 20),
              // sIXTH
              GaugeRange(
                  startValue: 5 * (100 / 6),
                  endValue: 6 * (100 / 6),
                  color: Colors.green,
                  startWidth: 20,
                  endWidth: 20),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: _getGaugePointer(),
                needleLength: 0.8,
              ),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Fear',
                  value: 16,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerOffset: -0.12),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Neutral',
                  value: 50,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerOffset: -0.12),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Greed',
                  value: 83,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerOffset: -0.12)
            ])
      ],
    );
  }

  Column _buildCoinPerformanceSection() {
    return Column(
      children: [
        Text("Price data",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Current Price",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                currencyFormatter((widget.coin.currentPrice)),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "24h High",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                currencyFormatter((widget.coin.high_24h)),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "24h Low",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                currencyFormatter((widget.coin.low_24h)),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "7 days high",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                currencyFormatter((widget.coin.sparklineIn_7d.price.reduce(
                    (value, element) => value > element ? value : element))),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "7 days low",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                currencyFormatter((widget.coin.sparklineIn_7d.price.reduce(
                    (value, element) => value < element ? value : element))),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildGraphSection() {
    final List<Color> color = <Color>[];
    color.add(Colors.white);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
        colors: color, stops: stops, transform: GradientRotation(3 * 3.14 / 2));
    return Column(
      children: [
        // BottomNavigationBar(
        //     elevation: 1,
        //     type: BottomNavigationBarType.fixed,
        //     currentIndex: chartIndex,
        //     onTap: (value) {
        //       setState(() {
        //         chartIndex = value;
        //       });
        //     },
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Text("1 Hour"),
        //         activeIcon: Text(
        //           "1 Hour",
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         title: Container(
        //           height: 0,
        //         ),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Text("1 Day"),
        //         activeIcon: Text(
        //           "1 Day",
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         title: Container(
        //           height: 0.0,
        //         ),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Text("1 Week"),
        //         activeIcon: Text(
        //           "1 Week",
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         title: Container(
        //           height: 0.0,
        //         ),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Text("1 Year"),
        //         activeIcon: Text(
        //           "1 Year",
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         title: Container(
        //           height: 0.0,
        //         ),
        //       ),
        //     ]),
        Text("1 Week chart",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCartesianChart(
            crosshairBehavior: CrosshairBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              lineType: CrosshairLineType.horizontal,
            ),
            primaryXAxis: NumericAxis(
              isVisible: false,
              majorGridLines: MajorGridLines(width: 0),
              interval: 1,
              minimum: 0,
              maximum: 100,
              // labelFormat: 'MMM dd',
              // labelRotation: 90,
            ),
            series: <ChartSeries>[
              AreaSeries(
                gradient: gradientColors,
                yAxisName: "Price",
                dataSource: widget.coin.sparklineIn_7d.price,
                xValueMapper: (data, _) => _,
                enableTooltip: true,
                yValueMapper: (data, _) => data,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Consumer<CoinsProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(widget.coin.image),
          ),
          title: Text(
            widget.coin.name + " (" + widget.coin.symbol.toUpperCase() + ")",
            style: TextStyle(fontSize: 20),
          ),
          trailing: Container(
            width: 50,
            child: Row(
              children: [
                Spacer(),
                IconButton(
                  icon: value.isFavourite(widget.coin.id)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(LineIcons.heart),
                  onPressed: () {
                    value.isFavourite(widget.coin.id)
                        ? value.removeFromFavourites(widget.coin.id)
                        : value.addToFavourites(widget.coin.id);
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.fullscreen),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBuySellButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            // Add a buy and sell button
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text("BUY"),
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                        context: context, builder: (context) => BuyCoinPage());
                  },
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("SELL"),
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => BuyCoinPage(),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
