import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';
import 'package:rj/features/data/repository/product_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../data/models/brand_model.dart';

class BrandDetailsUseCase{
  static Future<List<ProductsModel>> getProductsOfBrand(String brand) async {
    final data = await locator<ExploreRepo>().getAllProducts();
    final brandProducts = data.where((model)=>model.itemBrand==brand).toList();
    print("brandProducts    $brandProducts");
    return brandProducts;
  }
}