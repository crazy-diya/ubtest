import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'txn_codes.dart';

class AppUtils {
  static String convertBase64(String encodeData) {
    return '$encodeData';
  }

  static Uint8List decodeBase64(String decodeData) {
    final UriData data = Uri.parse(decodeData).data ?? UriData.fromBytes([]);
    return data.contentAsBytes();
  }

  static String formattedDate(DateTime? dateTime) {
    String formattedDate = DateFormat('MMM dd').format(dateTime??DateTime.now());
    return formattedDate;
  }

  static String formattedDate2(DateTime? dateTime) {
    String formattedDate = DateFormat('yMMMEd').format(dateTime??DateTime.now());
    String formattedTime = DateFormat('jm').format(dateTime??DateTime.now());
    // Thu, Jun 29, 2566U at 10:21 AM
    return "$formattedDate at $formattedTime";
  }

   static String formattedDate3(DateTime? dateTime) {
    String formattedDate = DateFormat('MMMM dd').format(dateTime??DateTime.now());
    return formattedDate;
  }

  static IconData getAttachMentIcon(String type){
    switch (type) {
      case "pdf":
        return PhosphorIcons.filePdf(PhosphorIconsStyle.bold);
      case "xls":
        return PhosphorIcons.fileXls(PhosphorIconsStyle.bold);
       case "png":
        return PhosphorIcons.filePng(PhosphorIconsStyle.bold);
      default:
        return  PhosphorIcons.fileJpg(PhosphorIconsStyle.bold);
    }
  }

  static Future<String> downloadFiles(
      String decodeData, String fileName) async {
    Uint8List bytes = decodeBase64(decodeData);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/$fileName");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  // static String convertBase64Files(String encodeData, String fileType) {
  //   switch (fileType) {
  //     case "jpg":
  //       return 'data:image/jpg;base64,$encodeData';
  //     case "png":
  //       return 'data:image/png;base64,$encodeData';
  //     case "jpeg":
  //       return 'data:image/jpeg;base64,$encodeData';
  //     case "xls":
  //       return 'data:file/xls;base64,$encodeData';
  //     case "pdf":
  //       return 'data:file/pdf;base64,$encodeData';
  //     default:
  //       return "";
  //   }
  // }

  static String convertToCurrency(double amount,
      {bool shouldAddSymbol = true}) {
    return '${shouldAddSymbol ? 'LKR ' : ''}${NumberFormat.currency(symbol: '').format(amount)}';
  }

 

  //
  // static String getTraceNumber(AppSharedData appSharedData) {
  //   String trace;
  //   if (appSharedData.getData(TRACE_NUMBER) == '') {
  //     appSharedData.setData(TRACE_NUMBER, '1');
  //     trace = '1';
  //   } else {
  //     trace = appSharedData.getData(TRACE_NUMBER);
  //   }
  //
  //   if (trace.isNotEmpty) {
  //     if (trace == '999999') {
  //       appSharedData.setData(TRACE_NUMBER, '1');
  //     } else {
  //       var traceInt = int.parse(appSharedData.getData(TRACE_NUMBER));
  //       traceInt++;
  //       appSharedData.setData(TRACE_NUMBER, traceInt.toString());
  //     }
  //   } else {
  //     appSharedData.setData(TRACE_NUMBER, '1');
  //     trace = '1';
  //   }
  //
  //   return trace.padLeft(6, '0');
  // }

  static String getTxnTimestamp() {
    return DateFormat('yyyyMMddkkmmss').format(DateTime.now());
  }

  static bool shouldExpireSession(String txnCode) {
    return !(txnCode == TransactionCodes.FRESH_LOGIN ||
        txnCode == TransactionCodes.SECURITY_OTP ||
        txnCode == TransactionCodes.LOGIN_TRAN ||
        txnCode == TransactionCodes.WALLET_REGISTRATION_TRAN ||
        txnCode == TransactionCodes.PROFILE_IMAGE_UPLOAD_REQUEST ||
        txnCode == TransactionCodes.SPLASH_REQUEST ||
        txnCode == TransactionCodes.RESEND_OTP_TRAN ||
        txnCode == TransactionCodes.OTP_VERIFY_TRAN);
  }

 static String getFrequencyWithoutLocalization(String value) {
    switch (value) {
      case "daily":
        return "Daily";
      case "weekly":
        return "Weekly";
      case "monthly":
        return "Monthly";
      case "annually":
        return "Annually";
      default:
        return "Daily";
    }
  }
  
}

String maskPhoneNumber(String phoneNumber) {
  final maskedChars = '******';
  final countryCode = '+94';
  final countryCodeLength = countryCode.length;
  final maskedLength =
      phoneNumber.length - countryCodeLength - maskedChars.length;
  final maskedDigits = phoneNumber.substring(
      countryCodeLength, countryCodeLength + maskedLength);
  return '$countryCode$maskedDigits$maskedChars${phoneNumber.substring(phoneNumber.length - 2)}';
}

String greeting() {
    int currentHour = DateTime.now().hour;

    if (currentHour >= 3 && currentHour < 12) {
      return 'good_morning';
    } else if (currentHour >= 12 && currentHour < 15) {
      return 'good_afternoon';
    } else if (currentHour >= 15 && currentHour < 20) {
      return 'good_evening';
    } else if (currentHour >= 20 || currentHour < 3) {
      return 'good_night';
    } else {
      return 'hello';
    }
  }

  String splitAndJoinAtBrTags(String text) {
  String replacedText = text.replaceAll('<br><br>', '\n\n');
  replacedText = replacedText.replaceAll('<br>', '\n');
  return replacedText.split('\n').map((s) => s.trim()).join('\n');
}


   List<String> extractTextWithinTags({required String input, String tag = 'b'}) {
    List<String> result = [];
    final RegExp regExp = RegExp('(.*?)<\\/?$tag>(.*?)<\\/?$tag>|(.*)', multiLine: true);
    final Iterable<Match> matches = regExp.allMatches(input);

    for (final match in matches) {
      for (int i = 1; i <= match.groupCount; i++) {
        final matchText = match.group(i);
        if (matchText != null && matchText.isNotEmpty) {
          result.add(matchText.trim());
        }
      }
    }

    return result;
  }

  String decodeMessageBase64(String base64String,int count) {
  String decodedString = base64String;
  
  for (int i = 0; i < count; i++) {
    List<int> decodedBytes = base64.decode(decodedString);
    decodedString = utf8.decode(decodedBytes);
    
  }
  
  return decodedString;
}

double getFileSizeInMB(String filepath) {
    var file = File(filepath);
    int bytes = file.lengthSync();
    if (bytes <= 0) return 0.0;
    double sizeInMb = bytes / (1024 * 1024);
    return double.parse(sizeInMb.toStringAsFixed(2));
  }

  String getFileName(String filepath) {
    File file = File(filepath);
    String basename = file.path.split(Platform.pathSeparator).last;
    return basename;
  }

  String getFileExtension(String filepath) {
    return filepath.split('.').last;
  }

bool isEmoji(String char) {
  // A rough check for emoji characters
  return char.runes.any((rune) {
    return (rune >= 0x1F600 && rune <= 0x1F64F) || // Emoticons
           (rune >= 0x1F300 && rune <= 0x1F5FF) || // Misc Symbols and Pictographs
           (rune >= 0x1F680 && rune <= 0x1F6FF) || // Transport and Map Symbols
           (rune >= 0x1F700 && rune <= 0x1F77F) || // Alchemical Symbols
           (rune >= 0x1F780 && rune <= 0x1F7FF) || // Geometric Shapes Extended
           (rune >= 0x1F800 && rune <= 0x1F8FF) || // Supplemental Symbols and Pictographs
           (rune >= 0x1F900 && rune <= 0x1F9FF) || // Supplemental Symbols and Pictographs
           (rune >= 0x1FA00 && rune <= 0x1FA6F) || // Symbols and Pictographs Extended-A
           (rune >= 0x2600 && rune <= 0x26FF) ||   // Miscellaneous Symbols
           (rune >= 0x2700 && rune <= 0x27BF) ||   // Dingbats
           (rune >= 0x2300 && rune <= 0x23FF);     // Miscellaneous Technical
  });
}

String getFirstEmojiOrLetter(String input) {
  if (input.isEmpty) {
    return "#";
  }

  // Extract the first character (using Unicode grapheme clusters)
  String firstChar = input.characters.first;

  // Check if it's an emoji
  if (isEmoji(firstChar)) {
    return firstChar;
  } else {
    // Check if it's a letter
    return RegExp(r'[a-zA-Z]').hasMatch(firstChar) ? firstChar.toUpperCase() : "#";
  }
}

String? extractFirstSixDigits(String input) {
  RegExp regExp = RegExp(r'^\d{6}');
  Match? match = regExp.firstMatch(input);

  if (match != null) {
    return match.group(0);
  } else {
    return "";
  }
  // final RegExp regex = RegExp(r'^\d+');
  // final RegExpMatch? match = regex.firstMatch(input);
  //
  // if (match != null) {
  //   return match.group(0); // Returns the matched number as a string
  // } else {
  //   return null; // No match found
  // }
}

