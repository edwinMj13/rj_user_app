import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/domain/use_cases/explore_page_usecase.dart';
import 'package:rj/features/presentation/screens/explore_screen/widgets/empty_explore_widget.dart';
import 'package:rj/features/presentation/widgets/slide_up_animation_widget.dart';
import 'package:rj/features/presentation/widgets/filter_bottom_sheet_content.dart';
import 'package:rj/features/presentation/widgets/slide_to_right_animation_widget.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../../domain/use_cases/show_loading_with_out_text.dart';
import '../../widgets/blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import '../../widgets/product_layout.dart';
import 'bloc/explore_bloc.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    context.read<ExploreBloc>().add(ProductsFetchAllEvent());
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    Timer(const Duration(milliseconds: 200),
        () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _title_and_filterIcon(context),
        _productsList(context),
      ],
    );
  }

  Expanded _productsList(BuildContext context) {
    print("Explore Screen");
    return Expanded(
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ProductsSuccessExploreState) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return _exploreItemsContent(context, state, index);
              },
              itemCount: state.productList.length,
            );
          }else if(state is ProductsSuccessNULLExploreState){
            return const EmptyExploreWidget();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _exploreItemsContent(
      BuildContext context, ProductsSuccessExploreState stateData, int index) {
    return SlideUPAnimatedWidget(
      animationController: _animationController,
      childWidget: ProductLayout(
        // imageUrl: stateData.productList[index].mainImage,
        productsModel: stateData.productList[index],
        // index: index,
      ),
    );
  }

  Padding _title_and_filterIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SlideToRightAnimationWidget(
            animationController: _animationController,
            childWidget: Text(
              "For You",
              style: style(
                  color: Colors.black, fontSize: 20, weight: FontWeight.bold),
            ),
          ),
          IconButton(
              onPressed: () {
                //context.read<BottomSheetBloc>().add(CategoryBrandEvent());
                showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isDismissible: true,
                    builder: (context) => FilterBottomSheetContent(
                          tag: "ExP",
                        ));
              },
              icon: const Icon(Icons.filter_alt_outlined)),
        ],
      ),
    );
  }
}
