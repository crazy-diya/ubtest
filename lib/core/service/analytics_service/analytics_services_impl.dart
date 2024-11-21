import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:huawei_analytics/huawei_analytics.dart';

import '../../../utils/enums.dart';
import '../../configurations/app_config.dart';

class AnalyticsServicesImpl {
  AnalyticsServicesImpl() {
    _init();
  }

  late FirebaseAnalytics _firebaseAnalytics;
  // late HMSAnalytics _hmsAnalytics;

  void _init() async {
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
      _firebaseAnalytics = FirebaseAnalytics.instance;
    } else if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
      // _hmsAnalytics = await HMSAnalytics.getInstance();
    }
  }

  ///FIREBASE Development
  // Signup event
  Future<void>? analyticsSignupFirebase({required String userType}) async =>
      await _firebaseAnalytics
          .logEvent(name: 'RegularSignupEvent', parameters: {
        "SignupEvent": "SingupEvent",
        "UserType": userType,
      });
  // Login event
  Future<void>? analyticsLoginFirebase({required String loginType}) async =>
      await _firebaseAnalytics.logEvent(
          name: 'RegularLoginEvent',
          parameters: {"LoginEvent": "LoginEvent", "LoginType": loginType});

  // User language event
  Future<void>? analyticsUserLanguageFirebase(
          {required String language}) async =>
      await _firebaseAnalytics
          .logEvent(name: 'UserLanguage', parameters: {"language": language});

  ///HUAWEI Development
  // Signup event
  Future<void>? analyticsSignupHuawei({required String userType}) async {
    // await _hmsAnalytics.onEvent('RegularSignupEvent', {
    //   "SignupEvent": "SingupEvent",
    //   "UserType": userType,
    // }
    // );
  }

  // Login event
  Future<void>? analyticsLoginHuawei({required String loginType}) async {
    // await _hmsAnalytics.onEvent('RegularLoginEvent',
    //     {"LoginEvent": "LoginEvent", "LoginType": loginType});
  }


  // User language event
  Future<void>? analyticsUserLanguageHuawei({required String language}) async {
    // await _hmsAnalytics.onEvent('UserLanguage', {"language": language});
  }
}
