import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CoinDetailsPage extends StatefulWidget {
  final Coin coin;

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
        child: ListView(children: [
          _buildHeader(),
          _buildGraphSection(),
          SizedBox(height: 20),
          _buildCoinPerformanceSection(),
          _buildCoinGauge(),
        ]),
      ),
      bottomNavigationBar: _buildBuySellButtons(),
    );
  }

  SfRadialGauge _buildCoinGauge() {
    return SfRadialGauge(
      title: GaugeTitle(
        text: 'Coin Performance',
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
                value: 40,
                needleLength: 0.8,
              ),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Poor',
                  value: 16,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerOffset: -0.12),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Average',
                  value: 50,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerOffset: -0.12),
              MarkerPointer(
                  markerType: MarkerType.text,
                  text: 'Good',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Market Cap",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "coin.marketCap",
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
                "24h Volume",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "coin.volume",
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
                "24h Volume",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "coin.volume",
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
                "24h Volume",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "coin.volume",
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
                "24h Volume",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "coin.volume",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildGraphSection() {
    return Column(
      children: [
        BottomNavigationBar(
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            currentIndex: chartIndex,
            onTap: (value) {
              setState(() {
                chartIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Text("1 Hour"),
                activeIcon: Text(
                  "1 Hour",
                  style: TextStyle(color: Colors.blue),
                ),
                title: Container(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Text("1 Day"),
                activeIcon: Text(
                  "1 Day",
                  style: TextStyle(color: Colors.blue),
                ),
                title: Container(
                  height: 0.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Text("1 Week"),
                activeIcon: Text(
                  "1 Week",
                  style: TextStyle(color: Colors.blue),
                ),
                title: Container(
                  height: 0.0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Text("1 Year"),
                activeIcon: Text(
                  "1 Year",
                  style: TextStyle(color: Colors.blue),
                ),
                title: Container(
                  height: 0.0,
                ),
              ),
            ]),
        SizedBox(height: 10),
        SfSparkLineChart(
          axisLineColor: Colors.transparent,
          data: [1, 2, 3, 4, 8, 9, 10, 9, 6, 5, 8, 3, 7, 34, 8, 90, 3, 0],
        ),
      ],
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(widget.coin.imageUrl),
        ),
        title: Text(
          widget.coin.name,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Container(
          width: 50,
          child: Row(
            children: [
              Spacer(),
              IconButton(
                icon: Icon(LineIcons.heart),
                onPressed: () {},
              ),
              // IconButton(
              //   icon: Icon(Icons.fullscreen),
              //   onPressed: () {},
              // ),
            ],
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

class BuyCoinPage extends StatelessWidget {
  const BuyCoinPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Buy Bitcoin",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Funds available to invest:"),
                  Text(
                    "₹ " + "19,999,000",
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter amount to buy in INR",
                    labelText: "Amount",
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.check, color: Colors.green),
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Colors.black,
                      // width: 2,
                    ),
                  ),
                ),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Place order",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
