import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';

import '../../widgets/appbar_common.dart';
import '../../widgets/filter_bottom_sheet_content.dart';

class CategoryDetailsScreen extends StatelessWidget {
  String? categoryTitle;
   CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    categoryTitle = ModalRoute.of(context)?.settings.arguments.toString();
    context
        .read<CategoryDetailsBloc>()
        .add(CategoryListEvent(categoryName: categoryTitle!));
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppbarCommon(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isDismissible: true,
                        builder: (context) => FilterBottomSheetContent());
                  },
                  icon: const Icon(Icons.filter_alt_outlined))
            ],
          ),
          BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
            builder: (context, state) {
              switch(state.runtimeType){
                case FetchCategoryDetailsState :
                  final stateData = state as FetchCategoryDetailsState;
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return ProductLayout(
                      productsModel: stateData.productList[index],
                    );
                  },
                  itemCount: stateData.productList.length,
                );
                default :
              return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
