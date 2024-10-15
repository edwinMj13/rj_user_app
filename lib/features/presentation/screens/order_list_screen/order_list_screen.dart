import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/domain/use_cases/order_list_cases.dart';
import 'package:rj/features/presentation/widgets/hundred_h_w_image_widget.dart';

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
                    onTap: (){
                      OrderListCases.navigateToOrderDetailsScreen(context, state.orderList[index]!.orderNodeIdInUsers!);
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
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Container orderListItems(OrderModel orderModel) {

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleImagesInOrderList(
            cartList: orderModel.cartList,
          ),
          Text(orderModel.orderTime)
        ],
      ),
    );
  }
}

class CircleImagesInOrderList extends StatelessWidget {
  const CircleImagesInOrderList({
    super.key,
    required this.cartList,
  });

  final List<CartModel> cartList;

  @override
  Widget build(BuildContext context) {
    print(cartList.length);

    return Row(
      children: List.generate(cartList.length, (index) {

        return Image.network(cartList[index].mainImage,width: 50,height: 50,);
      }),
    );
  }
}
