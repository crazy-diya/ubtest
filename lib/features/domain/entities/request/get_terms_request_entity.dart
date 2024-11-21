

import '../../../data/models/requests/get_terms_request.dart';

class GetTermsRequestEntity extends GetTermsRequest {
  final String? messageType;
  final String? termType;

  const GetTermsRequestEntity({this.messageType,this.termType}) : super(messageType: messageType,termType: termType);
}
