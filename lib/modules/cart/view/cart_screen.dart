import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/modules/cart/bloc/cart_bloc.dart';
import 'package:pocket_fm/modules/orders_history/bloc/order_history_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) {
        final List<CartProduct> cartItems =
            (state as CartLoaded).cart.cartItems;

        bool isCartEmpty = cartItems.isEmpty;

        double totalAmount = cartItems.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.products.price * element.count),
        );
        return Scaffold(
          appBar: AppBar(title: const Text('Cart')),
          bottomNavigationBar: isCartEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'clearCartBtn',
                        onPressed: () {
                          context.read<CartBloc>().add(ClearCart());
                        },
                        label: const Text('Clear Cart'),
                        icon: const Icon(Icons.clear),
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'checkoutCartBtn',
                        onPressed: () {
                          DateTime orderTime = DateTime.now();
                          String orderId = orderTime.millisecondsSinceEpoch
                              .toString();
                          context.read<OrderHistoryBloc>().add(
                            UpdateOrderHistory(
                              OrderHistory(
                                orderId: orderId,
                                products: Cart(cartItems: cartItems),
                                totalAmount: totalAmount,
                                orderDate: orderTime,
                              ),
                            ),
                          );
                          context.read<CartBloc>().add(CheckoutCart());
                        },
                        label: const Text('Checkout Cart'),
                        icon: const Icon(Icons.shopping_bag),
                      ),
                    ],
                  ),
                ),
          body: (isCartEmpty)
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  children: [
                    Text(
                      'Total Amount: \$ ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CartProduct item = cartItems[index];
                          final double totalPrice = double.parse(
                            (item.products.price * item.count).toStringAsFixed(
                              2,
                            ),
                          );
                          final double itemPrice = double.parse(
                            (item.products.price).toStringAsFixed(2),
                          );
                          return Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  spacing: 15,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.products.name),
                                    Row(
                                      spacing: 20,
                                      children: [
                                        Text('Item Cost: $itemPrice'),
                                        Text('Quantity: ${item.count}'),
                                      ],
                                    ),
                                    Text('Total item Price: \$ $totalPrice'),
                                    Row(
                                      spacing: 30,
                                      children: [
                                        ElevatedButton(
                                          child: const Icon(Icons.remove),
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              RemoveProductFromCart(
                                                item.productId,
                                              ),
                                            );
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Icon(Icons.add),
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              AddProductToCart(item.products),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
