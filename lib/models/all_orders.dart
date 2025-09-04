import 'package:pocket_fm/models/order_history.dart';

class AllOrders {
  final List<OrderHistory> orders;

  AllOrders({required this.orders});
  factory AllOrders.fromJson(Map<String, dynamic> json) {
    return AllOrders(
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((e) => OrderHistory.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'orders': orders.map((order) => order.toJson()).toList()};
  }
}
