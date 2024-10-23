
class ContactUsDataModel {
  String subject;
  String body;
  String userId;

  ContactUsDataModel({
    required this.subject,
    required this.body,
    required this.userId,});

  Map<String, dynamic> toMap() {
    return {
      "subject" : subject,
      "body" : body,
      "userId" : userId,
    };
  }

}