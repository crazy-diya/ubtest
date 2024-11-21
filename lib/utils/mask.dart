class Mask {
  String maskMobileNumber(String mobileNumber) {
    if (mobileNumber.startsWith('+94')) {
      final dialingCode = '+94';
      final digits = mobileNumber.substring(dialingCode.length);

      if (digits.length <= 4) {
        return dialingCode + ('*' * digits.length);
      } else {
        final start1 = mobileNumber.substring(0, 1);
        final start2 = mobileNumber.substring(1, 2);
        final end = digits.substring(digits.length - 2);
        final middle = '*' * (digits.length - 4);
        return '${dialingCode}${start1} ${start2}${middle}${end}';
      }
    } else {
      if(mobileNumber.startsWith("07")){
        mobileNumber = mobileNumber.replaceAll(RegExp('^0+'), '');
        if (mobileNumber.length <= 4) {
          return '*' * mobileNumber.length;
        } else {
          final start1 = mobileNumber.substring(0, 1);
          final start2 = mobileNumber.substring(1, 2);
          final end = mobileNumber.substring(mobileNumber.length - 2);
          final middle = '*' * (mobileNumber.length - 4);
          return '${start1} ${start2}${middle}${end}';
        }
      } else {
        final start = mobileNumber.substring(0, 4);
        final end = mobileNumber.substring(mobileNumber.length - 2);
        final middle = '*' * (mobileNumber.length - 6);
        return '${start}${middle}${end}';
      }
    }
  }

  // String maskMobileNumber(String mobileNumber) {
  //   RegExp pattern = new RegExp(r'^(\d{2})(\d{5})(\d{2})$');
  //
  //   Match match = pattern.firstMatch(mobileNumber)!;
  //   String areaCode = match.group(1)!;
  //   String prefix = match.group(2)!;
  //   String lineNumber = match.group(3)!;
  //
  //   String maskedPrefix = '*' * prefix.length;
  //
  //   return '$areaCode$maskedPrefix$lineNumber';
  // }
  // String maskEmailAddress(String emailAddress) {
  //   RegExp pattern = RegExp(r'^([^@]+)@(.+)$');
  //   Match match = pattern.firstMatch(emailAddress)!;
  //   String localPart = match.group(1)!;
  //   String domain = match.group(2)!;
  //   String maskedLocalPart = '';

  //   for (int i = 0; i < localPart.length; i++) {
  //     if (i < 1 || i == localPart.length - 1 || localPart[i] == '.') {
  //       maskedLocalPart += localPart[i];
  //     } else {
  //       maskedLocalPart += '*';
  //     }
  //   }

  //   return '$maskedLocalPart@$domain';
  // }

  String maskEmailAddress(String email) {
  // Regex to capture the email parts
  final emailRegex = RegExp(r'^(.)(.*)(.@.*)$');

  // Applying the regex to the input email
  final match = emailRegex.firstMatch(email);

  if (match != null) {
    // Getting the parts of the email
    final firstChar = match.group(1);
    final middlePart = match.group(2);
    final domainPart = match.group(3);

    // Masking the middle part
    final maskedMiddlePart = '*' * middlePart!.length;

    // Combining all parts to form the masked email
    return '$firstChar$maskedMiddlePart$domainPart';
  } else {
    // If the email does not match the regex, return the original email
    return email;
  }
}
}
