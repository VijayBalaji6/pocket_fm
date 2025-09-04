import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/data/product_mock_data.dart';
import 'package:pocket_fm/models/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 1), () {});
    try {
      emit(
        HomeLoaded(
          ProductMockData.mockProducts
              .map((Map<String, dynamic> item) => Product.fromJson(item))
              .toList(),
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
