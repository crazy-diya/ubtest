import 'dart:convert';
import 'dart:io';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/domain/usecases/settings/get_home_details.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/edit_profile_details_request.dart';
import '../../../data/models/requests/get_home_details_request.dart';
import '../../../data/models/requests/get_notification_settings_request.dart';
import '../../../data/models/requests/settings_tran_limit_request.dart';
import '../../../data/models/requests/settings_update_txn_limit_request.dart';
import '../../../data/models/requests/txn_limit_reset_request.dart';
import '../../../data/models/requests/update_notification_settings_request.dart';
import '../../../data/models/requests/update_profile_image_request.dart';
import '../../../data/models/requests/view_personal_information_request.dart';
import '../../../domain/usecases/settings/get_notification_settings.dart';
import '../../../domain/usecases/settings/reset_txn_limit.dart';
import '../../../domain/usecases/settings/transaction_limit.dart';
import '../../../domain/usecases/settings/update_notification_settings.dart';
import '../../../domain/usecases/settings/update_txn_limit.dart';
import '../../../domain/usecases/edit_profile/update_profile_details.dart';
import '../../../domain/usecases/settings/view_personal_information.dart';
import '../../../../utils/api_msg_types.dart';

import '../../../domain/usecases/settings/update_profile_image.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, BaseState<SettingsState>> {
  final UpdateProfileImage? updateProfileImage;
  final ViewPersonalInformation? viewPersonalInformation;
  final GetTranLimits? getTranLimits;
  final GetHomeDetails? getHomeDetails;
  final UdateProfile? udateProfile;
  final UpdateTXNLimit? updateTXNLimit;
  final LocalDataSource? localDataSource;
  final GetNotification? getNotification;
  final UpdateNotificationSettings? updateNotificationSettings;
  final ResetTxnLimit? resetTxnLimit;

  SettingsBloc(
      {this.updateProfileImage,
      this.viewPersonalInformation,
      this.getTranLimits,
      this.getHomeDetails,
      this.updateTXNLimit,
      this.udateProfile,
      this.localDataSource,
      this.resetTxnLimit,
      this.getNotification,
      this.updateNotificationSettings}) : super(InitialSettingsState()) {
    on<UpdateProfileImageEvent>(_onUpdateProfileImageEvent);
    on<ViewPersonalInformationEvent>(_onViewPersonalInformationEvent);
    on<GetTranLimitEvent>(_getTranLimitEvent);
    on<GetHomeDetailsEvent>(_onGetHomeDetailsEvent);
    on<UpdateTxnLimitEvent>(_updateTxnLimitEvent);
    on<GetNotificationSettingsEvent>(_getNotificationSettingsEvent);
    on<UpdateNotificationSettingsEvent>(_updateNotificationSettingsEvent);
    on<UpdateProfileDetailsEvent>(_onUpdateProfileDetailsEvent);
    on<ResetTranLimitEvent>(_resetTranLimitEvent);
  }

  Future<void> _onUpdateProfileImageEvent(
      UpdateProfileImageEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final String binaryImage = base64Encode(File(event.image!).readAsBytesSync());
    // AppUtils.convertBase64(base64Encode(File(event.image!).readAsBytesSync()));
    final _result = await updateProfileImage!(
      UpdateProfileImageRequest(
        messageType: kProfileImgUpdateRequestType,
        image: binaryImage,
      ),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ProfileImageUploadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      localDataSource?.setProfileImageKey(r.data!.attachmentKey!);
      localDataSource?.setProfileImageByte("data:image/${event.extention};base64,$binaryImage");
      AppConstants.profileData.profileImageKey = r.data!.attachmentKey!;
      AppConstants.profileData.profileImage = AppUtils.decodeBase64(
          "data:image/${event.extention};base64,$binaryImage");
      return ProfileImageUploadSuccessState(
        updateProfileImageResponse: r.data,
      );
    }));
  }

  Future<void> _onViewPersonalInformationEvent(
      ViewPersonalInformationEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await viewPersonalInformation!(
      ViewPersonalInformationRequest(
        messageType: kGetPersonalInfoRequestType,
      ),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ViewPersonalInformationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ViewPersonalInformationSuccessState(
        viewPersonalInformationResponse: r.data,
      );
    }));
  }

  Future<void> _updateNotificationSettingsEvent(
      UpdateNotificationSettingsEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await updateNotificationSettings!(
      UpdateNotificationSettingsRequest(
          messageType: kNotificationSettingsUpdate,
          notificationModeSms: event.notificationModeSms,
          notificationModeEmail: event.notificationModeEmail),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return UpdateNotificationSettingsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "08" || r.responseCode == APIResponse.SUCCESS){
       return UpdateNotificationSettingsSuccessState(
            message: r.responseDescription);
      } else {
        return UpdateNotificationSettingsFailedState(
            message: r.errorDescription ?? r.errorDescription);

      }

    }));
  }

  Future<void> _getNotificationSettingsEvent(GetNotificationSettingsEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await getNotification!(
      GetNotificationSettingsRequest(
        messageType: kGetNotificationSettings,
      ),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetNotificationSettingsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetNotificationSettingsSuccessState(
        smsSettings: r.data?.smsSettings,
        emailSettings: r.data?.emailSettings,
      );
    }));
  }

   Future<void> _onGetHomeDetailsEvent(
      GetHomeDetailsEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    // emit(APILoadingState());
    final _result = await getHomeDetails!(
      GetHomeDetailsRequest(
        messageType: kGetHomeDetails,
        timeStamp: event.timeStamp,
      ),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetHomeDetailsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {

      AppConstants.profileData.cName = r.data!.callingName;
      AppConstants.profileData.name = r.data!.name;
      return GetHomeDetailsSuccessState(
        getHomeDetailsResponse: r.data,
      );
    }));
  }

  Future<void> _getTranLimitEvent(
      GetTranLimitEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await getTranLimits!(
        SettingsTranLimitRequest(
          messageType: event.messageType,
          channelType: event.channelType
        )
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetTransLimitFailedState(
            message: ErrorHandler().mapFailureToMessage(l)
        );
      }
    }, (r) {
      localDataSource?.setTxnLimits(r.data!.txnLimit!);
      return GetTransLimitSuccessState(
        tranLimitDetails: r.data!.txnLimit,
            code: r.responseCode,
        message: r.responseDescription
      );
    }));
  }

  Future<void> _updateTxnLimitEvent(UpdateTxnLimitEvent event, Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final result = await updateTXNLimit!(
        UpdateTxnLimitRequest(
          messageType: event.messageType,
          channelType: event.channelType,
          transactionLimits: event.txnLimit
        )
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return UpdateTxnLimitFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return UpdateTxnLimitSuccessState(message: r.responseDescription, code: r.responseCode);
    }));
  }




  ///Update profile details
  Future<void> _onUpdateProfileDetailsEvent(
      UpdateProfileDetailsEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await udateProfile!(
      UpdateProfileDetailsRequest(
        messageType: kUpdateProfileDetails,
        callingName: event.cName,
        name: event.name,
        email: event.email,
        mobileNumber: event.mobile,
        userName: event.uName,
      ),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return EditProfileDetailsFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode != "00"){
        return EditProfileDetailsFailState(
            message: r.responseDescription ?? r.errorDescription,
          code: r.responseCode ?? r.errorCode
        );
      } else {
        return EditProfileDetailsSuccessState(
            message: r.responseDescription ?? r.errorDescription,
            code: r.responseCode ?? r.errorCode
        );
      }
      // if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS){
      //   // localDataSource?.setLoginName(event.uName);
      //   // localDataSource?.setUserName(event.uName);
      //   // AppConstants.profileData.mobileNo = event.mobile;
      //   // AppConstants.profileData.email = event.email;
      //   // AppConstants.profileData.userName = event.uName;
      //   // AppConstants.profileData.name = event.name;
      //   // AppConstants.profileData.fName = event.cName;
      //   return EditProfileDetailsSuccessState(
      //     message: r.responseDescription,
      //     code: r.responseCode
      //   );
      // } if (r.responseCode == "01" || r.errorCode == "01"){
      //   return EditProfileDetailsSuccessState(
      //     message: r.responseDescription ?? r.errorDescription,
      //     code: r.responseCode ?? r.errorCode
      //   );
      // }
      //
      // else {
      //
      // }

    }
    ));
  }

///Reset txn Limits
  Future<void> _resetTranLimitEvent(
      ResetTranLimitEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final _result = await resetTxnLimit!(
        TxnLimitResetRequest(
            messageType: event.messageType,
        )
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ResetTxnLimitFailedState(
            message: ErrorHandler().mapFailureToMessage(l)
        );
      }
    }, (r) {
      if(r.responseCode == "00"){
        return ResetTxnLimitSuccessState(
            code: r.responseCode,
            message: r.responseDescription
        );
      }else{
        return ResetTxnLimitFailedState(
            message: r.responseDescription
        );
      }
    }));
  }





}








