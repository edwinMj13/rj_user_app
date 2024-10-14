import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_sources/cached_data.dart';
import '../models/user_profile_model.dart';

class AddScreenRepo {
  final firebase = FirebaseFirestore.instance;

  Future<void> addUser(UserProfileModel userProfile) async {
    CollectionReference users = firebase.collection('Users');
    await users.add(userProfile.toMap()).then((value) {
      final model = UserProfileModel(
        nodeID: value.id,
        name: userProfile.name,
        phoneNumber: userProfile.phoneNumber,
        email: userProfile.email,
        uid: userProfile.uid,
        shippingAddress: userProfile.shippingAddress,
        billingAddress: userProfile.billingAddress,
      );
      CachedData.saveUserNode(
          value.id, userProfile.shippingAddress!, userProfile.billingAddress!,
          userProfile.phoneNumber);
      firebase.collection("Users").doc(value.id).update(model.toMap());
      //print("User Added Success - ${value}");
    }).catchError((e) {
      print("USser Added Catch Error - ${e.toString()}");
    });
  }

  Future<void> update(String userNodeId, UserProfileModel model) async {
    print("user IDD $userNodeId");
    await firebase.collection("Users").doc(userNodeId).update(model.toMap());
  }


 Future<UserProfileModel> getUserDetails(String userId) async {
    final data = await firebase.collection("Users").doc(userId).get();
    final mapData = data.data();
    final model = UserProfileModel(name: mapData!["name"],
      phoneNumber: mapData["phoneNumber"],
      email: mapData["email"],
      nodeID: mapData["nodeID"],
      uid: mapData["uid"],
    billingAddress: mapData["billingAddress"],
    shippingAddress: mapData["shippingAddress"],);
    print("MapData $mapData");
    return model;
    //final user = mapData.;
  }

}
