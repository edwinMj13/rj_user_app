import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../../domain/use_cases/show_loading_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCartEvent>(fetchCartEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }
  Future<void> fetchCartEvent(FetchCartEvent event, Emitter<CartState> emit) async {

    final user = await CachedData.getUserDetails();
    final cartList = await locator<CartRepository>().getCarts(user.nodeID);
    emit(FetchCartSuccess(cartList: cartList,userModel:user));
  }

  Future<void> removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    ShowLoadingCase showLoadingCase = ShowLoadingCase();
    showLoadingCase.showLoading(event.context, "Removing...");

    final user = await CachedData.getUserDetails();
    locator<CartRepository>().removeFromCart(event.cartModel.firebaseNodeId, user.nodeID);

    // after removing from the cart the below code will help
    // refresh the cart section
    await locator<CartRepository>().getCarts(user.nodeID).then((listProducts){
      emit(FetchCartSuccess(cartList: listProducts,userModel:user));
      showLoadingCase.cancelLoading();
    });

  }
}
