import 'package:union_bank_mobile/core/service/analytics_service/crashlytics_services_impl.dart';

import '../../../utils/enums.dart';
import '../../configurations/app_config.dart';
import 'analytics_services_impl.dart';

class AnalyticsServices {
  AnalyticsServices._();

  static AnalyticsServices? _instance;

  static Future<AnalyticsServices?> initialize() async {
    if (_instance == null) {
      _instance = AnalyticsServices._();
      return _instance;
    } else {
      return _instance;
    }
  }

  static AnalyticsServices? get instance => _instance;

  final AnalyticsServicesImpl _analyticsServicesImpl = AnalyticsServicesImpl();
  final CrashlyticsServicesImpl _crashlyticsServicesImpl = CrashlyticsServicesImpl();

  /* ---------------------------- ANALYTICS EVENTS ---------------------------- */

  // Signup event
  Future<void>? analyticsSignup({required String userType}) async {
    if (AppConfig.isAnalyticsEnable) {
      if (AppConfig.deviceOS == DeviceOS.ANDROID) {
        await _analyticsServicesImpl.analyticsSignupFirebase(
            userType: userType);
      } else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
        await _analyticsServicesImpl.analyticsSignupHuawei(userType: userType);
      }
    }
  }

  // Login event
  Future<void>? analyticsLogin({required String loginType}) async {
    if (AppConfig.isAnalyticsEnable) {
      if (AppConfig.deviceOS == DeviceOS.ANDROID) {
        await _analyticsServicesImpl.analyticsLoginFirebase(
            loginType: loginType);
      } else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
        await _analyticsServicesImpl.analyticsLoginHuawei(loginType: loginType);
      }
    }
  }

  // User language event
  Future<void>? analyticsUserLanguage({required String language}) async {
    if (AppConfig.isAnalyticsEnable) {
      if (AppConfig.deviceOS == DeviceOS.ANDROID) {
        await _analyticsServicesImpl.analyticsUserLanguageFirebase(language: language);
      } else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
        await _analyticsServicesImpl.analyticsUserLanguageHuawei(language: language);
      }
    }
  }

  /* ------------------------------------ . ----------------------------------- */


  /* --------------------------- CRASHLYTICS EVENTS --------------------------- */

    void crashlyticsFlutterError()  {
     if (AppConfig.isCrashlyticsEnable) {
      if (AppConfig.deviceOS == DeviceOS.ANDROID) {
        _crashlyticsServicesImpl.crashlyticsFirebaseFlutterError();
      }
      // else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
      //   _crashlyticsServicesImpl.crashlyticsHuaweiFlutterError();
      // }
    }
  }

  void crashlytics({required dynamic exception,required StackTrace stack,}) {
     if (AppConfig.isCrashlyticsEnable) {
      if (AppConfig.deviceOS == DeviceOS.ANDROID) {
       _crashlyticsServicesImpl.crashlyticsFirebase(exception: exception, stack: stack);
      }
      // else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
      //   _crashlyticsServicesImpl.crashlyticsHuawei(exception: exception, stack: stack);
      // }
    }
  }
  

  /* ------------------------------------ . ----------------------------------- */
}
