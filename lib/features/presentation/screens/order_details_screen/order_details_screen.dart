import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/presentation/screens/order_details_screen/bloc/order_details_bloc.dart';
import 'package:rj/features/presentation/screens/order_list_screen/bloc/order_list_bloc.dart';

import '../../../data/models/to_model_class.dart';
import '../../widgets/place_order_carted_items_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderDetailsBloc>().add(FetchOrderDetailsEvent(orderId: widget.orderId,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) {
          if(state is OrderDetailsSuccessState) {
          //  List<CartModel> cartList = ToModelClass.toCartModel(state.orderModel.cartList)
            return SingleChildScrollView(child: PlaceOrderCartedItemsWidget(
                cartList: state.orderModel.cartList));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
