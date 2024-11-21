import '../../../data/models/requests/common_request.dart';

class CommonRequestEntity extends CommonRequest {
  final String? messageType;
  final String? appSignature;

  const CommonRequestEntity( {this.messageType,this.appSignature,}) : super(messageType: messageType,appSignature:appSignature);
}
