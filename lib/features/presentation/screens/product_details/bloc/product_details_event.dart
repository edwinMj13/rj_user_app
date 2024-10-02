part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent {}
class FetchProductDetailsEvent extends ProductDetailsEvent{
  final String nodeId;

  FetchProductDetailsEvent({required this.nodeId});
}
