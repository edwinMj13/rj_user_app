part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent{
  final String nodeId;
  FetchProductDetailsEvent({required this.nodeId});
}

class AddToCartEventPrDtEvent extends ProductDetailsEvent{
  final ProductsModel model;
  final String nodeId;
  final VoidCallback callback;

  AddToCartEventPrDtEvent({required this.nodeId,required this.model,required this.callback});
}
