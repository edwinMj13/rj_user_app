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
import 'package:rj/features/domain/use_cases/explore_page_usecase.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../main_screen/bloc/main_bloc.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(fetchProductDetailsEvent);
    on<AddToCartEventPrDtEvent>(addToCartEventPrDtEvent);
  }

  ExplorePageUseCase explorePageUseCase = ExplorePageUseCase();

  Future<void> fetchProductDetailsEvent(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsInitial());
    final productDetails = await locator<ProductRepo>().getProductDetails(event.nodeId);
    final userData = await CachedData.getUserDetails();
    final isInCart = await explorePageUseCase.checkIfProductInCart(
        event.nodeId, userData.nodeID);
    emit(FetchProductDetailsSuccessState(
        userProfileModel: userData,
        productModal: productDetails,
        userName: userData.name,
        isInCart: isInCart.toString()));
  }

  Future<void> addToCartEventPrDtEvent(
      AddToCartEventPrDtEvent event, Emitter<ProductDetailsState> emit) async {
    locator<CartRepository>().addToCart(event.model, event.nodeId).then((_) {
      event.callback();
      event.context.read<MainBloc>().add(UpdateIndexCarBadgeEvent(index: 3));
    });
  }
}
