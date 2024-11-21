

import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

class DeepLinkHandler {
  AppLinks? _appLinks;
  DeepLinkHandler(
      {AppLinks? appLinks}) {
    _appLinks = appLinks;

  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription<Uri>? _sub;


  

  Future appLinkInitial() async {
    // final isLanguage = await _secureStorage?.hasData(SELECTED_LANGUAGE);
    // Check initial link if app was in cold state (terminated)
    // if(isLanguage == true){
     // if(isLanguage == true){
    //   final appLink = await _appLinks?.getInitialLink();
    //   if (appLink != null) {
    //   if (appLink.path == '/admin-reset') {
    //     await navigatorKey.currentState?.pushNamed( Routes.kResetPasswordTemporyView,arguments: appLink.query);
    //   return;
    //   }
      
    // }

    // Handle link when app is in warm state (front or background)
    reset();
   _sub = _appLinks?.uriLinkStream.listen(
      (uriValue) {
        if (uriValue.path.isNotEmpty) {
        if (uriValue.path == '/admin-reset') {
         navigatorKey.currentState?.pushNamed(Routes.kResetPasswordTemporyView,arguments: uriValue.query);
         return;
        }

        if (AppConstants.IS_USER_LOGGED) {
          if (uriValue.path == '/security-question-reset') {
            //  navigatorKey.currentState?.pushNamed(Routes.kRatesView);
            return;
          }
        }
      }
      },
      onError: (err) {
        log('====>>> error : $err');
      },
    );
    //.........................................................

    // }
    
  }

 void reset() {
    _sub?.cancel();
  }
}


