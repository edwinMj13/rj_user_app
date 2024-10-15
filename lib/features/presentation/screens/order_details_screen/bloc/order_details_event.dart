part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsEvent {}


class FetchOrderDetailsEvent extends OrderDetailsEvent{
  final String orderId;

  FetchOrderDetailsEvent({required this.orderId});

}