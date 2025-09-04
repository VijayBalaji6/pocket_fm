part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartFetchItems extends CartEvent {}

class AddProductToCart extends CartEvent {
  final Product item;
  AddProductToCart(this.item);
}

class RemoveProductFromCart extends CartEvent {
  final String productId;
  RemoveProductFromCart(this.productId);
}

class ClearCart extends CartEvent {}

class CheckoutCart extends CartEvent {}
