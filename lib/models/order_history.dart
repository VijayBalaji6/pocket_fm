import 'dart:convert';
import 'package:pocket_fm/models/cart.dart';

class OrderHistory {
  final String orderId;
  final Cart products;
  final double totalAmount;
  final DateTime orderDate;

  OrderHistory({
    required this.orderId,
    required this.products,
    required this.totalAmount,
    required this.orderDate,
  });

  factory OrderHistory.fromMap(Map<String, dynamic> json) {
    return OrderHistory(
      orderId: json['orderId'] as String,
      products: Cart.fromMap(json['products'] as Map<String, dynamic>),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'products': products.toMap(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory OrderHistory.fromJson(String source) =>
      OrderHistory.fromMap(json.decode(source));
}
