import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../models/products_model.dart';

class FilterRepo{
  Future<List<ProductsModel>> getProductsFilter(String brand, String category, String sub,
      double startSlider, double endSlider) async {
    final allProducts = await locator<ExploreRepo>().getAllProducts();
    List<ProductsModel> filteredProducts =  allProducts
        .where((model) =>
    model.category == category &&
        model.itemBrand == brand &&
        model.subCategory == sub &&
        double.parse(model.sellingPrize) <= endSlider &&
        double.parse(model.sellingPrize) >= startSlider)
        .toList();
    print("Filtered Items $filteredProducts");
    return filteredProducts;
  }
}