import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_fm/models/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartProduct {
  final String productId;
  final int count;
  final Product products;

  CartProduct({
    required this.productId,
    required this.count,
    required this.products,
  });

  CartProduct copyWith({String? productId, int? count, Product? products}) {
    return CartProduct(
      productId: productId ?? this.productId,
      count: count ?? this.count,
      products: products ?? this.products,
    );
  }

  factory CartProduct.fromMap(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toMap() => _$CartProductToJson(this);

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      _$CartProductFromJson(json.decode(source));
}

@JsonSerializable()
class Cart {
  final List<CartProduct> cartItems;

  Cart({required this.cartItems});

  Cart copyWith({CartProduct? cartProduct}) {
    return Cart(cartItems: cartProduct != null ? [cartProduct] : cartItems);
  }

  factory Cart.fromMap(Map<String, dynamic> map) => _$CartFromJson(map);

  Map<String, dynamic> toMap() => _$CartToJson(this);

  String toJson() => json.encode(toJson());

  factory Cart.fromJson(String source) => _$CartFromJson(json.decode(source));
}
