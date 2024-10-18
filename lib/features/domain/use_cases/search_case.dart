import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/search_repository.dart';

import '../../../utils/dependencyLocation.dart';
import '../../data/repository/explore_repo.dart';

class SearchCase{
  static Future<List<ProductsModel>> getFilteredList(String letter) async {
    final productList = await locator<ExploreRepo>().getAllProducts();
    return productList.where((model)=>model.itemName.toLowerCase().contains(letter)).toList();
  }
}