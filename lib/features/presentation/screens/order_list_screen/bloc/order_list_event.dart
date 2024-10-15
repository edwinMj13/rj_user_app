part of 'order_list_bloc.dart';

@immutable
sealed class OrderListEvent {}

class FetchOrderListEvent extends OrderListEvent{
  // final String userNodeId;
  //final String orderNodeIdInUser;

  FetchOrderListEvent();
}
