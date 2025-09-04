import 'package:flutter/widgets.dart';
import 'package:pocket_fm/models/all_orders.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/services/core/local_db_services.dart';

class OrderHistoryService {
  static final OrderHistoryService _instance = OrderHistoryService._internal();
  factory OrderHistoryService() => _instance;
  OrderHistoryService._internal();

  final String _orderHistoryKey = 'order_history';

  AllOrders? getAllOrderHistory() {
    try {
      Map<String, dynamic>? value = LocalDBServices.instance.getDataMap(
        _orderHistoryKey,
      );
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
      AllOrders allOrders = getAllOrderHistory() ?? AllOrders(orders: []);
      allOrders.orders.add(orderHistory);
      // allOrders.toJson() already returns a JSON string
      await LocalDBServices.instance.writeDataMap(
        key: _orderHistoryKey,
        value: allOrders.toJson(),
      );
    } catch (e) {
      debugPrint('Error writing data: $e');
      rethrow;
    }
  }
}
