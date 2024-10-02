import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/storage_image_model.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/presentation/widgets/search_mic_widget.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  String? nodeId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    nodeId = ModalRoute
        .of(context)
        ?.settings
        .arguments
        .toString();
    context
        .read<ProductDetailsBloc>()
        .add(FetchProductDetailsEvent(nodeId: nodeId!));
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is FetchProductDetailsSuccessState) {
          List<StorageImageModel> images = state.productModal.imagesList
              .map((e) => StorageImageModel(
                    storageRefPath: e["storageRefPath"],
                    downloadUrl: e["downloadUrl"],
                  ))
              .toList();
          final data = state.productModal;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: ()=>Navigator.of(context).pop(), icon: Icon(Icons.arrow_back)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Deliver to : ",
                                  style: TextStyle(color: Colors.grey)),
                              sizedH10,
                              Text(
                                "Edwin Baby",
                                style: style(
                                    fontSize: 18,
                                    color: Colors.black,
                                    weight: FontWeight.bold),
                              ),
                              Text("Maliackal H,\n"
                                  "Karukutty PO,\n"
                                  "Karayamprambu")
                            ],
                          ),
                          ButtonGreen(
                              backgroundColor: Colors.white,
                              label: "Change",
                              callback: () => callback(),
                              color: Colors.blue)
                        ],
                      ),
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
                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: (){}, child: const Row(children: [
                              Icon(CupertinoIcons.cart,size: 30,color: Colors.black,),
                              Text("Add",style: TextStyle(fontSize: 16,color: Colors.black),),
                            ],)),
                            ButtonGreen(backgroundColor: Colors.black, label: "Buy Now", callback: callback, color: Colors.white)
                          ],
                        ),
                      )
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
