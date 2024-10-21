import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/presentation/screens/add_address_with_map_screen/bloc/add_address_with_map_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';
import '../../../../utils/text_controllers.dart';
import '../../../domain/use_cases/add_address_cases.dart';
import '../../widgets/text_field_detail_widget.dart';
import '../../widgets/textfield_address_details_widget.dart';

class AddAddressWithMapScreen extends StatelessWidget {
  AddAddressWithMapScreen({super.key});

  final AddAddressCases addDetailsUseCases = AddAddressCases();

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
                      controller: addMapAddressAddressController,
                      label: "Address"),
                  sizedH20,
                  TextFormDetailsWidget(
                      controller: addMapAddressPincodeController,
                      label: "Pin Code",
                      inputType: TextInputType.name),
                  sizedH20,
                  ElevatedButton(
                      onPressed: () {
                        context.read<AddAddressWithMapBloc>().add(
                            AddAddressUploadMapEvent(
                                addressModel: AddressModel(
                                    addressNodeId: "",
                                    address:
                                        addMapAddressAddressController.text,
                                    addressName:
                                        addMapAddressNameController.text,
                                    addressPinCode:
                                        addMapAddressPincodeController.text),context: context));
                      },
                      child: const Text("Add"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
