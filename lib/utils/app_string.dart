import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

extension LocalizeString on String {
  String localize(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}

class AppString {
  // document verification
  static const String dvIdCaptureSelfie = "dv_idCapture_selfie";
  static const String dvIdCaptureFontID = "dv_id_capture_front_id";
  static const String dvIdCaptureBackID = "dv_id_capture_back_id";

  /// Validation Messages
  static const String validMobile = "enter_valid_mobile_no";
  static const String validEmail = "enter_valid_email";
  static const String validNicKey = "enter_valid_nic";
  static const String validNic = "Enter a valid NIC";
  static const String validNicDob = "NIC does not match with DOB";

  static const String emptyUsername = "error_empty_username";
  static const String password = "password";
  static const String emptyOldPassword = "error_empty_old_password";
  static const String emptyNewPassword = "error_empty_new_password";
  static const String emptyConfirmNewPassword =
      "error_empty_confirm_new_password";

  static const String passwordCheckByLength = "password_check_by_length";
  static const String passwordCheckByLowerCase = "password_check_by_lower_case";
  static const String passwordCheckByUpperCase = "password_check_by_upper_case";
  static const String passwordCheckBySpecialCharLength =
      "password_check_by_special_char_length";
  static const String passwordCheckByNumericChar =
      "password_check_by_numeric_char";
  static const String passwordCheckByRepeatedChar =
      "password_check_by_repeated_char";
  static const String usernameCheckByLength = "username_check_by_length";
  static const String usernameCheckByLowerCase = "username_check_by_lower_case";
  static const String usernameCheckByUpperCase = "username_check_by_upper_case";
  static const String usernameCheckBySpecialCharLength =
      "username_check_by_special_char_length";
  static const String usernameCheckByNumericChar =
      "username_check_by_numeric_char";
  static const String usernameCheckByRepeatedChar =
      "username_check_by_repeated_char";
}
