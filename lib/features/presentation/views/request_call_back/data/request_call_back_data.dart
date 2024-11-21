import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';

class ReqCallBackArgs{
  final CommonDropDownResponse? callBackTime;
  final CommonDropDownResponse? subject;
  final String? comments;
  final CommonDropDownResponse? language;
  final String? status;
  final int? id;
  final bool? isHome;

  ReqCallBackArgs(
      {this.callBackTime, this.subject, this.comments, this.language, this.status, this.id , this.isHome = false});
}