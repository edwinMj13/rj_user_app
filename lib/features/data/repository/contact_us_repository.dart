import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/contact_us_data_model.dart';

class ContactUsRepo{
  Future<void> uploadEnquiryDetails(ContactUsDataModel model) async {
    await FirebaseFirestore.instance.collection("Enquiry").add(model.toMap());
  }
}