import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/wish_list_screen/bloc/wish_list_bloc.dart';
import 'package:rj/features/presentation/widgets/appbar_common.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';
import 'package:rj/utils/styles.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppbarCommon(),
      ),
      body: BlocBuilder<WishListBloc, WishListState>(
        builder: (context, state) {
          print("STATE WIshList ${state.runtimeType}");
          if (state is FetchWishListSuccessState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ProductLayout(productsModel: state.productsModel[index]);
              },
              itemCount: state.productsModel.length,
            );
          }else if(state is FetchWishListNullState){
            return Center(child: Text("Wishlist is Empty",style: style(fontSize: 13, color: Colors.grey, weight: FontWeight.normal),));
          }else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
