import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/data/repository/order_details_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitial()) {
    on<FetchOrderDetailsEvent>(fetchOrdderDetailsEvent);
  }

  Future<void> fetchOrdderDetailsEvent(FetchOrderDetailsEvent event, Emitter<OrderDetailsState> emit) async {
    final user = await CachedData.getUserDetails();
    await locator<OrderDetailsRepo>().getOrderDetails(event.orderId, user.nodeID).then((orderModel){
      emit(OrderDetailsSuccessState(orderModel: orderModel));
    });
  }
}
