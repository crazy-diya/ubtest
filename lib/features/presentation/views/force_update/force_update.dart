import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/enums.dart';

class ForceUpdateView extends BaseView {
 final bool isForceUpdate;
  ForceUpdateView( {super.key,required this.isForceUpdate,});

  @override
  _ForceUpdateViewState createState() => _ForceUpdateViewState();
}

class _ForceUpdateViewState extends BaseViewState<ForceUpdateView> {
  final SplashBloc _bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        goBackEnabled: false,
        title: AppLocalizations.of(context).translate("new_version"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h+ AppSizer.getHomeIndicatorStatus(context)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AppAssets.appNewUpdate,
                          width: 248.16.w,
                        ),
                      ),
                      28.verticalSpace,
                      Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("new_update"),
                              textAlign: TextAlign.center,
                          style: size16weight400.copyWith(color: colors(context).greyColor) ),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                20.verticalSpace,
                AppButton(
                    buttonType: ButtonType.PRIMARYENABLED,
                    buttonText: AppLocalizations.of(context)
                        .translate("update_now"),
                    onTapButton: () {

                      if(Platform.isIOS){
                        _launchAppStore("https://apps.apple.com/id/app/ubgo/id1168612887");
                      }else if(Platform.isAndroid){
                        if(AppConfig.deviceOS ==DeviceOS.HUAWEI){
                           _launchAppStore("");

                        }else if(AppConfig.deviceOS ==DeviceOS.ANDROID){
                           _launchAppStore("https://play.google.com/store/apps/details?id=com.epic.ubmobilebank&hl=en");

                        }
                      }
                    
                    }),
                 if(!widget.isForceUpdate)...[ 16.verticalSpace,
                  AppButton(
                    buttonType: ButtonType.OUTLINEENABLED,
                    buttonText: AppLocalizations.of(context)
                        .translate("cancel"),
                    onTapButton: () {
                      Navigator.pop(context);
                    
                    }),]
              ],
            ),
          ],
        ),
      ),
    );
  }


   _launchAppStore(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Cannot direct to $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
