import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'package:rj/features/presentation/widgets/empty_list_widget.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';

import '../../widgets/appbar_common.dart';
import '../../widgets/blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import '../../widgets/filter_bottom_sheet_content.dart';
import '../../widgets/filter_icon_widget.dart';
import '../explore_screen/explore_screen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  CategoryDetailsScreen({super.key,required this.categoryName});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    context
        .read<CategoryDetailsBloc>()
        .add(CategoryListEvent(categoryName: widget.categoryName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppbarCommon(),
      ),
      body: Column(
        children: [
          _filterSection(context),
          const ProductListWidget(),
        ],
      ),
    );
  }

  Row _filterSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        IconButton(
            onPressed: () {
              //context.read<BottomSheetBloc>().add(CategoryBrandEvent());
              showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  isDismissible: false,
                  builder: (context) =>   FilterBottomSheetContent(
                    tag: "Category",
                    tagName: widget.categoryName,
                  ));
            },
            icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case FetchCategoryDetailsState:
            final stateData = state as FetchCategoryDetailsState;
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return ProductLayout(
                  productsModel: stateData.productList[index],
                );
              },
              itemCount: stateData.productList.length,
            );
          case FetchCategoryDetailsNULLState:
            return EmptyListWidget();
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
