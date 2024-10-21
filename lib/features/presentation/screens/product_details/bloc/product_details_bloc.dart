import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/repository/product_repository.dart';
import 'package:rj/features/data/repository/wishlist_repository.dart';
import 'package:rj/features/domain/use_cases/explore_page_usecase.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/domain/use_cases/product_details_usecase.dart';
import 'package:rj/features/presentation/screens/wish_list_screen/bloc/wish_list_bloc.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../main_screen/bloc/main_bloc.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<CheckInWishListOrCartEvent>(checkInWishListOrCartEvent);
    on<AddToCartEventPrDtEvent>(addToCartEventPrDtEvent);
    on<AddToWishListEventPrDtEvent>(addToWishListEventPrDtEvent);
    on<RemoveFromWishListEvent>(removeFromWishListEvent);
  }

  Future<void> checkInWishListOrCartEvent(CheckInWishListOrCartEvent event,
      Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsInitial());
    //final productDetails = await locator<ProductRepo>().getProductDetails(event.nodeId);
    final userData = await CachedData.getUserDetails();
    final isInCart = await ProductDetailsUseCase.checkIfProductInCart(
        event.productNodeId, userData.nodeID);
    final isInWIshlist = await ProductDetailsUseCase.checkIfProductInWishList(
        event.productNodeId, userData.nodeID);
    print("event.productNodeId ${event.productNodeId} ,   userData.nodeID  ${userData.nodeID}");
    print("in Cart $isInCart ,   isinWishList  $isInWIshlist");
    emit(CheckInWishListOrCartState(
        // userProfileModel: userData,
        // productModal: productDetails,
        // userName: userData.name,
        isInWishList: isInWIshlist.toString(),
        isInCart: isInCart.toString()));
  }

  Future<void> addToCartEventPrDtEvent(
      AddToCartEventPrDtEvent event, Emitter<ProductDetailsState> emit) async {
    print("ADDTO CART  ${event.model.toMap()}");
    await locator<CartRepository>()
        .addToCart(event.model, event.userNodeId)
        .then((_) {
      event.context.read<ProductDetailsBloc>().add(
          CheckInWishListOrCartEvent(productNodeId: event.model.productId));
      event.cancelLoading();
      event.context.read<MainBloc>().add(UpdateIndexCarBadgeEvent(index: 3));
    });
  }

  Future<void> addToWishListEventPrDtEvent(
      AddToWishListEventPrDtEvent event, Emitter<ProductDetailsState> emit) async {
    await locator<WishListRepo>()
        .addToWishList(event.userNodeId, event.model)
        .then((_) {
      event.context.read<ProductDetailsBloc>().add(
          CheckInWishListOrCartEvent(productNodeId: event.model.productId));
      event.cancelLoading();
    });
  }

  Future<void> removeFromWishListEvent(
      RemoveFromWishListEvent event, Emitter<ProductDetailsState> emit) async {
    final user = await CachedData.getUserDetails();
    final isWishlisted = await ProductDetailsUseCase.checkIfProductInWishList(
        event.productId, user.nodeID);
    print("isWislisted $isWishlisted");
    final wishlistNodeId = await ProductDetailsUseCase.getWishListProductIdToRemove(
        event.productId, user.nodeID);
    print("wishlistNodeId $wishlistNodeId");
    if (isWishlisted.toString() == "true") {
      await locator<WishListRepo>()
          .deleteFromWishList(user.nodeID, wishlistNodeId)
          .then((_) {
        event.context
            .read<ProductDetailsBloc>()
            .add(CheckInWishListOrCartEvent(productNodeId: event.productId));
        event.cancelLoading();
        event.context.read<WishListBloc>().add(FetchWishListedItems());
      });
    }
  }
}
