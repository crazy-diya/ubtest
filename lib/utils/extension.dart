import 'dart:convert';

import 'package:flutter/animation.dart';

import 'enums.dart';

extension APIDeviceOS on DeviceOS{
  String getType(){
    switch(this){
      case DeviceOS.ANDROID:
        return 'Android';
      case DeviceOS.HUAWEI:
        return 'HUAWEI';
    }
  }
}

extension Base64Convert on String{
  String toBase64(){
    final str = this;
    final bytes = utf8.encode(str);
    final base64Str = base64.encode(bytes);
    return base64Str;
  }

  String base64ToString(){
    final base64Str = this;
    final bytes = base64.decode(base64Str);
    final str = utf8.decode(bytes);
    return str;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension DoubleSCF on double {
  Tween<double> tweenTo(double end) {
    return Tween<double>(begin: this, end: end);
  }
}

extension IntSC on int {
  Duration get seconds {
    return Duration(seconds: this);
  }

  Duration get milliseconds {
    return Duration(milliseconds: this);
  }
}

extension StringSC on String {
    int? toInt({int radix = 10}) {
    try {
      return int.parse(this, radix: radix);
    } catch (error) {
      return null;
    }
  }
}
