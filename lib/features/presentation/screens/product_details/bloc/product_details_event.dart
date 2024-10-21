part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent {}

class CheckInWishListOrCartEvent extends ProductDetailsEvent{
  final String productNodeId;
  CheckInWishListOrCartEvent({required this.productNodeId});
}



class AddToCartEventPrDtEvent extends ProductDetailsEvent{
  final ProductsModel model;
  final String userNodeId;
  final VoidCallback cancelLoading;
  final BuildContext context;

  AddToCartEventPrDtEvent({required this.userNodeId,required this.model,required this.cancelLoading,required this.context});
}
class AddToWishListEventPrDtEvent extends ProductDetailsEvent{
  final ProductsModel model;
  final String userNodeId;
  final VoidCallback cancelLoading;
  final BuildContext context;

  AddToWishListEventPrDtEvent({required this.userNodeId,required this.model,required this.cancelLoading,required this.context});
}

class RemoveFromWishListEvent extends ProductDetailsEvent{
  final String productId;
  final BuildContext context;
  final VoidCallback cancelLoading;
  RemoveFromWishListEvent({required this.productId,required this.context,required this.cancelLoading});
}