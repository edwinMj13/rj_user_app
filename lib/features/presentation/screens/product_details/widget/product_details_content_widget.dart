import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/common.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/styles.dart';
import '../../../../data/data_sources/cached_data.dart';
import '../../../../data/models/products_model.dart';
import '../../../../data/models/storage_image_model.dart';
import '../../../../domain/use_cases/common_use_cases.dart';
import '../../../../domain/use_cases/show_loading_case.dart';
import '../../../../domain/use_cases/show_loading_with_out_text.dart';
import '../../../widgets/text_price_section_line_widget.dart';
import '../bloc/product_details_bloc.dart';

class ProductDetailsContentWidget extends StatelessWidget {
  ProductDetailsContentWidget({
    super.key, required  this.productModel,
  });
  final ProductsModel productModel;
  final ShowLoadingCase showLoadingCase = ShowLoadingCase();
  final ShowLoadingWithOutCase showLoadingWithOutCase = ShowLoadingWithOutCase();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _favoriteSection(),
          _imagesSection(),
          sizedH20,
          Text(productModel.itemBrand),
          _nameSection(),
          sizedH10,
          _description(),
          sizedH10,
          Row(
            children: [
              Text(productModel.category),
              sizedW10,
              Container(width: 10,height: 1,color: Colors.black,),
              sizedW10,
              Text(productModel.subCategory!),
            ],
          ),
          sizedH20,
          _deliveryDate(),
          sizedH20,
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
  Center _deliveryDate() {
    return Center(
        child: Text(
          "Free Delivery by Dec 29, Monday",
          style: style(fontSize: 20, color: Colors.black, weight: FontWeight.bold),
        ));
  }



  Text _description() {
    return Text(
      productModel.description,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Text _nameSection() {
    return Text(
      productModel.itemName,
      style: style(fontSize: 20, color: Colors.black, weight: FontWeight.bold),
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

  CarouselSlider _imagesSection() {
    List<StorageImageModel> images =
    getImageList(productModel.imagesList);
    return CarouselSlider(
        items: List.generate(images.length, (index) {
          return Image.network(
            images[index].downloadUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(
                    loadingProgress, child, 120),
          );
        }),
        options: CarouselOptions(aspectRatio: 1, viewportFraction: 1));
  }


  IconButton wishListedIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        showLoadingWithOutCase.showLoadingWithout(context);
        context.read<ProductDetailsBloc>().add(RemoveFromWishListEvent(
            productId: productModel.productId,
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
          model: productModel,
          cancelLoading: () => showLoadingCase.cancelLoading(),
          context: context,
        ));
      },
      icon: const Icon(Icons.favorite_border),
    );
  }


}
