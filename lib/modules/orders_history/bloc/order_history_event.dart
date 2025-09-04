part of 'order_history_bloc.dart';

@immutable
sealed class OrderHistoryEvent {}

class GetOrderHistory extends OrderHistoryEvent {}

class UpdateOrderHistory extends OrderHistoryEvent {
  final OrderHistory orderedItem;

  UpdateOrderHistory(this.orderedItem);
}
