import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/modules/orders_history/bloc/order_history_bloc.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (BuildContext context, OrderHistoryState state) {
          if (state is OrderHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderHistoryLoaded) {
            final List<OrderHistory> orders = state.allOrders.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final OrderHistory currentOrder = orders[index];

                return ListTile(
                  title: Text('Order #${currentOrder.orderId}'),
                  subtitle: Text('Total: \$${currentOrder.totalAmount}'),
                );
              },
            );
          } else if (state is OrderHistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
            child: Text('Order history details will be shown here.'),
          );
        },
      ),
    );
  }
}

class OrderHistoryDetails extends StatelessWidget {
  const OrderHistoryDetails({super.key, required this.orderDetails});
  final OrderHistory orderDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: ListTile(
          title: Text('Order #${orderDetails.orderId}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text('Total Amount: \$${orderDetails.totalAmount}'),
              const SizedBox(height: 4),
              Text('Date: ${orderDetails.orderDate}'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderDetails.products.cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final CartProduct cartItem =
                      orderDetails.products.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItem.products.name),
                        Text('Qty: ${cartItem.count}'),
                        Text('\$${cartItem.products.price * cartItem.count}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
