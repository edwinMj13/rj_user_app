import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/services/cart_services.dart';
import 'package:rj/features/services/show_loading_services.dart';
import 'package:rj/utils/cached_data.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCartEvent>(fetchCartEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }
  CartServices cartServices = CartServices();
  Future<void> fetchCartEvent(FetchCartEvent event, Emitter<CartState> emit) async {

    final user = await CachedData.getUserDetails();
    final cartList = await cartServices.getCarts(user.nodeID);
    emit(FetchCartSuccess(cartList: cartList,userModel:user));
  }

  Future<void> removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    LoadingServices loadingServices = LoadingServices();
    loadingServices.showLoading(event.context, "Removing...");
    final user = await CachedData.getUserDetails();
    cartServices.removeFromCart(event.cartModel.firebaseNodeId, user.nodeID);
    await cartServices.getCarts(user.nodeID).then((listProducts){
      emit(FetchCartSuccess(cartList: listProducts,userModel:user));
      loadingServices.cancelLoading();
    });

  }
}
