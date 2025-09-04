import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_fm/models/cart.dart';

part 'order_history.g.dart';

@JsonSerializable()
class OrderHistory {
  final String orderId;
  final Cart products;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime orderedTime;

  OrderHistory({
    required this.orderId,
    required this.products,
    required this.totalAmount,
    required this.orderDate,
    required this.orderedTime,
  });

  factory OrderHistory.fromMap(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map<String, dynamic> toMap() => _$OrderHistoryToJson(this);

  String toJson() => json.encode(toMap());

  factory OrderHistory.fromJson(String source) =>
      _$OrderHistoryFromJson(json.decode(source));
}

@JsonSerializable()
class AllOrders {
  final List<OrderHistory> orders;

  AllOrders({required this.orders});

  factory AllOrders.fromMap(Map<String, dynamic> map) =>
      _$AllOrdersFromJson(map);

  Map<String, dynamic> toMap() => _$AllOrdersToJson(this);

  String toJson() => json.encode(toJson());

  factory AllOrders.fromJson(String source) =>
      _$AllOrdersFromJson(json.decode(source));
}
