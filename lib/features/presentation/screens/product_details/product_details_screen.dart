import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/show_loading_case.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';
import 'package:rj/features/presentation/screens/product_details/widget/product_details_content_widget.dart';
import 'package:rj/features/presentation/widgets/appbar_common.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/presentation/widgets/slide_up_animation_widget.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../../domain/use_cases/show_loading_with_out_text.dart';
import '../../widgets/text_price_section_line_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsModel productModel;

  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  final ShowLoadingCase showLoadingCase = ShowLoadingCase();
  late AnimationController _animationController;
  final ShowLoadingWithOutCase showLoadingWithOutCase =
      ShowLoadingWithOutCase();

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    Timer(const Duration(milliseconds: 150),
        () => _animationController.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailsBloc>().add(CheckInWishListOrCartEvent(
        productNodeId: widget.productModel.productId));
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppbarCommon(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ProductDetailsContentWidget(productModel: widget.productModel),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlideUPAnimatedWidget(
                  animationController: _animationController,
                  childWidget: _addToCart(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addToCart(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: _cartTextIfAddedOrNot(context),
    );
  }

  Widget _cartTextIfAddedOrNot(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
      if (state is CheckInWishListOrCartState) {
        return state.isInCart == "true"
            ? _alreadyAddedToCartSection(context, widget.productModel)
            : _productNotInCartSection(context, widget.productModel);
      }
      return _productNotInCartSection(context, widget.productModel);
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
        TextPriceSectionLineWidget(
          price: productModal.price!,
          offerPrice: productModal.sellingPrize,
        )
      ],
    );
  }

  Row _alreadyAddedToCartSection(
      BuildContext context, ProductsModel productModel) {
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
        TextPriceSectionLineWidget(
          price: productModel.price!,
          offerPrice: productModel.sellingPrize,
        )
      ],
    );
  }
}
