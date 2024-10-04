import 'package:rj/features/data/repository/product_repository.dart';

import '../../../utils/dependencyLocation.dart';

class ExplorePageUseCase{

  checkIfProductInCart(String prodId, String nodeID) async {
    final dataMap = await locator<ProductRepo>().getProductsInCart(prodId, nodeID);
    final ifInCart =
    dataMap.where((test) => test["productId"].toString().contains(prodId));
    if (ifInCart.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}