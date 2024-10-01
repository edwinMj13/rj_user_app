class UserProfileModel {
  String name;
  String email;
  String phoneNumber;
  String? billingAddress;
  String? shippingAddress;
  String uid;
  String nodeID;

  UserProfileModel(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      this.billingAddress,
      this.shippingAddress,
        required this.nodeID,
      required this.uid,});
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "billingAddress": billingAddress,
      "shippingAddress": shippingAddress,
      "uid": uid,
      "nodeID": nodeID,
    };
  }
}
