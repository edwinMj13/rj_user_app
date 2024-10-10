import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/wishlist_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<FetchWishListedItems>(fetchWishListedItems);
  }

  Future<void> fetchWishListedItems(FetchWishListedItems event, Emitter<WishListState> emit) async {
    final user = await CachedData.getUserDetails();
    await locator<WishListRepo>().getWIshListProducts(user.nodeID).then((list){
      //print(list);
      if(list.isNotEmpty) {
        emit(FetchWishListSuccessState(productsModel: list));
      }else{
        emit(FetchWishListNullState());
      }
    });
  }
}
