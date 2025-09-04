import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/product.dart';
import 'package:pocket_fm/modules/cart/bloc/cart_bloc.dart';
import 'package:pocket_fm/modules/home/bloc/home_bloc.dart';
import 'package:pocket_fm/modules/orders_history/bloc/order_history_bloc.dart';
import 'package:pocket_fm/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<OrderHistoryBloc>().add(GetOrderHistory());
              await context.pushNamed(AppRoutes.orderHistoryScreen.name);
            },
            icon: const Icon(Icons.calendar_today_sharp),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          int cartItems = 0;
          if (state is CartLoaded) {
            cartItems = state.cart.cartItems.length;
          }
          return FloatingActionButton.extended(
            onPressed: () async {
              await context.pushNamed(AppRoutes.cartScreen.name);
            },
            label: Row(
              spacing: 10,
              children: [
                Icon(Icons.shopping_cart),
                if (state is CartLoaded && cartItems > 0) Text('($cartItems)'),
              ],
            ),
          );
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final List<Product> products = state.products;
            return BlocBuilder<CartBloc, CartState>(
              builder: (BuildContext context, CartState state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: products.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          final Product currentItem = products[index];
                          return ListTile(
                            title: Text(currentItem.name),
                            subtitle: Column(
                              spacing: 20,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentItem.description),
                                Row(
                                  spacing: 8,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('\$ ${currentItem.price}'),
                                    ((state as CartLoaded).cart.cartItems.any(
                                          (item) =>
                                              item.productId == currentItem.id,
                                        ))
                                        ? Builder(
                                            builder: (context) {
                                              final CartProduct cartItem =
                                                  (state).cart.cartItems
                                                      .firstWhere(
                                                        (item) =>
                                                            item.productId ==
                                                            currentItem.id,
                                                      );
                                              return Row(
                                                spacing: 10,
                                                children: [
                                                  Text(
                                                    "Count: ${cartItem.count}",
                                                  ),
                                                  ElevatedButton(
                                                    child: const Icon(
                                                      Icons.remove,
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            RemoveProductFromCart(
                                                              currentItem.id,
                                                            ),
                                                          );
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    child: const Icon(
                                                      Icons.add,
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            AddProductToCart(
                                                              currentItem,
                                                            ),
                                                          );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : ElevatedButton(
                                            child: Text("Add to cart"),
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                AddProductToCart(currentItem),
                                              );
                                            },
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
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Welcome to the Home Screen!'));
        },
      ),
    );
  }
}
