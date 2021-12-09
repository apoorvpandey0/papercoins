import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        height: 100,
        width: double.infinity,
        child: Card(
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
      ),
      ListTile(
        title: Text('Reset portfolio'),
        trailing: Icon(Icons.delete),
      ),
      ListTile(
        title: Text('Rate the app'),
        trailing: Icon(Icons.star),
      ),
      ListTile(
        title: Text('Share the app'),
        trailing: Icon(Icons.share),
      ),
      ListTile(
        title: Text('About'),
        trailing: Icon(Icons.info),
      ),
    ]);
  }
}
