

import '../../../data/models/requests/edit_user_biller_request.dart';

class EditUserBillerRequestEntity extends EditUserBillerRequest {
  EditUserBillerRequestEntity({
    this.messageType,
    this.nickName,
    this.serviceProviderId,
    this.billerId,
    this.value,
  }) : super(
    messageType: messageType,
    nickName: nickName,
    serviceProviderId: serviceProviderId,
    billerId: billerId,
    value: value,

    //categoryId: categoryId,
    //fieldList: fieldList,
  );

  String? messageType;
  String? clientTransId;
  String? nickName;
  String? serviceProviderId;
  int? billerId;
  String? value;
  //String? categoryId;
  //List<FieldList>? fieldList;
}

