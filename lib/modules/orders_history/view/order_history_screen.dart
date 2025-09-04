import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pocket_fm/app_router.dart';
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
              padding: EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final OrderHistory currentOrder = orders[index];
                final String totalAmount = currentOrder.totalAmount
                    .toStringAsFixed(2);
                final String orderDate = DateFormat(
                  'yyyy-MM-dd hh:mm a',
                ).format(currentOrder.orderDate);
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.orderDetailsScreen.name,
                      extra: currentOrder,
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      title: Text('Order #${currentOrder.orderId},'),
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
                            'Total: \$$totalAmount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Date: $orderDate',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
