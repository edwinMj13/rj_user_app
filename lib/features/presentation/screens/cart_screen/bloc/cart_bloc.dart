import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/presentation/screens/main_screen/bloc/main_bloc.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../../domain/use_cases/cart_use_cases.dart';
import '../../../../domain/use_cases/show_loading_case.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCartEvent>(fetchCartEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
    on<CartUpdateEvent>(cartUpdateEvent);
  }

  ShowLoadingCase showLoadingCase = ShowLoadingCase();

  Future<void> fetchCartEvent(FetchCartEvent event,
      Emitter<CartState> emit) async {
    final user = await CachedData.getUserDetails();
    final cartList = await locator<CartRepository>().getCarts(user.nodeID);
    emit(FetchCartSuccess(cartList: cartList, userModel: user));
  }

  Future<void> removeFromCartEvent(RemoveFromCartEvent event,
      Emitter<CartState> emit) async {
    showLoadingCase.showLoading(event.context, "Removing...");

    final user = await CachedData.getUserDetails();
    locator<CartRepository>().removeFromCart(
        event.cartModel.firebaseNodeId, user.nodeID);

    // after removing from the cart the below code will help
    // refresh the cart section
    await locator<CartRepository>().getCarts(user.nodeID).then((listProducts) {
      emit(FetchCartSuccess(cartList: listProducts, userModel: user));
      showLoadingCase.cancelLoading();
      event.context.read<MainBloc>().add(UpdateIndexCarBadgeEvent(index: 3));
    });
  }

  Future<void> cartUpdateEvent(CartUpdateEvent event,
      Emitter<CartState> emit) async {
    showLoadingCase.showLoading(event.context, "Please Wait...");
    final user = await CachedData.getUserDetails();
    print("USER ID ${user.nodeID}");
    int totalItemAmount = CartUseCase.getTotalPrice(
        event.cartModel.sellingPrize, event.value);
    final cartingProduct = CartModel(
      itemName: event.cartModel.itemName,
      category: event.cartModel.category,
      firebaseNodeId: event.cartModel.firebaseNodeId,
      productId: event.cartModel.productId,
      status: event.cartModel.status,
      imagesList: event.cartModel.imagesList,
      subCategory: event.cartModel.subCategory,
      price: event.cartModel.price,
      stock: event.cartModel.stock,
      cartedQuantity: event.value,
      totalAmount: totalItemAmount,
      description: event.cartModel.description,
      itemBrand: event.cartModel.itemBrand,
      mainImage: event.cartModel.mainImage,
      sellingPrize: event.cartModel.sellingPrize,);

    locator<CartRepository>().updateCart(
        user.nodeID, event.cartModel.firebaseNodeId, cartingProduct);

    await locator<CartRepository>().getCarts(user.nodeID).then((listProducts) {
      emit(FetchCartSuccess(cartList: listProducts, userModel: user));
      showLoadingCase.cancelLoading();
    });
    // double lastAmt = CartUseCase.getCartTotal(totalItemAmount);
  }
}
