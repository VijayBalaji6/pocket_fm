import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartFetchItems>(_onCartFetchItems);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<ClearCart>(_onClearCart);
    on<CheckoutCart>(_onCheckoutCart);
  }

  void _onCartFetchItems(CartFetchItems event, Emitter<CartState> emit) {
    emit(CartLoaded(Cart(cartItems: [])));
  }

  void _onAddProductToCart(AddProductToCart event, Emitter<CartState> emit) {
    final Cart currentCart = state is CartLoaded
        ? (state as CartLoaded).cart
        : Cart(cartItems: []);
    final List<CartProduct> updatedCartItems = List<CartProduct>.from(
      currentCart.cartItems,
    );
    final int existingIndex = updatedCartItems.indexWhere(
      (item) => item.productId == event.item.id,
    );

    if (existingIndex != -1) {
      final CartProduct existingProduct = updatedCartItems[existingIndex];
      updatedCartItems[existingIndex] = existingProduct.copyWith(
        count: existingProduct.count + 1,
      );

      emit(CartLoaded(Cart(cartItems: updatedCartItems)));
    } else {
      updatedCartItems.add(
        CartProduct(productId: event.item.id, count: 1, products: event.item),
      );

      emit(CartLoaded(Cart(cartItems: updatedCartItems)));
    }
  }

  void _onRemoveProductFromCart(
    RemoveProductFromCart event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      final CartLoaded cartLoaded = state as CartLoaded;
      final List<CartProduct> updatedCartItems = List<CartProduct>.from(
        cartLoaded.cart.cartItems,
      );
      final int index = updatedCartItems.indexWhere(
        (item) => item.productId == event.productId,
      );

      if (index != -1) {
        final CartProduct currentProduct = updatedCartItems[index];
        if (currentProduct.count > 1) {
          updatedCartItems[index] = currentProduct.copyWith(
            count: currentProduct.count - 1,
          );
        } else {
          updatedCartItems.removeAt(index);
        }
        emit(CartLoaded(Cart(cartItems: updatedCartItems)));
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartLoaded(Cart(cartItems: [])));
  }

  void _onCheckoutCart(CheckoutCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      emit(CartLoaded(Cart(cartItems: [])));
    }
  }
}
