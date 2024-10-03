import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';
import 'package:rj/features/presentation/widgets/address_change_widget.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/presentation/widgets/search_mic_widget.dart';
import 'package:rj/features/services/show_loading_services.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  String? nodeId;
  LoadingServices loadingServices = LoadingServices();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    nodeId = ModalRoute.of(context)?.settings.arguments.toString();
    context
        .read<ProductDetailsBloc>()
        .add(FetchProductDetailsEvent(nodeId: nodeId!));
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        print("STATE ProductDetails ${state.runtimeType}");
        if (state is FetchProductDetailsSuccessState) {

          List<StorageImageModel> images = getImageList(state.productModal.imagesList);
          final data = state.productModal;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back)),
                  SearchMicWidget(),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border)),
                        ],
                      ),
                      _imagesSection(images),
                      sizedH20,
                      Text(
                        data.itemName,
                        style: style(
                            fontSize: 20,
                            color: Colors.black,
                            weight: FontWeight.bold),
                      ),
                      sizedH10,
                      Text(
                        data.description,
                        style: TextStyle(color: Colors.grey),
                      ),
                      sizedH20,
                      Text(
                        "$rupeeSymbol ${data.sellingPrize}",
                        style: style(
                            fontSize: 19,
                            color: Colors.green,
                            weight: FontWeight.bold),
                      ),
                      sizedH20,
                      const Text("Deliver to : ",
                          style: TextStyle(color: Colors.grey)),
                      sizedH10,
                      AddressChangeWidget(callback:()=> callback,userModal: state.userProfileModel,),
                      sizedH20,
                      Center(
                          child: Text(
                        "Free Delivery by Dec 29, Monday",
                        style: style(
                            fontSize: 20,
                            color: Colors.black,
                            weight: FontWeight.bold),
                      )),
                      sizedH20,
                      _addCartBuyNow(context, state.productModal, state),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Container _addCartBuyNow(BuildContext context, ProductsModel productModal,
      FetchProductDetailsSuccessState state) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: _cartTextIfAddedOrNot(context, productModal, state),
    );
  }

  Row _cartTextIfAddedOrNot(BuildContext context, ProductsModel productModal,
      FetchProductDetailsSuccessState state) {
    return state.isInCart == "false"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () async {
                    loadingServices.showLoading(context, "Adding to cart...");
                    final userData = await CachedData.getUserDetails();
                    context.read<ProductDetailsBloc>().add(
                        AddToCartEventPrDtEvent(
                            model: productModal,
                            nodeId: userData.nodeID,
                            callback: () => loadingServices.cancelLoading()));
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
                  )),
              ButtonGreen(
                  backgroundColor: Colors.black,
                  label: "Buy Now",
                  callback: callback,
                  color: Colors.white)
            ],
          )
        : Row(
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
                  callback: callback,
                  color: Colors.white)
            ],
          );
  }

  CarouselSlider _imagesSection(List<StorageImageModel> images) {
    return CarouselSlider(
        items: List.generate(images.length, (index) {
          return Image.network(
            images[index].downloadUrl,
            fit: BoxFit.cover,
          );
        }),
        options: CarouselOptions(aspectRatio: 1, viewportFraction: 1));
  }

  callback() {}
}
