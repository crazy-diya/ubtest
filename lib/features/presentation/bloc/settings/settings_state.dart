

import '../../../data/models/responses/settings_tran_limit_response.dart';
import '../../../data/models/responses/get_home_details_response.dart';
import '../../../data/models/responses/update_profile_image_response.dart';
import '../../../data/models/responses/view_personal_information_response.dart';
import '../base_state.dart';

abstract class SettingsState extends BaseState<SettingsState> {}

class InitialSettingsState extends SettingsState {}

/// Profile Image Upload
class ProfileImageUploadSuccessState extends SettingsState {
final UpdateProfileImageResponse? updateProfileImageResponse;

  ProfileImageUploadSuccessState({this.updateProfileImageResponse});
}

class ProfileImageUploadFailedState extends SettingsState {
  final String? message;

  ProfileImageUploadFailedState({this.message});
}

/// View Personal Information
class ViewPersonalInformationSuccessState extends SettingsState {
  final ViewPersonalInformationResponse? viewPersonalInformationResponse;

  ViewPersonalInformationSuccessState({this.viewPersonalInformationResponse});
}

class ViewPersonalInformationFailedState extends SettingsState {
  final String? message;

  ViewPersonalInformationFailedState({this.message});
}

/// Update profile details
class EditProfileDetailsSuccessState extends SettingsState {
  final String? code;

  final String? message;
  EditProfileDetailsSuccessState({this.code, this.message});
}

class EditProfileDetailsFailState extends SettingsState {
  
final String? code;
  final String? message;
  EditProfileDetailsFailState({this.message,this.code});
}

class GetHomeDetailsSuccessState extends SettingsState{
  final GetHomeDetailsResponse? getHomeDetailsResponse;
  String? name;

  GetHomeDetailsSuccessState({this.getHomeDetailsResponse, this.name});
}

class GetHomeDetailsFailedState extends SettingsState {
  final String? message;

  GetHomeDetailsFailedState({this.message});
}

class UpdateNotificationSettingsSuccessState extends SettingsState {
  final String? code;

  final String? message;

  UpdateNotificationSettingsSuccessState({this.message, this.code});
}

class UpdateNotificationSettingsFailedState extends SettingsState {
  final String? message;

  UpdateNotificationSettingsFailedState({this.message});
}

class GetNotificationSettingsSuccessState extends SettingsState {
  final bool? smsSettings;
  final bool? emailSettings;

  GetNotificationSettingsSuccessState({this.smsSettings, this.emailSettings});
}

class GetNotificationSettingsFailedState extends SettingsState {
  final String? message;

  GetNotificationSettingsFailedState({this.message});
}

/// Transaction Limit
class GetTransLimitSuccessState extends SettingsState {
  final List<TranLimitDetails>? tranLimitDetails;
  final String? code;
  final String? message;

  GetTransLimitSuccessState({this.tranLimitDetails, this.code, this.message});
}

class GetTransLimitFailedState extends SettingsState {
  final String? message;

  GetTransLimitFailedState({this.message});
}

/// Update TXN Limit
class UpdateTxnLimitSuccessState extends SettingsState {
  final String? message;
  final String? code;

  UpdateTxnLimitSuccessState({this.message , this.code});
}

class UpdateTxnLimitFailedState extends SettingsState {
  final String? message;

  UpdateTxnLimitFailedState({this.message});
}
/// Reset TXN Limit
class ResetTxnLimitSuccessState extends SettingsState {
  final String? message;
  final String? code;

  ResetTxnLimitSuccessState({this.message, this.code});
}

class ResetTxnLimitFailedState extends SettingsState {
  final String? message;

  ResetTxnLimitFailedState({this.message});
}
