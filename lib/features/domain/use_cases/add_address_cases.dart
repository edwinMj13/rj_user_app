import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

class AddAddressCases {
  addAddress(AddressModel model,String nodeId){
    locator<AddAddressRepo>().uploadAddress(model, nodeId);
  }
  Future<List<AddressModel>> getAddress(String nodeId) async {
   return await locator<AddAddressRepo>().fetchAddress(nodeId);
  }
}