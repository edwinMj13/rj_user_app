import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/address_model.dart';

class AddAddressRepo {
  final firebase = FirebaseFirestore.instance;

  Future<void> uploadAddress(AddressModel model, String userNodeId) async {
    await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("address")
        .add(model.toMap())
        .then((node) async {
      final lastModel = AddressModel(
        addressNodeId: node.id,
        address: model.address,
        addressName: model.addressName,
        addressPinCode: model.addressPinCode,
      );
      await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("address")
          .doc(node.id)
          .update(lastModel.toMap());
    });
  }

  Future<List<AddressModel>> fetchAddress(String userNodeId) async {
    final data = await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("address")
        .get();
    final dataMap = data.docs;
    final addressList = dataMap
        .map((el) => AddressModel(
            addressNodeId: el.get("addressNodeId"),
            address: el.get("address"),
            addressName: el.get("addressName"),
            addressPinCode: el.get("addressPinCode")))
        .toList();
    print("AddressList - $addressList");
    return addressList;
  }

  Future<void> updateAddress(
      String userNodeId, String addressNodeId, AddressModel model) async {
    await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("address")
        .doc(addressNodeId)
        .update(model.toMap());
  }

  Future<void> deleteAddress(String userNodeId, String addressNodeId) async {
    await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("address")
        .doc(addressNodeId)
        .delete();
  }
}
