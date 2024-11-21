import 'dart:convert';
import 'dart:developer';
import 'dart:math' as rad;

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_bank_mobile/features/data/models/common/otp_handler.dart';
import 'package:union_bank_mobile/features/data/models/responses/mobile_login_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/save_and_exits_data.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:uuid/uuid.dart';

import '../models/requests/wallet_onboarding_data.dart';
import '../models/responses/settings_tran_limit_response.dart';

const String _PUSH_TOKEN = 'push_token';
const String _AUTH_TOKEN = 'auth_token';
const String _CHALLENGE_ID = 'challenge_id';
const String _ACCESS_TOKEN = 'access_token';
const String _REFRESH_TOKEN = 'refresh_token';
const String _APP_ID = 'app_id';
const String _INITIAL_LAUNCH_FLAG = 'initial_launch_flag';
const String appWalletOnBoardingData = "appWalletOnBoardingData";
const String appNewInstallKey = "newlyInstalled";
const String ghostId = 'ghost_id';
const String epicUserId = "epic_user_id";
const String epicUserIdDeepLink = "epic_user_id_deep_link";
const String lastLoginDate = "last_login_date";
const String registerStatus = "register_status";
const String settingBiometricAttempts = "setting_biometric_attemts";
const String forgetPasswordUserName = "forget_password_user_name";
const String appBiometricState = "app_biometric_state";
const String _BIOMETRIC_CODE = 'biometric_code';
const String _BIOMETRIC_ATTEMPTS = 'biometric_attempts';
const String username_key = 'username_key';
const String loginname_key = 'name';
const String _prefLanguageState = "language_state";
const String _onboardingState = "onboarding_state";
const String _isNewDevice = "is_new_device";
const String _appLanguage = "app_language";
const String callingName = "cName";
const String _quickAccess = "quick_access";
const String _newUserDemoTour = "new_user_demo_tour";
const String _profileImageKey= "profile_image_key";
const String _profileImageByte= "profile_image_byte";
const String _txnLimits= "txnLimitList";
const String _passwordPolicy= "password_policy";
const String _userNamePolicy= "username_policy";
const String _marketingBanners= "marketing_banners";
const String _marketingDescription= "marketing_description";
const String _saveAndExist= "save_and_exist";
const String _otpHandler= "otp_handler";
const String _isMigratedeKey= "is_migrated_key";
const String _csiServiceCharge = "csi_service_charge";
const String _csiDeliveryCharge = "csi_delivery_charge";
const String _SEGMENT_CODE = "segment_code";
const String _COMMON_PUSH_STATUS = "common_push_status";


const String appOtpResponseDTOData = "appOtpResponseDTOData";

class LocalDataSource {
  FlutterSecureStorage? secureStorage;
  SharedPreferences? prefs;

  LocalDataSource(
      {FlutterSecureStorage? securePreferences,
      SharedPreferences? sharedPreferences}) {
    secureStorage = securePreferences;
    prefs = sharedPreferences;
  }

  Future<bool> hasPushToken() async {
    return await prefs!.containsKey(_PUSH_TOKEN);
  }

  Future<bool> isInitialLaunchDone() async {
    return await secureStorage!.containsKey(key: _INITIAL_LAUNCH_FLAG);
  }

  void setPushToken(String token) {
    log('[App Store] Storing push token => $token');
    prefs!.setString(_PUSH_TOKEN,token);
  }

  void setInitialLaunch() {
    secureStorage!
        .write(key: _INITIAL_LAUNCH_FLAG, value: _INITIAL_LAUNCH_FLAG);
  }

  Future<String?> getPushToken() async {
    return await prefs!.getString(_PUSH_TOKEN);
  }

  void clearPushToken() {
    prefs!.remove(_PUSH_TOKEN);
  }

  void setToken(String token) {
    secureStorage!.write(key: _AUTH_TOKEN, value: token);
  }

  Future<String?> getToken() async {
    return await secureStorage!.read(key: _AUTH_TOKEN);
  }

  void clearToken() {
    secureStorage!.delete(key: _AUTH_TOKEN);
  }

  Future<bool> hasAuthToken() async {
    if (secureStorage?.containsKey(key: _AUTH_TOKEN) != null) {
      final bool token = (await secureStorage!.read(key: _AUTH_TOKEN))!.isEmpty;
      return !token;
    } else {
      return false;
    }
  }

  /// Set & Get challenge ID
   void setChallengeId(String challengeId) {
    prefs?.setString(_CHALLENGE_ID,  challengeId);
  }

  Future<String?> getChallengeId() async {
    return await prefs!.getString( _CHALLENGE_ID);
  }


  /// EPIC USER ID
  // -> Setter
  void setEpicUserId(String epicUserIdValue) {
    prefs!.setString(epicUserId, epicUserIdValue);
  }

  // -> Getter
  String? getEpicUserId() {
    return prefs!.getString(epicUserId);
  }

   Future<bool> clearEpicUserId() {
   return prefs!.remove(epicUserId);
  }

  /// EPIC USER ID FOR DEEP LINK
  // -> Setter
  void setEpicUserIdForDeepLink(String epicUserIdValue) {
    prefs!.setString(epicUserIdDeepLink, epicUserIdValue);
  }

  // -> Getter
  String? getEpicUserIdForDeepLink() {
    return prefs!.getString(epicUserIdDeepLink);
  }

  Future<bool> clearEpicUserIdForDeepLink() {
   return prefs!.remove(epicUserIdDeepLink);
  }


  /// Last Login date

  void setLastLoginDate(String lastLoginDateValue) {
    prefs!.setString(lastLoginDate, lastLoginDateValue);
  }

  // -> Getter
  String? getLastLoginDate() {
    return prefs!.getString(lastLoginDate);
  }

  /// RESGISTER STATUS
  // -> Setter
  void setRegisterStatus(String registerStatusValue) {
    prefs!.setString(registerStatus, registerStatusValue);
  }

  // -> Getter
  String? getRegisterStatus() {
    return prefs!.getString(registerStatus);
  }

   Future<bool> clearRegisterStatus() {
    return prefs!.remove(registerStatus);
  }


  // -> Setter
  void setSettingBiometricAttempts(String registerStatusValue) {
    prefs!.setString(settingBiometricAttempts, registerStatusValue);
  }

  // -> Getter
  String? getSettingBiometricAttempts() {
    return prefs!.getString(settingBiometricAttempts);
  }

   Future<bool> clearSettingBiometricAttempts() {
    return prefs!.remove(settingBiometricAttempts);
  }

  void setForgetPasswordUsername(String usename) {
    prefs!.setString(forgetPasswordUserName, usename);
  }

  // -> Getter
  String? getForgetPasswordUsername() {
    return prefs!.getString(forgetPasswordUserName);
  }

  ///Set Password Policy

  void setPasswordPolicy(PasswordPolicy passwordPolicy) {
    prefs!.setString(_passwordPolicy,jsonEncode(passwordPolicy.toJson()));
  }

  PasswordPolicy getPasswordPolicy() {
  return PasswordPolicy.fromJson(jsonDecode(prefs!.getString(_passwordPolicy)??""));
  }

  ///Set username Policy

  void setUserNamePolicy(UserNamePolicy userNamePolicy) {
    prefs!.setString(_userNamePolicy,jsonEncode(userNamePolicy.toJson()));
  }

  UserNamePolicy getUserNamePolicy() {
    return UserNamePolicy.fromJson(jsonDecode(prefs!.getString(_userNamePolicy)??""));
  }

  ///Set Banner

void setMarketingBanners(List<String> marketingBanners) {
    prefs!.setStringList(_marketingBanners,marketingBanners);
  }

List<String>? getMarketingBanners() {
   final value = prefs!.getStringList(_marketingBanners);
   return value;
  }

  void setDescriptionBanners(String marketingDescription) {
      prefs!.setString(_marketingDescription, marketingDescription);
  }

String? getDescriptionBanners() {
  return prefs!.getString(_marketingDescription);
  }


   ///Set SaveAndExist

  Future<bool> setSaveAndExist(SaveAndExist saveAndExist) async {
   return await prefs!.setString(_saveAndExist,jsonEncode(saveAndExist.toJson()));
  }

  SaveAndExist getSaveAndExist() {
  return SaveAndExist.fromJson(jsonDecode(prefs?.getString(_saveAndExist)?? '{}'));
  }


    ///Set OtpHandler

  Future<bool> setOtpHandler(OtpHandler otpHandler) async {
   return await prefs!.setString(_otpHandler,jsonEncode(otpHandler.toJson()));
  }

  OtpHandler getOtpHandler() {
  return OtpHandler.fromJson(jsonDecode(prefs?.getString(_otpHandler)?? '{}'));
  }

   Future<bool> clearOtpHandler() {
    return prefs!.remove(_otpHandler);
  }



  ///GHOST ID
  // -> Setter
  String setGhostId() {
    final random = rad.Random();
    const hexCharacters = '0123456789abcdef';

    String generateSection(int length) {
      String section = '';
      for (var i = 0; i < length; i++) {
        final randomIndex = random.nextInt(hexCharacters.length);
        section += hexCharacters[randomIndex];
      }
      return section;
    }

    final id =
        '${generateSection(8)}-${generateSection(4)}-${generateSection(4)}-${generateSection(4)}-${generateSection(12)}';
    prefs!.setString(ghostId, id);
    return id;
  }

  // -> Getter
  String? getGhostId() {
    return prefs!.getString(ghostId);
  }

  //  Future<bool> clearGhostId() {
  //   return prefs!.remove(ghostId);
  // }

  /// APP ID
  // -> Setter
  String setAppID() {
    final uuid = const Uuid().v4();
    prefs!.setString(_APP_ID, uuid);
    return uuid;
  }

  // -> Getter
  String? getAppID() {
    return prefs!.getString(_APP_ID);
  }

   Future<bool> clearAppID() {
    return prefs!.remove(_APP_ID);
  }

  /// Language
  // -> Setter
  void setLanguageState() {
    prefs!.setBool(_prefLanguageState, true);
  }

  // -> Getter
  bool? getLanguageState() {
    return prefs!.getBool(_prefLanguageState);
  }

  bool hasLanguageState() {
    return prefs!.containsKey(_prefLanguageState);
  }

  void setLanguage(String lang) {
    prefs!.setString(_appLanguage, lang);
  }

  // -> Getter
  String getLanguage() {
    if (prefs!.getKeys().contains(_appLanguage)) {
      return prefs!.getString(_appLanguage)!;
    }
    return "en";
  }

  ///Quick Access State

  bool hasQuickAccessState() {
    return prefs!.containsKey(_quickAccess);
  }

  Future<bool>  setQuickAccess(List<String> ids) {
    // final list = getQuickAccessList();
    // list.a(ids);
    return prefs!.setStringList(_quickAccess, ids);
  }


  // -> Getter
  List<String> getQuickAccessList() {
    if (hasQuickAccessState()) {
      return prefs!.getStringList(_quickAccess)!;
    } else {
      prefs!.setStringList(_quickAccess, ["0", "1", "2", "3"]);
      return prefs!.getStringList(_quickAccess)!;
    }
  }


    // -> Getter

  bool hasNewUserDemoTour() {
    return prefs!.containsKey(_newUserDemoTour);
  }

  Future<bool> setNewUserDemoTour(bool value) {
    return prefs!.setBool(_newUserDemoTour, value);
  }

  bool getNewUserDemoTour() {
    if (hasNewUserDemoTour()) {
      return prefs!.getBool(_newUserDemoTour)!;
    } else {
      prefs!.setBool(_newUserDemoTour, true);
      return prefs!.getBool(_newUserDemoTour)!;
    }
  }


  void setProfileImageKey(String imageKey){
    prefs!.setString(_profileImageKey, imageKey); 
  }

  String? getProfileImageKey() {
    return prefs!.getString(_profileImageKey);
  }

   bool hasProfileImageKey() {
    return prefs!.containsKey(_profileImageKey);
  }

   void setProfileImageByte(String imageByte){
    prefs!.setString(_profileImageByte, imageByte); 
  }

    Uint8List? getProfileImageByte() {
    return AppUtils.decodeBase64(prefs!.getString(_profileImageByte) ?? "");
  }

   bool hasProfileImageByte() {
    return prefs!.containsKey(_profileImageByte);
  }

  /// Onboarding State
  // -> Setter
  void setOnboardingState() {
    prefs!.setBool(_onboardingState, true);
  }

  // -> Getter
  bool? getOnboardingState() {
    return prefs!.getBool(_onboardingState);
  }

  /// New Device State
  // -> Setter
  void setNewDeviceState(String value) {
    prefs!.setString(_isNewDevice, value);
  }

  // -> Getter
  String? getNewDeviceState() {
    return prefs?.getString(_isNewDevice)??JustPayState.INIT.name;
  }


  void setUserName(String username) {
    secureStorage!.write(key: username_key, value: username);
  }

  void setLoginName(String logName) {
    prefs!.setString(loginname_key,logName);
  }
  String getLoginName() {
    return prefs!.getString(loginname_key)!;
  }

  void setTxnLimits(List<TranLimitDetails> txnLimiListForFT) async{
   await prefs!.setStringList(_txnLimits,txnLimiListForFT.map((e) => jsonEncode(e.toJson())).toList());

  }

  List<TranLimitDetails>? getTxnLimits() {
   final value = prefs!.getStringList(_txnLimits);
   return value?.map((e) => TranLimitDetails.fromJson(json.decode(e))).toList();
  }

  void setBiometricAttemts(int attempts) {
    prefs!.setInt(_BIOMETRIC_ATTEMPTS, attempts);
  }

  int getBiometricAttemts(){
    return prefs!.getInt(_BIOMETRIC_ATTEMPTS)??0;
  }

  void clearBiometricAttemts(){
     prefs!.remove(_BIOMETRIC_ATTEMPTS);
  }

  Future<bool> hasUsername() async {
    final contain = await secureStorage!.containsKey(key: username_key);
    return contain;
  }

  Future<String> getUsername() async {
    final usernameValue = await secureStorage!.read(key: username_key);
    return usernameValue!;
  }

  /// APP ON BOARDING DATA
  // Remove Wallet On Boarding Data
  Future<void> removeAppWalletOnBoardingData() async {
    await secureStorage!.delete(key: appWalletOnBoardingData);
  }

  bool hasOnboardingState() {
    return prefs!.containsKey(_onboardingState);
  }

  /// Check if App is newly installed and clear data
  Future<void> checkIfAppIsNewInstalled() async {
    final bool containsKey = prefs!.containsKey(appNewInstallKey);
    if (!containsKey) {
      // await removeAppWalletOnBoardingData();
      deleteAllDataInSecureStorage();
      await prefs!.setString(appNewInstallKey, "1");
      // return true;
    }
  }

  /// Delete All Data
  void deleteAllDataInSecureStorage() {
    secureStorage!.deleteAll();
  }

  void setBiometric(String? code) {
    secureStorage!.write(key: _BIOMETRIC_CODE, value: code);
  }

  Future<String?> getBiometricCode() async {
    final bool hasBiometric =
        await secureStorage!.containsKey(key: _BIOMETRIC_CODE);
    if (hasBiometric) {
      final String? value = await secureStorage!.read(key: _BIOMETRIC_CODE);
      return value;
    } else {
      return null;
    }
  }

  void setAccessToken(String? token) {
    secureStorage!.write(key: _ACCESS_TOKEN, value: token);
  }

  Future<String?> getAccessToken() async {
    return secureStorage!.read(key: _ACCESS_TOKEN);
  }

  void clearAccessToken() {
    secureStorage!.delete(key: _ACCESS_TOKEN);
  }

  void clearBiometric() {
    secureStorage!.delete(key: _BIOMETRIC_CODE);
  }

  void setRefreshToken(String? token) {
    secureStorage!.write(key: _REFRESH_TOKEN, value: token);
  }

  Future<String?> getRefreshToken() async {
    return secureStorage!.read(key: _REFRESH_TOKEN);
  }

  void clearRefreshToken() {
    secureStorage!.delete(key: _REFRESH_TOKEN);
  }

  // Get Wallet On Boarding Data
  Future<WalletOnBoardingData?> getAppWalletOnBoardingData() async {
    try {
      final String? data =
          await secureStorage!.read(key: appWalletOnBoardingData);
      if (data == null) {
        return null;
      }
      return WalletOnBoardingData.fromJson(jsonDecode(data));
    } on Exception {
      rethrow;
    }
  }

  // Store Wallet On Boarding Data
  Future<bool> storeAppWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData) async {
    try {
      final String data = jsonEncode(walletOnBoardingData.toJson());
      await secureStorage!.write(key: appWalletOnBoardingData, value: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

//Store  Otp Response DTO Data
   Future<bool> storeOtpResponseDTO(OtpResponseDto? otpResponseDto) async {
    try {
      final String data = jsonEncode(otpResponseDto?.toJson());
      await prefs!.setString(appOtpResponseDTOData,data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  //Get  Otp Response DTO Data
  Future<OtpResponseDto?> getOtpResponseDTO() async {
    try {
      final String? data = await secureStorage!.read(key: appOtpResponseDTOData);
      if (data == null) {
        return null;
      }
      return OtpResponseDto.fromJson(jsonDecode(data));
    } on Exception {
      rethrow;
    }
  }

   void setMigratedFlag(String isMigrated){
    prefs!.setString(_isMigratedeKey, isMigrated); 
  }

  String? getMigratedFlag() {
    return prefs!.getString(_isMigratedeKey);
  }

   bool hasMigratedFlag() {
    return prefs!.containsKey(_isMigratedeKey);
  }

    Future<bool> clearMigratedFlag() {
   return prefs!.remove(_isMigratedeKey);
  }

  /// User Segment && Topic subscription
  void setSegmentCode(String segment) {
    prefs?.setString(_SEGMENT_CODE,  segment);
  }

  Future<String?> getSegmentCode() async {
    return await prefs!.getString(_SEGMENT_CODE);
  }

  void clearSegmentCode() {
    prefs!.remove(_SEGMENT_CODE);
  }

  void setCommonPushStatus(String status) {
    prefs?.setString(_COMMON_PUSH_STATUS,  status);
  }

  Future<String?> getCommonPushStatus() async {
    return await prefs!.getString(_COMMON_PUSH_STATUS);
  }

  void clearCommonPushStatus() {
    prefs!.remove(_COMMON_PUSH_STATUS);
  }
}

