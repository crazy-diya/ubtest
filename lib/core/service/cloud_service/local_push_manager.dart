// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:huawei_push/huawei_push.dart' as PushKit;

import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/utils/enums.dart';

class LocalNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
   final DeviceOS deviceOS;

  LocalNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    required this.deviceOS,
  });
}

class LocalPushManager {
  LocalPushManager._() {
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
      setupFlutterNotification();
    }
  }

  static LocalPushManager? _instance;

  static Future<LocalPushManager?> initialize() async {
    if (_instance == null) {
      _instance = LocalPushManager._();
      return _instance;
    } else {
      return _instance;
    }
  }

  static LocalPushManager? get instance => _instance;
  
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'ub_channel',
    'UB Notification Channel',
    description: 'Notification channel for UB clients',
    importance: Importance.max,
  );

  void setupFlutterNotification() async {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (details) {
        // navigatorKey.currentState?.pushNamed(Routes.routename);
      },
    );

    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidChannel);
    }

    if (Platform.isIOS) {
      NotificationSettings notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
      if (notificationSettings.authorizationStatus != AuthorizationStatus.authorized) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: true,
          sound: true,
          provisional: true,
        );
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    }
  }

  Future<void> showNotification(LocalNotification localNotification) async {
    if(localNotification.deviceOS == DeviceOS.ANDROID) {
      await _flutterLocalNotificationsPlugin.show(
        localNotification.id,
        localNotification.title,
        localNotification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            importance: _androidChannel.importance,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ));
    }else{
    await PushKit.Push.localNotification(<String, String>{
          PushKit.HMSLocalNotificationAttr.ID:localNotification.id.toString(),
          PushKit.HMSLocalNotificationAttr.TITLE:localNotification.title,
          PushKit.HMSLocalNotificationAttr.MESSAGE:localNotification.body,
        });
  }
  }
}
