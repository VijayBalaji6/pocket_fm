import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/models/cart.dart';
import 'package:pocket_fm/models/order_history.dart';
import 'package:pocket_fm/services/order_history_services.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<GetOrderHistory>(_onGetOrderHistory);
    on<UpdateOrderHistory>(_onUpdateOrderHistory);
  }

  Future<void> _onGetOrderHistory(
    GetOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderHistoryLoading());
    try {
      final AllOrders? allOrders = await OrderHistoryService()
          .getAllOrderHistory();
      emit(OrderHistoryLoaded(allOrders ?? AllOrders(orders: [])));
    } catch (e) {
      emit(OrderHistoryError('Failed to fetch order history $e'));
    }
  }

  Future<void> _onUpdateOrderHistory(
    UpdateOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderHistoryLoading());
    try {
      await OrderHistoryService().saveOrderHistory(event.orderedItem);
      final allOrders = await OrderHistoryService().getAllOrderHistory();
      emit(OrderHistoryLoaded(allOrders ?? AllOrders(orders: [])));
    } catch (e) {
      emit(OrderHistoryError('Failed to refresh order history $e'));
    }
  }
}
