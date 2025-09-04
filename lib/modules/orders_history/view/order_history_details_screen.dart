import 'package:flutter/material.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/order_history.dart';

class OrderHistoryDetails extends StatelessWidget {
  const OrderHistoryDetails({super.key, required this.orderDetails});
  final OrderHistory orderDetails;

  @override
  Widget build(BuildContext context) {
    final String totalCount = orderDetails.totalAmount.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Order #${orderDetails.orderId},'),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                subtitle: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(),
                    Text(
                      'Total: \$ $totalCount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Date: ${orderDetails.orderDate}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Items', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(height: 20, color: Colors.grey),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderDetails.products.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final CartProduct cartItem =
                    orderDetails.products.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartItem.products.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Qty: ${cartItem.count}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Item total cost: \$${cartItem.products.price * cartItem.count}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
