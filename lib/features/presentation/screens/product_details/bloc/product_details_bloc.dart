import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/product_repository.dart';
import 'package:rj/utils/cached_data.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(fetchProductDetailsEvent);
  }

  Future<void> fetchProductDetailsEvent(FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    ProductRepo repo = ProductRepo();
    final dataModel = await repo.getProductDetails(event.nodeId);
    final userName = await CachedData.getUserName();
    emit(FetchProductDetailsSuccessState(productModal: dataModel,userName: userName));
  }
}
