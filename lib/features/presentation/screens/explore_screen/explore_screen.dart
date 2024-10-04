import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/presentation/widgets/filter_bottom_sheet_content.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../widgets/product_layout.dart';
import 'bloc/explore_bloc.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ExploreBloc>().add(ProductsFetchAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _title_and_filterIcon(context),
        _productsList(width),
      ],
    );
  }

  Expanded _productsList(double width) {
    return Expanded(
        child: BlocConsumer<ExploreBloc, ExploreState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ProductsSuccessExploreState:
                final stateData = state as ProductsSuccessExploreState;
                return GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()=>Navigator.pushNamed(context, RouteNames.productDetailsScreen,arguments:stateData.productList[index].firebaseNodeId,),
                      child: ProductLayout(
                        width: width,
                        imageUrl: stateData.productList[index].mainImage,
                        stateData: stateData,
                        index: index,
                      ),
                    );
                  },
                  itemCount: stateData.productList.length,
                );
              default:
                return SizedBox();
            }
          },
        ),
      );
  }

  Padding _title_and_filterIcon(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "For You",
              style: style(
                  color: Colors.black, fontSize: 20, weight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      isDismissible: true,
                      builder: (context) => FilterBottomSheetContent());
                },
                icon: const Icon(Icons.filter_alt_outlined)),
          ],
        ),
      );
  }
}
