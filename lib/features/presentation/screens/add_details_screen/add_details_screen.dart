import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/add_details_use_cases.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/dependencyLocation.dart';
import '../../../../utils/text_controllers.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/repository/auth_repository.dart';
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
  AddDetailsUseCases addDetailsUseCases = AddDetailsUseCases();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    AddDetailsUseCases.setTextFields(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: addDetailsUseCases.formKeyAddDetails,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedH40,
                  const BigTextLogin(text: "My Details"),
                  sizedH40,
                  _textfieldSection(),
                  sizedH30,
                  _actionButton(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _actionButton(BuildContext context) {
    return Row(
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
              pincode: pinCodeAddAddressController.text,
              shippingAddress: shippingAddAddressController.text,
            );
            addDetailsUseCases.addAddress(context, userModel);
          },
        ),
      ],
    );
  }

  Column _textfieldSection() {
    return Column(
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
          enabled: false,
        ),
        sizedH40,
        TextFormDetailsWidget(
          controller: phoneAddAddressController,
          label: "Phone Number",
          inputType: TextInputType.number,
        ),
        sizedH40,
        TextFormFieldAddressDetailsWidget(
          controller: shippingAddAddressController,
          label: "Shipping Address",
        ),
        sizedH40,
        TextFormDetailsWidget(
          controller: pinCodeAddAddressController,
          label: "Pin Code",
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
