// import 'package:cdb_mobile/features/data/models/requests/un_favorite_biller_request.dart';
//
//
// class UnFavoriteBillerEntity extends UnFavoriteBillerRequest{
//   final String messageType;
//   final int billerId;
//
//   UnFavoriteBillerEntity({this.messageType, this.billerId,})
//       : super(
//     messageType: messageType,
//     billerId: billerId,
//   );
//
//
//
//
// }
// To parse this JSON data, do
//
//     final unFavoriteBillerRequest = unFavoriteBillerRequestFromJson(jsonString);


import '../../../data/models/requests/un_favorite_biller_request.dart';




class UnFavoriteBillerEntity extends UnFavoriteBillerRequest{
  UnFavoriteBillerEntity({
    this.messageType,
    this.billerId,
  }) : super(billerId: billerId, messageType: messageType);

  String? messageType;
  int? billerId;


}
