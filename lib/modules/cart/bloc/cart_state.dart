part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final Cart cart;
  CartLoaded(this.cart);
}
