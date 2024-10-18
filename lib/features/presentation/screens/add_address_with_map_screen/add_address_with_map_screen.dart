import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';
import '../../../../utils/text_controllers.dart';
import '../../../domain/use_cases/add_address_cases.dart';
import '../../widgets/text_field_detail_widget.dart';
import '../../widgets/textfield_address_details_widget.dart';

class AddAddressWithMapScreen extends StatelessWidget {
  AddAddressWithMapScreen({super.key});
  AddAddressCases addDetailsUseCases = AddAddressCases();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: addDetailsUseCases.addAddressFromKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add Address",
                    style: style(
                        color: Colors.black,
                        fontSize: 19,
                        weight: FontWeight.normal),
                  ),
                  sizedH20,
                  TextFormDetailsWidget(
                      controller: addMapAddressNameController,
                      label: "Name",
                      inputType: TextInputType.name),
                  sizedH20,
                  TextFormFieldAddressDetailsWidget(
                      controller: addMapAddressAddressController, label: "Address"),
                  sizedH20,
                  TextFormDetailsWidget(
                      controller: addMapAddressPincodeController,
                      label: "Pin Code",
                      inputType: TextInputType.name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
