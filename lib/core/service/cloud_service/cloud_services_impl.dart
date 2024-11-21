import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:huawei_push/huawei_push.dart';

import '../../../features/data/datasources/local_data_source.dart';
import '../../../utils/enums.dart';
import '../../configurations/app_config.dart';

class CloudServicesImpl {
  final LocalDataSource _appSharedData;
  late FirebaseMessaging _firebaseMessaging;

  CloudServicesImpl(this._appSharedData) {
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
      _firebaseMessaging = FirebaseMessaging.instance;
    }
  }

  ///FCM Development

  Future<bool?> getFCMToken() async {
    // await FirebaseMessaging.instance.requestPermission();
    const int maxRetries = 3;
    int retryCount = 0;

  try {
    _firebaseMessaging = FirebaseMessaging.instance;

    if (Platform.isIOS) {
      String? apnsToken;
      while (apnsToken == null && retryCount < maxRetries) {
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          retryCount++;
          await Future.delayed(Duration(seconds: 2)); 
        }
      }

      if (apnsToken == null) {
        log("Failed to fetch APNs token after $retryCount retries");
        return false;
      }
    }

      String? token = await _firebaseMessaging.getToken();
      if (kDebugMode) {
      log("PUSH TOKEN ######################################################### $token");
      }
      if (token != null && token.isNotEmpty) {
        _appSharedData.setPushToken(token); // You want to add PUSH Token here
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  subscribeFCMTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  unsubscribeFCMTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  /// HCM Development
  Future<bool?> getHCMToken() async {
    try {
      Push.getToken('');
      final token = await Push.getTokenStream.first;
      if (kDebugMode) {
         log("PUSH KIT TOKEN ######################################################### $token");
      }
      if (token.isNotEmpty) {
        log(token);
        _appSharedData.setPushToken(token); // You want to add PUSH Token here
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  subscribeHCMTopic(String topic) {
    Push.subscribe(topic);
  }

  unsubscribeHCMTopic(String topic) {
    Push.unsubscribe(topic);
  }
}
