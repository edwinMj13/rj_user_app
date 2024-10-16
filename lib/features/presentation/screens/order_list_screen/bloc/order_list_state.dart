part of 'order_list_bloc.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}

 class FetchOrderListSuccessSTate extends OrderListState {
  final List<OrderModel?> orderList;

  FetchOrderListSuccessSTate({required this.orderList});
}
class FetchOrderListNULLState extends OrderListState{}
