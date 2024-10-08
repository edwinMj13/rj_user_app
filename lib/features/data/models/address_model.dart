class AddressModel{
  final String addressNodeId;
  final String addressName;
  final String address;
  final String addressPinCode;

  AddressModel({required this.addressNodeId, required this.address,required this.addressName,required this.addressPinCode});

  Map<String, dynamic> toMap(){
    return {
      "addressNodeId":addressNodeId,
      "address":address,
      "addressName":addressName,
      "addressPinCode":addressPinCode,
    };
  }
}