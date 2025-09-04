import 'dart:convert';

import 'package:pocket_fm/models/product.dart';

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

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      productId: map['productId'] as String,
      count: map['count'] as int,
      products: Product.fromJson(map['products'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'count': count,
      'products': products.toJson(),
    };
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      CartProduct.fromMap(json.decode(source));
}

class Cart {
  final List<CartProduct> cartItems;

  Cart({required this.cartItems});

  Cart copyWith({CartProduct? cartProduct}) {
    return Cart(cartItems: cartProduct != null ? [cartProduct] : cartItems);
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartItems: map['cartItems'] != null
          ? List<CartProduct>.from(
              (map['cartItems'] as List).map(
                (item) => CartProduct.fromMap(
                  item is Map<String, dynamic>
                      ? item
                      : Map<String, dynamic>.from(item),
                ),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'cartItems': cartItems.map((item) => item.toMap()).toList()};
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
