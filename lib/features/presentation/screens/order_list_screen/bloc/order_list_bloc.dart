import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/data/repository/order_list_respository.dart';
import 'package:rj/utils/dependencyLocation.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(OrderListInitial()) {
    on<FetchOrderListEvent>(fetchOrderListEvent);
  }

  Future<void> fetchOrderListEvent(FetchOrderListEvent event, Emitter<OrderListState> emit) async {
    final user = await CachedData.getUserDetails();
    await locator<OrderListRepo>().getOrderList(user.nodeID).then((orderList){
      print("ORDERLIST - $orderList");
      emit(FetchOrderListSuccessSTate(orderList: orderList!));
    });
  }
}
