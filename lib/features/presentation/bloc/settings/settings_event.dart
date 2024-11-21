import '../../../data/models/requests/settings_update_txn_limit_request.dart';
import '../base_event.dart';

abstract class SettingsEvent extends BaseEvent {}

class UpdateProfileImageEvent extends SettingsEvent {
  final  String? image;
  final String? extention;

  UpdateProfileImageEvent({this.image,this.extention});
}

/// View Personal Information
class ViewPersonalInformationEvent extends SettingsEvent {
}

/// Transaction Limit
class GetTranLimitEvent extends SettingsEvent {
  final String? messageType;
  final String? channelType;

  GetTranLimitEvent({this.messageType, this.channelType});
}
/// Reset Transaction Limit
class ResetTranLimitEvent extends SettingsEvent {
  final String? messageType;

  ResetTranLimitEvent({this.messageType});
}

class GetNotificationSettingsEvent extends SettingsEvent {
  final String? messageType;

  GetNotificationSettingsEvent({
    this.messageType,
  });
}

class UpdateNotificationSettingsEvent extends SettingsEvent {
  final String? messageType;
  final bool? notificationModeSms;
  final bool? notificationModeEmail;

  UpdateNotificationSettingsEvent(
      {this.messageType, this.notificationModeEmail, this.notificationModeSms});
}

class UpdateProfileDetailsEvent extends SettingsEvent {
  String cName;
  String name;
  String uName;
  String mobile;
  String email;

  UpdateProfileDetailsEvent(
      {required this.cName,
      required this.name,
      required this.email,
      required this.mobile,
      required this.uName});
}

class GetHomeDetailsEvent extends SettingsEvent{
  final int timeStamp;
  GetHomeDetailsEvent({required this.timeStamp});
}

///Update TXN Limit
class UpdateTxnLimitEvent extends SettingsEvent{
  final String? messageType;
  final String? channelType;
  List<TransactionLimit>? txnLimit;

  UpdateTxnLimitEvent({this.messageType, this.channelType, this.txnLimit});
}