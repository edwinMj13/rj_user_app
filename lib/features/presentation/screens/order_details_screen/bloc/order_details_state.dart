part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsSuccessState extends OrderDetailsState{
  final OrderModel orderModel;

  OrderDetailsSuccessState({required this.orderModel});
}
