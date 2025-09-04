// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
  orderId: json['orderId'] as String,
  products: Cart.fromJson(json['products'] as String),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  orderDate: DateTime.parse(json['orderDate'] as String),
  orderedTime: DateTime.parse(json['orderedTime'] as String),
);

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'products': instance.products,
      'totalAmount': instance.totalAmount,
      'orderDate': instance.orderDate.toIso8601String(),
      'orderedTime': instance.orderedTime.toIso8601String(),
    };

AllOrders _$AllOrdersFromJson(Map<String, dynamic> json) => AllOrders(
  orders: (json['orders'] as List<dynamic>)
      .map((e) => OrderHistory.fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$AllOrdersToJson(AllOrders instance) => <String, dynamic>{
  'orders': instance.orders,
};
