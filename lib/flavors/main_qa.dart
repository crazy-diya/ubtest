import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huawei_push/huawei_push.dart' as PushKit;
import 'package:union_bank_mobile/core/network/http_override.dart';
import 'package:union_bank_mobile/core/service/analytics_service/analytics_services.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:union_bank_mobile/core/service/cloud_service/local_push_manager.dart';

import '../app/base_app.dart';
import '../core/configurations/app_config.dart';
import '../core/service/platform_services.dart';
import '../utils/enums.dart';
import 'flavor_config.dart';
import '../core/service/dependency_injection.dart' as di;


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  dev.log(message?.notification?.body??"");
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  if (message?.notification == null) {
  await LocalPushManager.initialize();
  await LocalPushManager.instance?.showNotification(LocalNotification(
          id: message.hashCode,
          title: message?.data["title"] ?? "",
          body:message?.data["body"] ?? "", deviceOS: DeviceOS.ANDROID,),);
  }

}

@pragma('vm:entry-point')
Future<void> _huaweiMessagingBackgroundHandler(PushKit.RemoteMessage message) async {
 final data = jsonDecode(message.data??"{}") as Map<String,dynamic>;
 await LocalPushManager.initialize();
 await LocalPushManager.instance?.showNotification(LocalNotification(
    id: message.hashCode,
    title: message.notification?.title ?? data["title"] ?? "",
    body:  message.notification?.body ?? data["body"] ?? "", deviceOS: DeviceOS.HUAWEI,),);
}

Future<void> main() async {

  runZonedGuarded(
    () async {
        FlavorConfig(
      flavor: Flavor.QA,
      color: Colors.deepOrange,
      flavorValues: FlavorValues());

        WidgetsFlutterBinding.ensureInitialized();
        if(AppConfig.isHttpOverride) HttpOverrides.global = new MyHttpOverrides();
        if(AppConfig.isScreenShotDisable) PlatformServices.screenShotDisable();


    await LocalPushManager.initialize();
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
        await Firebase.initializeApp();
        try {
          FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        } catch (e) {
          dev.log('Firebase : ${e.toString()}');
        }
      } else {
        PushKit.Push.registerBackgroundMessageHandler( _huaweiMessagingBackgroundHandler);
      }

    await di.setupLocator();
    await AnalyticsServices.initialize();

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    
    AnalyticsServices.instance?.crashlyticsFlutterError();
    runApp(const ProviderScope(child: UnionBankMobile()));
      

    }, (exception, stackTrace) async {
       AnalyticsServices.instance?.crashlytics(exception: exception, stack: stackTrace);
    } 
  );
}
