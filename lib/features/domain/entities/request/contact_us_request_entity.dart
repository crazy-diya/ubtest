// To parse this JSON data, do
//
//     final contactUsRequestModel = contactUsRequestModelFromJson(jsonString);

import '../../../data/models/requests/contact_us_request.dart';

class ContactUsRequestEntity extends ContactUsRequestModel {
  const ContactUsRequestEntity({
    this.messageType,
  }) : super(
          messageType: messageType,
        );

  final String? messageType;
}
