import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/presentation/screens/brand_details_screen/bloc/brand_details_bloc.dart';
import 'package:rj/features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';

class HomeUseCases{
  static navigateToCategoryDetailsScreen(BuildContext context,String categoryTitle){
    //context.read<CategoryDetailsBloc>().add(CategoryListEvent(categoryName: categoryTitle));
    Navigator.pushNamed(context, RouteNames.categoryDetailsScreen,arguments: categoryTitle);
  }
  static navigateToBrandDetailsScreen(BuildContext context,BrandModel brandModel){
    context.read<BrandDetailsBloc>().add(FetchBrandDetailsEvent(brand: brandModel.name));
    Navigator.pushNamed(context, RouteNames.brandDetailsScreen,arguments: brandModel);
  }
}