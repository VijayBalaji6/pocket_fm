import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/services/core/local_db_services.dart';

class OrderHistoryService {
  static final OrderHistoryService _instance = OrderHistoryService._internal();
  factory OrderHistoryService() => _instance;
  OrderHistoryService._internal();

  final String _orderHistoryKey = 'order_history';

  Future<AllOrders?> getAllOrderHistory() async {
    try {
      String? value = await LocalDBServices().getData(_orderHistoryKey);
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
      if (allOrders.orders.isNotEmpty) {
        allOrders.orders.add(orderHistory);
      }

      await LocalDBServices().writeData(_orderHistoryKey, allOrders.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
