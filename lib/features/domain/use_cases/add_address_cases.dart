import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

class AddAddressCases {

  final editAddressFromKey = GlobalKey<FormState>();


  addAddress(AddressModel model,String userNodeId){
    locator<AddAddressRepo>().uploadAddress(model, userNodeId);
  }
  Future<List<AddressModel>> getAddress(String userNodeId) async {
   return await locator<AddAddressRepo>().fetchAddress(userNodeId);
  }

  Future<void> updateAddress(String userNodeId,String addressNodeId,AddressModel model)async{
     await locator<AddAddressRepo>().updateAddress(userNodeId,addressNodeId,model);
  }
  Future<void> deleteAddress(String userNodeId,String addressNodeId)async{
    await locator<AddAddressRepo>().deleteAddress(userNodeId,addressNodeId);
  }

}