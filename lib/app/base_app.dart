import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/service/deep_linking_services.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_service.dart';

import '../../utils/app_constants.dart';
import '../../utils/navigation_routes.dart';
import '../utils/app_localizations.dart';

class UnionBankMobile extends ConsumerStatefulWidget {
  const UnionBankMobile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnionBankMobileState();
}

class _UnionBankMobileState extends ConsumerState<UnionBankMobile> {
  final DeepLinkHandler? _deepLinkHandler = injection<DeepLinkHandler>();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final appLocalizations = ref.watch(localeProvider);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.kSplashView,
          onGenerateRoute: Routes.generateRoute,
          navigatorKey: _deepLinkHandler?.navigatorKey,
          theme: ref.watch(themeProvider).themeData,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1),
            ),
            child: child!,
          ),
          supportedLocales: const [
            Locale(AppConstants.localeEN, "US"),
            Locale(AppConstants.localeSI, "LK"),
            Locale(AppConstants.localeTA, "TA"),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: appLocalizations.locale,
        );
      },
    );
  }
}