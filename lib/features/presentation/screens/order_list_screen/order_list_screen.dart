import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/order_list_cases.dart';
import 'package:rj/features/presentation/widgets/empty_list_widget.dart';
import 'package:rj/features/presentation/widgets/hundred_h_w_image_widget.dart';
import 'package:rj/utils/constants.dart';

import '../../../data/models/order_cart_purchase_model.dart';
import 'bloc/order_list_bloc.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderListBloc, OrderListState>(
          builder: (context, state) {
            if (state is FetchOrderListSuccessSTate) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  //final cartList = state.orderList[0].cartList;
                  // print("MainIndex  $index - ${imagesList[0].}");
                  return InkWell(
                    onTap: () {
                      OrderListCases.navigateToOrderDetailsScreen(
                          context, state.orderList[index]!.purchasedCartList,state.orderList[index]!,state.orderList[index]!.invoiceNo,);
                    },
                    child: orderListItems(state.orderList[index]!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  height: 0.5,
                ),
                itemCount: state.orderList.length,
              );
            }
            else if (state is FetchOrderListNULLState) {
              return const EmptyListWidget();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Container orderListItems(OrderModel orderModel) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleImagesInOrderList(
                purchaseList: orderModel.purchasedCartList,
              ),
              sizedW20,
              CommonUseCases.getStatus(orderModel)
            ],
          ),
          ExpansionTile(
            title: Text("Cart Items"),
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate(orderModel.purchasedCartList.length, (index) {
              return Text(
                orderModel.purchasedCartList[index].itemName,
                style: TextStyle(fontSize: 14),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CircleImagesInOrderList extends StatelessWidget {
  const CircleImagesInOrderList({
    super.key,
    required this.purchaseList,
  });

  final List<OrderCartPurchaseModel> purchaseList;

  @override
  Widget build(BuildContext context) {
    print(purchaseList.length);
    return SizedBox(
      child: FlutterImageStack.providers(
        providers: List.generate(purchaseList.length, (index) {
          return NetworkImage(
            purchaseList[index].itemMainImage,
          );
        }).toList(),
        showTotalCount: true,
        totalCount: purchaseList.length,
        itemRadius: 60,
        // Radius of each images
        itemCount: 2,
        // Maximum number of images to be shown in stack
        itemBorderWidth: 2,
        // Border width around the images
      ),
    );
  }
}
