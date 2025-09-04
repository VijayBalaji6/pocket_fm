// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
  productId: json['productId'] as String,
  count: (json['count'] as num).toInt(),
  products: Product.fromJson(json['products'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
      'products': instance.products,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
  cartItems: (json['cartItems'] as List<dynamic>)
      .map((e) => CartProduct.fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'cartItems': instance.cartItems,
};
