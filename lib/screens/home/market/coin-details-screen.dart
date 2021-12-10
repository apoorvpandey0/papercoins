import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:papercoins/providers/coins.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
    return Scaffold(
      body: Container(
        child: Column(children: [
          _buildHeader(),
          // Graph section starts here
          _buildGraphSection(),
          SizedBox(height: 20),
          //  Coin performance section
          _buildCoinPerformanceSection(),
          Spacer(),
          _buildBuySellButtons()
        ]),
      ),
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
          width: 200,
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
                      context: context,
                      builder: (context) => Container(),
                    );
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
                      builder: (context) => Container(),
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
