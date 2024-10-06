import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/utils/dependencyLocation.dart';

class CategoryDetailsCase {
  Future<List<ProductsModel>> getCategoryProductsList(String categoryName) async {
    final allProducts = await locator<ExploreRepo>().getAllProducts();
    final productsOnCategory = allProducts.where((model)=>model.category==categoryName).toList();
    return productsOnCategory;
  }
}