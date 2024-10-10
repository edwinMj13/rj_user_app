import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/wishlist_repository.dart';

import '../../../utils/dependencyLocation.dart';
import '../../data/repository/cart_repository.dart';

class ProductDetailsUseCase {
  static checkIfProductInCart(String prodId, String userNodeID) async {
    final dataMap =
        await locator<CartRepository>().getProductsInCart(userNodeID);
    final ifInCart =
        dataMap.where((test) => test["productId"].toString().contains(prodId));
    if (ifInCart.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static checkIfProductInWishList(String prodId, String userNodeID) async {
    final dataMap =
        await locator<WishListRepo>().getWIshListProductsToCheck(userNodeID);
    final ifInWishList =
        dataMap.where((test) => test["productId"].toString().contains(prodId));
    if (ifInWishList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static getWishListProductIdToRemove(String prodId, String userNodeID) async {
    final wishlist =
        await locator<WishListRepo>().getWIshListProducts(userNodeID);
    final data = wishlist
        .where((model) => model.productId == prodId).single;
    print("Wishlisted Product $data");
    return data.firebaseNodeId;
  }
}
