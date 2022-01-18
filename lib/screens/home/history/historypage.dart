import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../providers/history.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, value, child) => ListView.builder(
          itemCount: value.orders.length,
          itemBuilder: (context, index) {
            // Order card widget
            return _buildOrderCard(context, value.orders[index]);
          }),
    );
  }

  Container _buildOrderCard(BuildContext context, OrderModel orderModel) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Coin Logo
              CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundImage: NetworkImage(orderModel.imageUrl),
              ),
              SizedBox(
                width: 15,
              ),
              // DETAILS COLUM
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // Name and quantity
                        Text(
                          orderModel.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('Qty: ' + orderModel.quantity.toString(),
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    // Order type and Price
                    Row(
                      children: [
                        Text(
                          orderModel.type.toString(),
                          style: TextStyle(
                              color: orderModel.type.contains(
                                "BUY",
                              )
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          'Price: ' + orderModel.coinPrice.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    // Date and total
                    Row(
                      children: [
                        Text(DateFormat('dd/MM/yyyy, kk:mm')
                            .format(orderModel.date)),
                        Spacer(),
                        Text(
                          'Total: ' + orderModel.total.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
