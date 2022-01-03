import 'package:flutter/material.dart';

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
