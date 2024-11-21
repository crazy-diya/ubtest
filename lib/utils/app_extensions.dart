import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import 'app_localizations.dart';
import 'enums.dart';
import 'navigation_routes.dart';
import 'app_constants.dart';

extension SHA256Ext on String {
  String getSHA256() {
    return sha256.convert(utf8.encode(this)).toString();
  }
}

extension MaskingExt on String {
  String maskMobileNumber() {
    return replaceAll(RegExp(r'.(?=.{4})'), '*');
  }
}

extension DropDownKeyValues on String? {
  String? getTitle() {
    final String? titleValue = this;
    for (final title in kTitleList) {
      if (titleValue == title.description) {
        return title.key;
      }
    }
    return "-";
  }

  String? getLanguage() {
    final String? languageValue = this;
    for (final language in kLanguageList) {
      if (languageValue == language.description) {
        return language.key;
      }
    }
    return "-";
  }

  String? getReligion() {
    final String? religionValue = this;
    for (final religion in kReligionList) {
      if (religionValue == religion.description) {
        return religion.key;
      }
    }
    return "-";
  }
  String? getTransactionMode() {
    final String? mode = this;
    for (final transMode in kTransactionMode) {
      if (mode == transMode.description) {
        return transMode.key;
      }
    }
    return "-";
  }

  String? getAccountPurpose() {
    final String? purpose = this;
    for (final accPurpose in kAccountPurpose) {
      if (purpose == accPurpose.description) {
        return accPurpose.key;
      }
    }
    return "-";
  }
  String? getCustomerType() {
    final String? customerType = this;
    for (final type in kCustomerType) {
      if (customerType == type.description) {
        return type.key;
      }
    }
    return "-";
  }
  String? getFieldOfEmployment() {
    final String? fieldOfEmp = this;
    for (final emp in kFieldOfEmployment) {
      if (fieldOfEmp == emp.description) {
        return emp.key;
      }
    }
    return "-";
  }
  String? getSourceOfFunds() {
    final String? funds = this;
    for (final sourceFunds in kSourceOfFunds) {
      if (funds == sourceFunds.description) {
        return sourceFunds.key;
      }
    }
    return "-";
  }
  String? getMonthlyIncome() {
    final String? income = this;
    for (final monthlyIncome in kMonthlyIncome) {
      if (income == monthlyIncome.description) {
        return monthlyIncome.key;
      }
    }
    return "-";
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension DeviceOSExt on DeviceOS {
  String getValue() {
    if (Platform.isIOS)
      return "IOS";
    else
      return this.toString().split(".").last;
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension IDTypeSelector on IDType {
  String getType() {
    switch (this) {
      case IDType.SELFIE:
        return "IP";
      case IDType.ID_FRONT:
        return "IF";
      case IDType.ID_BACK:
        return "IB";
    }
  }
}

extension Base64Ext on String {
  String getBase64() {
    return base64Encode(File(this).readAsBytesSync());
  }
}

extension KYCStepsExt on KYCStep {
  String getLabel(BuildContext context) {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return AppLocalizations.of(context).translate("personal_information");
      case KYCStep.CONTACTINFO:
        return AppLocalizations.of(context).translate("contact_information");
      case KYCStep.EMPDETAILS:
        return AppLocalizations.of(context).translate("employment_details");
      case KYCStep.OTHERINFO:
        return AppLocalizations.of(context).translate("other_information");
      case KYCStep.DOCUMENTVERIFY:
        return AppLocalizations.of(context).translate("document_verification");
      case KYCStep.SCHEDULEVERIFY:
        return AppLocalizations.of(context).translate("schedule_verification");
      case KYCStep.REVIEW:
        return AppLocalizations.of(context).translate("review_details");
      case KYCStep.TNC:
        return AppLocalizations.of(context).translate("terms_and_conditions");
      default:
        return "";
    }
  }

  String getNavigationRouteName() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return Routes.kPersonalInformationView;
      case KYCStep.CONTACTINFO:

      case KYCStep.EMPDETAILS:

      case KYCStep.OTHERINFO:

      case KYCStep.DOCUMENTVERIFY:

      case KYCStep.SCHEDULEVERIFY:

      case KYCStep.REVIEW:

      case KYCStep.TNC:

      case KYCStep.BIOMETRIC:

      case KYCStep.SECURITYQ:

      case KYCStep.INTERSTEDPROD:

      case KYCStep.CREATEUSER:

      default:
        return "";
    }
  }

  int getStep() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return 1;
      case KYCStep.CONTACTINFO:
        return 2;
      case KYCStep.EMPDETAILS:
        return 3;
      case KYCStep.OTHERINFO:
        return 4;
      case KYCStep.DOCUMENTVERIFY:
        return 5;
      case KYCStep.SCHEDULEVERIFY:
        return 6;
      case KYCStep.REVIEW:
        return 7;
      case KYCStep.TNC:
        return 0;
      case KYCStep.BIOMETRIC:
        return 11;
      case KYCStep.SECURITYQ:
        return 9;
      case KYCStep.INTERSTEDPROD:
        return 8;
      case KYCStep.CREATEUSER:
        return 10;
      default:
        return 0;
    }
  }

}

extension NameInitial on String {
  String? getNameInitial() {
    final String name = trim();
    if (name.isEmpty) {
      return "";
    }

    // Extract the first character (using Unicode grapheme clusters)
    String getFirstChar(String input) {
      return input.characters.first;
    }


    final List<String> splittedName = name.split(" ");

    if (splittedName.isEmpty) {
      return "";
    }

    // Process the first and last parts of the name
    String getInitial(String input) {
      final firstChar = getFirstChar(input);
      return isEmoji(firstChar) ? firstChar : firstChar.toUpperCase();
    }

    if (splittedName.length == 1) {
      final firstChar = getFirstChar(splittedName.first);
      return isEmoji(firstChar) ? firstChar : getInitial(splittedName.first);
    } else {
      final firstChar = getFirstChar(splittedName.first);
      return isEmoji(firstChar)
          ? firstChar
          : '${getInitial(splittedName.first)}${getInitial(splittedName.last)}';
    }
  }
}

extension WithThousandSeparator on String {
  String withThousandSeparator() {
    if(this == ""){
      return "0.00";
    }else{
      final value = NumberFormat("#,##0.00", "en_US");
      final formatValue = double.parse(this).toStringAsFixed(2);
      return value.format(double.parse(formatValue));
    }

  }
}

extension IsValidDate on String {
  bool isDate() {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension ToValidTime on String {
  String toValidTime() {
    try {
      String separator = ':'; // The value you want to add between pairs

      List<String> result = [
        for (int i = 0; i < this.length; i += 2) this.substring(i, i + 2)
      ];

      String dateString = result.join(separator);

      return dateString;
    } catch (e) {
      return "00:00";
    }
  }
}


// extension ToAccountMask on String {
//   String toAccountMask() {
//     try {
//       if (this.isEmpty) {
//         return '';
//       }

//       bool isNumeric = this.codeUnits.every((unit) => unit >= 48 && unit <= 57);

//       if (!isNumeric) {
//         return this;
//       }

//       List<String> chunks = [];
//       for (int i = 0; i < this.length; i += 4) {
//         int end = (i + 4 < this.length) ? i + 4 : this.length;
//         chunks.add(this.substring(i, end));
//       }

//       return chunks.join(' ');
//     } catch (e) {
//       return '';
//     }
//   }
// }

/// format *** **** ***
extension ToPhoneNumberMask on String {
  String maskPhoneNumber() {

    var maskedNumber = "";
    for (var i = 0; i < length; i++) {
      maskedNumber += this[i]; // Access character using this keyword
      if (i == 2 || i == 6) {
        maskedNumber += " ";
      }
    }
    return maskedNumber;
  }
}

///format **** *** ***
String formatMobileNumber(String number) {
  String cleanedNumber = number.replaceAll(' ', '');
  if (cleanedNumber.length != 10) {
    return number;
  }
  RegExp regExp = RegExp(r'(\d{4})(\d{3})(\d{3})');
  String formattedNumber = cleanedNumber.replaceAllMapped(regExp, (Match match) => '${match[1]} ${match[2]} ${match[3]}');
  return formattedNumber;
}

/// format *** *** ****
// String formatMobileNumber2(String input) {
//   String cleaned = input.replaceAll(RegExp(r'\D'), '');
//   if (cleaned.length != 10) {
//     return 'Invalid number';
//   }
//     String formatted = '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
//
//     return formatted;
//   }


extension StringCasingExtension on String {
  String toTitleCase() {
    try {
      if (this.isEmpty) {
        return this;
      }
      return this.split(' ').map((word) {
        if (word.isEmpty) {
          return word;
        }
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    } catch (e) {
      return this;
    }
  }
}


extension ToValidDate on String {
  String toValidDate() {
    try {
      String separator = '-'; // The value you want to add between pairs
      List<String> result = [];

      if (this.length == 6) {
        result = [
          for (int i = 0; i < this.length; i += 2) this.substring(i, i + 2)
        ];
      } else {
        final String date = "0$this";
        result = [
          for (int i = 0; i < date.length; i += 2) date.substring(i, i + 2)
        ];
      }

      String dateString = result.join(separator);

      DateTime dateTime = DateFormat('dd-MM-yy').parse(dateString);
      if (dateTime.year < 2000) {
        dateTime = DateTime(dateTime.year + 100, dateTime.month, dateTime.day);
      }
      return dateTime.toIso8601String();
    } catch (e) {
      return "";
    }
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension PhoneNumberFormatter on String {
  String toPhoneNumberFormat({List<int>? split}) {
    // Check if the string is exactly 10 digits long
    if (this.length != 10) {
      throw FormatException('Phone number must be exactly 10 digits long');
    }

    // Use a regular expression to format the phone number
    final RegExp phoneNumberRegExp = RegExp(r'(\d{4})(\d{3})(\d{3})');
    final match = phoneNumberRegExp.firstMatch(this);

    if (match != null) {
      // Return the formatted string
      return '${match.group(1)} ${match.group(2)} ${match.group(3)}';
    } else {
      throw FormatException('Invalid phone number format');
    }
  }
}

extension CleanStringExtension on String? {
  String removeUnwantedProductCodes() {
    if (this == null) return '';
    return this!.replaceAll(RegExp(r'[^A-Za-z\s]'), '');
  }
}

