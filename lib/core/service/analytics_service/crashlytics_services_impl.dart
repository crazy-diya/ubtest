// import 'package:agconnect_crash/agconnect_crash.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsServicesImpl {

  CrashlyticsServicesImpl();

  ///FIREBASE Development
  void crashlyticsFirebaseFlutterError() {
     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  void crashlyticsFirebase({required dynamic exception,required StackTrace stack,}) {
    FirebaseCrashlytics.instance.recordError(exception, stack, fatal: true);
  }

  

  ///HUAWEI Development
  // void crashlyticsHuaweiFlutterError()  {
  //   FlutterError.onError = AGCCrash.instance.onFlutterError;
  // }
  //
  // void crashlyticsHuawei({required dynamic exception,required StackTrace stack,}) {
  //     AGCCrash.instance.recordError(exception, stack, fatal: true);
  // }


  
}



