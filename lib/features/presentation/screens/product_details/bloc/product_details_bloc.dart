import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/product_repository.dart';
import 'package:rj/utils/cached_data.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(fetchProductDetailsEvent);
    on<AddToCartEventPrDtEvent>(addToCartEventPrDtEvent);
  }

  Future<void> fetchProductDetailsEvent(FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    ProductRepo repo = ProductRepo();
    final dataModel = await repo.getProductDetails(event.nodeId);
    final userData = await CachedData.getUserDetails();
    final isInCart = await repo.checkIfProductInCart(event.nodeId,userData.nodeID);
    emit(FetchProductDetailsSuccessState(userProfileModel: userData,productModal: dataModel,userName: userData.name,isInCart: isInCart.toString()));
  }

  Future<void> addToCartEventPrDtEvent(AddToCartEventPrDtEvent event, Emitter<ProductDetailsState> emit) async {
    ProductRepo repo = ProductRepo();
    repo.addToCart(event.model,event.nodeId).then((_){
      event.callback();
    });
  }
}
