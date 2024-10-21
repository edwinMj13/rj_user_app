import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/dependencyLocation.dart';
import '../data_sources/cached_data.dart';
import '../models/address_model.dart';
import '../models/user_profile_model.dart';
import 'add_address_repository.dart';

class AddScreenRepo {
  final firebase = FirebaseFirestore.instance;

  Future<void> addUser(UserProfileModel userProfile) async {
    CollectionReference users = firebase.collection('Users');
    await users.add(userProfile.toMap()).then((value) async {
      final model = UserProfileModel(
        nodeID: value.id,
        name: userProfile.name,
        phoneNumber: userProfile.phoneNumber,
        email: userProfile.email,
        uid: userProfile.uid,
        shippingAddress: userProfile.shippingAddress,
        pincode: userProfile.pincode,
      );
      final address =AddressModel(addressNodeId: "", address: userProfile.shippingAddress!, addressName: userProfile.name, addressPinCode: userProfile.pincode);
      await locator<AddAddressRepo>().uploadAddress(address, value.id);

      CachedData.saveUserNode(
          value.id, userProfile.shippingAddress!, userProfile.pincode,
          userProfile.phoneNumber);
      firebase.collection("Users").doc(value.id).update(model.toMap());
      //print("User Added Success - ${value}");
    }).catchError((e) {
      print("USser Added Catch Error - ${e.toString()}");
    });
  }

  Future<void> update(String userNodeId, UserProfileModel userProfile) async {
    print("user IDD $userNodeId\n"
        "USER shippingAddress  ${userProfile.shippingAddress}");
    await firebase.collection("Users").doc(userNodeId).update(userProfile.toMap());
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('name',userProfile.name);
    await sharedPref.setString('email', userProfile.email);
    await sharedPref.setString(
        'phoneNumber', userProfile.phoneNumber);
    CachedData.saveUserNode(
        userNodeId, userProfile.shippingAddress!, userProfile.pincode,
        userProfile.phoneNumber);
  }


 Future<UserProfileModel> getUserDetails(String userId) async {
    final data = await firebase.collection("Users").doc(userId).get();
    final mapData = data.data();
    final model = UserProfileModel(name: mapData!["name"],
      phoneNumber: mapData["phoneNumber"],
      email: mapData["email"],
      nodeID: mapData["nodeID"],
      uid: mapData["uid"],
      pincode: mapData["pincode"],
    shippingAddress: mapData["shippingAddress"],);
    print("MapData $mapData");
    return model;
    //final user = mapData.;
  }

}
