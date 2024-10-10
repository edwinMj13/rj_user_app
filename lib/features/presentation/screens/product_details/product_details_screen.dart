import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/show_loading_case.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';
import 'package:rj/features/presentation/widgets/appbar_common.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../../domain/use_cases/show_loading_with_out_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductsModel productModel;

  ProductDetailsScreen({super.key, required this.productModel});

  final ShowLoadingCase showLoadingCase = ShowLoadingCase();
  final ShowLoadingWithOutCase showLoadingWithOutCase = ShowLoadingWithOutCase();

  @override
  Widget build(BuildContext context) {
    context
        .read<ProductDetailsBloc>()
        .add(CheckInWishListOrCartEvent(productNodeId: productModel.productId));
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppbarCommon(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _favoriteSection(),
              _imagesSection(),
              sizedH20,
              _nameSection(),
              sizedH10,
              _description(),
              sizedH20,
              _amountSection(),
              sizedH20,
              sizedH20,
              _deliveryDate(),
              sizedH20,
              _addToCartBuyNow(context),
            ],
          ),
        )),
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

  Text _amountSection() {
    return Text(
      "$rupeeSymbol ${productModel.sellingPrize}",
      style: style(fontSize: 19, color: Colors.green, weight: FontWeight.bold),
    );
  }

  Text _description() {
    return Text(
      productModel.description,
      style: TextStyle(color: Colors.grey),
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

  Widget _addToCartBuyNow(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.white,
          child: _cartTextIfAddedOrNot(context),
        );
      },
    );
  }

  Widget _cartTextIfAddedOrNot(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
      if (state is CheckInWishListOrCartState) {
        return state.isInCart == "true"
            ? _alreadyAddedToCartSection(context)
            : _productNotInCartSection(context, productModel);
      }
      return _productNotInCartSection(context, productModel);
    });
  }

  Row _productNotInCartSection(
      BuildContext context, ProductsModel productModal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () async {
            showLoadingCase.showLoading(context, "Adding to cart...");
            final userData = await CachedData.getUserDetails();
            context.read<ProductDetailsBloc>().add(AddToCartEventPrDtEvent(
                model: productModal,
                userNodeId: userData.nodeID,
                cancelLoading: () => showLoadingCase.cancelLoading(),
                context: context));
          },
          child: const Row(
            children: [
              Icon(
                CupertinoIcons.cart,
                size: 30,
                color: Colors.black,
              ),
              sizedW10,
              Text(
                "Add",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        ButtonGreen(
            backgroundColor: Colors.black,
            label: "Buy Now",
            callback: () => callback(),
            color: Colors.white)
      ],
    );
  }

  Row _alreadyAddedToCartSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              snackbar(context, "Already added to cart");
            },
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.cart,
                  size: 30,
                  color: Colors.green,
                ),
                sizedW10,
                Text(
                  "Added",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            )),
        ButtonGreen(
            backgroundColor: Colors.black,
            label: "Buy Now",
            callback: () => callback(),
            color: Colors.white)
      ],
    );
  }

  CarouselSlider _imagesSection() {
    List<StorageImageModel> images = getImageList(productModel.imagesList);
    return CarouselSlider(
        items: List.generate(images.length, (index) {
          return Image.network(
            images[index].downloadUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context,child,loadingProgress)=>CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(loadingProgress, child,120),
          );
        }),
        options: CarouselOptions(aspectRatio: 1, viewportFraction: 1));
  }

  callback() {}

}
