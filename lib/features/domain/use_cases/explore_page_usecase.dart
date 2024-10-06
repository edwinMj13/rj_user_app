import 'package:flutter/cupertino.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/repository/product_repository.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dependencyLocation.dart';
import '../../presentation/screens/explore_screen/bloc/explore_bloc.dart';

class ExplorePageUseCase{

  checkIfProductInCart(String prodId, String nodeID) async {
    final dataMap = await locator<CartRepository>().getProductsInCart(prodId, nodeID);
    final ifInCart =
    dataMap.where((test) => test["productId"].toString().contains(prodId));
    if (ifInCart.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static navigateToDetails(BuildContext context, String firebaseNodeId) {
    return Navigator.pushNamed(
      context,
      RouteNames.productDetailsScreen,
      arguments: firebaseNodeId,
    );
  }
}