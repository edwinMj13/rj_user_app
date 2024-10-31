import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../data/data_sources/cached_data.dart';
import '../../data/models/storage_image_model.dart';
import '../../domain/use_cases/explore_page_usecase.dart';
import '../../domain/use_cases/show_loading_case.dart';
import '../../domain/use_cases/show_loading_with_out_text.dart';
import '../screens/explore_screen/bloc/explore_bloc.dart';
import '../screens/product_details/bloc/product_details_bloc.dart';

class WishListItemsWidget extends StatelessWidget {
  WishListItemsWidget({
    super.key,
    required this.productsModel,
  });

  final ProductsModel productsModel;
  final ShowLoadingWithOutCase showLoadingWithOutCase = ShowLoadingWithOutCase();
  final ShowLoadingCase showLoadingCase = ShowLoadingCase();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height*0.13;
    return InkWell(
      onTap: () => ExplorePageUseCase.navigateToDetails(context, productsModel),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  productsModel.mainImage!,
                  height: height,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(
                          loadingProgress, child,120),
                ),
                sizedW20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productsModel.itemName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: style(
                          fontSize: 15, color: Colors.black, weight: FontWeight.bold),
                    ),
                    Text("$rupeeSymbol ${productsModel.sellingPrize}",
                        style: style(
                            fontSize: 14,
                            color: Colors.black,
                            weight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            _favoriteSection(),
          ],
        ),
      ),
    );
  }

  Row _favoriteSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is CheckInWishListOrCartState) {
              return state.isInWishList == "true"
                  ? wishListedIcon(context)
                  : _unWishListedIcon(context);
            }
            return _unWishListedIcon(context);
          },
        ),
      ],
    );
  }

  IconButton wishListedIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        showLoadingWithOutCase.showLoadingWithout(context);
        context.read<ProductDetailsBloc>().add(RemoveFromWishListEvent(
            productId: productsModel.productId,
            context: context,
            cancelLoading: () => showLoadingWithOutCase.cancelLoading()));
      },
      icon: const Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    );
  }

  IconButton _unWishListedIcon(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showLoadingCase.showLoading(context, "Adding to Wishlist...");
        final userData = await CachedData.getUserDetails();
        context.read<ProductDetailsBloc>().add(AddToWishListEventPrDtEvent(
          userNodeId: userData.nodeID,
          model: productsModel,
          cancelLoading: () => showLoadingCase.cancelLoading(),
          context: context,
        ));
      },
      icon: const Icon(Icons.favorite_border),
    );
  }


}
