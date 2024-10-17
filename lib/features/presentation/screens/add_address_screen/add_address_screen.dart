import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/domain/use_cases/add_address_cases.dart';
import 'package:rj/features/domain/use_cases/add_details_use_cases.dart';
import 'package:rj/features/presentation/screens/add_address_screen/bloc/add_address_screen_bloc.dart';
import 'package:rj/features/presentation/widgets/empty_list_widget.dart';
import 'package:rj/features/presentation/widgets/text_field_detail_widget.dart';
import 'package:rj/features/presentation/widgets/textfield_address_details_widget.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';
import 'package:rj/utils/text_controllers.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  AddAddressCases addDetailsUseCases = AddAddressCases();

  @override
  Widget build(BuildContext context) {
    context.read<AddAddressScreenBloc>().add(FetchAddressScreenEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
        actions: [
          IconButton(
              onPressed: () => _openPopup(context, "add", null),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              Expanded(
                child: _addressList(context),
              )
            ],
          )),
    );
  }

  Text _title() {
    return Text(
      "Address",
      style: style(fontSize: 15, color: Colors.grey, weight: FontWeight.normal),
    );
  }

  BlocBuilder<AddAddressScreenBloc, AddAddressScreenState> _addressList(
      BuildContext context) {
    return BlocBuilder<AddAddressScreenBloc, AddAddressScreenState>(
      builder: (context, state) {
        if (state is FetchAddressState) {
          print(state.addressList);
          return ListView.separated(
            itemBuilder: (context, index) {
              return _addressListItem(state, index, context);
            },
            itemCount: state.addressList.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              height: 0.1,
            ),
          );
        }else if(state is FetchAddressScreenNullState){
          return const EmptyListWidget();
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }

  Container _addressListItem(
      FetchAddressState state, int index, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.addressList[index].addressName,
                style: style(
                    fontSize: 17,
                    color: Colors.black,
                    weight: FontWeight.normal),
              ),
              InkWell(
                onTap: () =>
                    showPopupItemAction(context, state.addressList[index]),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
          Text(state.addressList[index].address),
          Text(state.addressList[index].addressPinCode),
        ],
      ),
    );
  }

  _openPopup(BuildContext context, String tag, AddressModel? addModel) {
    if (tag == "update") {
      addAddressAddressController.text = addModel!.address;
      addAddressNameController.text = addModel.addressName;
      addAddressPincodeController.text = addModel.addressPinCode;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            content: Form(
              key: addDetailsUseCases.editAddressFromKey,
              child: SingleChildScrollView(
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
                        controller: addAddressNameController,
                        label: "Name",
                        inputType: TextInputType.name),
                    sizedH20,
                    TextFormFieldAddressDetailsWidget(
                        controller: addAddressAddressController,
                        label: "Address"),
                    sizedH20,
                    TextFormDetailsWidget(
                        controller: addAddressPincodeController,
                        label: "Pin Code",
                        inputType: TextInputType.name),
                  ],
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (tag == "add") {
                      context
                          .read<AddAddressScreenBloc>()
                          .add(AddUpdloadAddressScreenEvent());
                    } else {
                      final model = AddressModel(
                          addressNodeId: addModel!.addressNodeId,
                          address: addAddressAddressController.text,
                          addressName: addAddressNameController.text,
                          addressPinCode: addAddressPincodeController.text);
                      context.read<AddAddressScreenBloc>().add(
                          AddAddressScreenUpdateEvent(
                              addressNodeId: addModel.addressNodeId,
                              addressModel: model,
                              context: context));
                    }
                  },
                  child: Text(tag == "update" ? "Update" : "Add"))
            ],
          );
        });
  }

  showPopupItemAction(BuildContext context, AddressModel addressList) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _openPopup(context, "update", addressList);
                    },
                    child: const Text("Edit")),
                Container(
                  height: 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                    onPressed: () => context.read<AddAddressScreenBloc>().add(
                        AddAddressScreenDeleteEvent(
                            addressNodeId: addressList.addressNodeId,
                            context: context)),
                    child: Text("Delete")),
              ],
            ),
          );
        });
  }
}
