import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/services/add_details_services.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:rj/utils/common.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/text_controllers.dart';
import '../../../data/models/user_profile_model.dart';
import '../../widgets/big_text.dart';
import '../../widgets/right_arrow_ios.dart';
import '../../widgets/text_field_detail_widget.dart';
import '../../widgets/textfield_address_details_widget.dart';
import '../login_screen/login_verify_screen.dart';
import '../main_screen/main_screen.dart';
import 'bloc/add_details_bloc.dart';

class AddDetailsScreen extends StatefulWidget {
  //final User user;
  AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    AddDetailsServices.setTextFields(context);
    super.didChangeDependencies();
  }

  validate() {
    final isValidted = _formKey.currentState!.validate();
    if (isValidted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedH40,
                  const BigTextLogin(text: "My Details"),
                  sizedH40,
                  Column(
                    children: [
                      TextFormDetailsWidget(
                        controller: nameAddAddressController,
                        label: "Name",
                        inputType: TextInputType.text,
                      ),
                      sizedH40,
                      TextFormDetailsWidget(
                        controller: emailAddAddressController,
                        label: "E-mail Id",
                        inputType: TextInputType.text,
                      ),
                      sizedH40,
                      TextFormDetailsWidget(
                        controller: phoneAddAddressController,
                        label: "Phone Number",
                        inputType: TextInputType.number,
                      ),
                      sizedH40,
                      TextFormFieldAddressDetailsWidget(
                        controller: billingAddAddressController,
                        label: "Billing Address",
                      ),
                      sizedH40,
                      TextFormFieldAddressDetailsWidget(
                        controller: shippingAddAddressController,
                        label: "Shipping Address",
                      ),
                    ],
                  ),
                  sizedH30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      RightArrowIOS(
                        pressFunction: () {
                          final userModel = UserProfileModel(
                            uid: CachedData.getDataFromSharedPref("uid").toString(),
                            nodeID: "",
                            name: nameAddAddressController.text,
                            phoneNumber: phoneAddAddressController.text,
                            email: emailAddAddressController.text,
                            billingAddress: billingAddAddressController.text,
                            shippingAddress: shippingAddAddressController.text,
                          );
                          addAddress(context, userModel);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addAddress(BuildContext context, UserProfileModel model) async {
    if (validate()) {
      print("${model.name}");
      context.read<AddDetailsBloc>().add(UploadUserDetailsEvent(
          userDetail: model, callback: () => navigateToNext(context)));
    }
  }

  navigateToNext(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
