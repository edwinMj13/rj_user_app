import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';

import '../../../utils/common.dart';
import '../../presentation/screens/change_address_screen/bloc/change_address_bloc.dart';

class PlaceOrderCases{
 static  navigateToAddressChangeScreen(BuildContext context,UserProfileModel user){
  context.read<ChangeAddressBloc>().add(FetchAddressChangeEvent(selectedValue: 0, userNodeId: user.nodeID));
 // Map<String,dynamic> map = {"userModel":user,"addressModelCallback":(model)=>callback(model)};
  Navigator.pushNamed(context, RouteNames.changeAddressScreen,arguments:user );
  }

  static callback(AddressModel model) {}

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

// onSuccessHandler(PaymentSuccessResponse response){
//   snackbar(context, "Payment SuccessFull");
// }

}