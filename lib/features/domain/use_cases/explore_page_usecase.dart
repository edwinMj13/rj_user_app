import 'package:flutter/cupertino.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/repository/product_repository.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dependencyLocation.dart';
import '../../presentation/screens/explore_screen/bloc/explore_bloc.dart';

class ExplorePageUseCase{

  static navigateToDetails(BuildContext context, ProductsModel productsModel) {
    return Navigator.pushNamed(
      context,
      RouteNames.productDetailsScreen,
      arguments: productsModel,
    );
  }

}