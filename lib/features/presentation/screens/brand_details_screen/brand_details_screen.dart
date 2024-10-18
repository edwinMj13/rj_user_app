import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/presentation/widgets/empty_list_widget.dart';
import 'package:rj/features/presentation/widgets/filter_bottom_sheet_content.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';

import '../../widgets/blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import '../../widgets/filter_icon_widget.dart';
import '../explore_screen/explore_screen.dart';
import 'bloc/brand_details_bloc.dart';

class BrandDetailsScreen extends StatelessWidget {
  const BrandDetailsScreen({
    super.key,
    required this.brandModel,
  });

  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brandModel.name),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(
                  onPressed: () {
                    //context.read<BottomSheetBloc>().add(CategoryBrandEvent());
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isDismissible: false,
                        builder: (context) =>  FilterBottomSheetContent(
                          tag: "Brand",
                          tagName: brandModel.name,
                        ));
                  },
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          ),
          Expanded(
            child: BlocBuilder<BrandDetailsBloc, BrandDetailsState>(
              builder: (context, state) {
                if (state is FetchProductsOfBrandSuccessState) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return ProductLayout(
                          productsModel: state.productList[index]);
                    },
                    itemCount: state.productList.length,
                  );
                } else if (state is FetchProductsOfBrandNULLState) {
                  return const EmptyListWidget();
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
