import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/features/domain/use_cases/show_loading_with_out_text.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../utils/common.dart';
import '../../data/models/products_model.dart';
import '../../presentation/screens/change_address_screen/bloc/change_address_bloc.dart';

class PlaceOrderCases{

 static  navigateToAddressChangeScreen(BuildContext context,UserProfileModel user){
  context.read<ChangeAddressBloc>().add(FetchAddressChangeEvent(selectedValue: 0, userNodeId: user.nodeID));
 // Map<String,dynamic> map = {"userModel":user,"addressModelCallback":(model)=>callback(model)};
  Navigator.pushNamed(context, RouteNames.changeAddressScreen,arguments:user );
  }

  static navigateToSuccessPage(BuildContext context, PaymentSuccessResponse response,String userNodeId, Map<String, dynamic> priceBreakup,  List<CartModel> cartList,) async {
  UserProfileModel user =await locator<AddScreenRepo>().getUserDetails(userNodeId);
  Map<String,dynamic> map = {
   "payment_id":response.paymentId,
   "priceBreakup":priceBreakup,
   "user":user,
   "cartList":cartList,
  };
   Navigator.pushNamed(context, RouteNames.paymentSuccessScreen,arguments: map);
  }

 static openRazorPay(Razorpay razorpay,int amount) async {

  // need to specify the number in point
  amount = amount * 100;
  // json response
  var options = {
   "key":"rzp_test_ntr4Q2itPPqqvO", //test key
   "amount":amount,
   "name":"Rj Shop",
   "currency":"INR",
   "description":"Fine T-Shirt",
   "prefill": {
    "contact": "1234567890",
    "email": "test@gmail.com",
   },
   "external": {
    "wallets": ["paytm"]
   },
  };
  try {
   razorpay.open(options);
  } catch (e) {
   debugPrint("Error : e");
  }
 }

  void navigateToProdDetails(BuildContext context, CartModel cartList) {
   final model = ProductsModel(
    itemName: cartList.itemName,
    category: cartList.category,
    firebaseNodeId: cartList.firebaseNodeId,
    itemMrp: cartList.itemMrp,
    productId: cartList.productId,
    totalMrp: cartList.totalMrp,
    status: cartList.status,
    imagesList: cartList.imagesList,
    description: cartList.description,
    itemBrand: cartList.itemBrand,
    mainImage: cartList.mainImage,
    sellingPrize: cartList.sellingPrize,
    subCategory: cartList.subCategory,
    price: cartList.price,
    stock: cartList.stock,
   );
   Navigator.pushNamed(context, RouteNames.productDetailsScreen,arguments: model);
  }


  //getP

}