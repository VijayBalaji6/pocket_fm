part of 'order_history_bloc.dart';

@immutable
sealed class OrderHistoryState {}

final class OrderHistoryInitial extends OrderHistoryState {}

final class OrderHistoryLoading extends OrderHistoryState {}

final class OrderHistoryLoaded extends OrderHistoryState {
  final AllOrders allOrders;
  OrderHistoryLoaded(this.allOrders);
}

final class OrderHistoryError extends OrderHistoryState {
  final String message;
  OrderHistoryError(this.message);
}
