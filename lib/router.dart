import 'package:go_router/go_router.dart';
import 'package:pocket_fm/modules/cart/view/cart_screen.dart';
import 'package:pocket_fm/modules/home/view/home_screen.dart';
import 'package:pocket_fm/modules/orders_history/view/order_history_screen.dart';

enum AppRoutes { homeScreen, cartScreen, orderHistoryScreen }

class AppRouter {
  static final GoRouter appRoutes = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        name: AppRoutes.homeScreen.name,
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.cartScreen.name,
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        name: AppRoutes.orderHistoryScreen.name,
        path: '/orderHistory',
        builder: (context, state) => const OrderHistoryScreen(),
      ),
    ],
  );
}
