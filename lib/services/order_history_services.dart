import 'package:flutter/widgets.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/services/core/local_db_services.dart';

class OrderHistoryService {
  static final OrderHistoryService _instance = OrderHistoryService._internal();
  factory OrderHistoryService() => _instance;
  OrderHistoryService._internal();

  final String _orderHistoryKey = 'order_history';

  Future<AllOrders?> getAllOrderHistory() async {
    try {
      String? value = await LocalDBServices.instance.getData(_orderHistoryKey);
      if (value != null) {
        return AllOrders.fromJson(value);
      } else {
        return AllOrders(orders: []);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveOrderHistory(OrderHistory orderHistory) async {
    try {
      AllOrders allOrders = await getAllOrderHistory() ?? AllOrders(orders: []);

      allOrders.orders.add(orderHistory);

      await LocalDBServices.instance.writeData(
        key: _orderHistoryKey,
        value: allOrders.toJson(),
      );
    } catch (e) {
      debugPrint('Error writing data: $e');
      rethrow;
    }
  }
}
