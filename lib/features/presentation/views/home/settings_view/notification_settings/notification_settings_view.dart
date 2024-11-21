import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../bloc/settings/settings_event.dart';
import '../../../../bloc/settings/settings_state.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/toast_widget/toast_widget.dart';
import '../../../base_view.dart';

class NotificationSettingsView extends BaseView {
  NotificationSettingsView({super.key});

  @override
  _NotificationSettingsViewState createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState
    extends BaseViewState<NotificationSettingsView> {
  var _bloc = injection<SettingsBloc>();

  bool bySms = false;
  bool byEmail = false;

  @override
  void initState() {
    _bloc.add(GetNotificationSettingsEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("notification_settings"),
        goBackEnabled: true,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (context) => _bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is GetNotificationSettingsSuccessState) {
              bySms = state.smsSettings ?? false;
              byEmail = state.emailSettings ?? false;
              setState(() {});
            } else if (state is GetNotificationSettingsFailedState) {
              ToastUtils.showCustomToast(
                  context,
                  AppLocalizations.of(context)
                      .translate("something_went_wrong"),
                  ToastStatus.FAIL);
            } else if (state is UpdateNotificationSettingsSuccessState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.SUCCESS);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context),),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: colors(context).whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context).translate(
                              "please_select_the_medias",
                            ),
                            style: size16weight400.copyWith(
                              color: colors(context).greyColor,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PhosphorIcon(
                              PhosphorIcons.chatText(PhosphorIconsStyle.bold),
                              color: colors(context).blackColor,
                            ),
                            8.horizontalSpace,
                            Text(AppLocalizations.of(context).translate("sms"),style: size16weight700.copyWith(color: colors(context).greyColor),),
                            Spacer(),
                            CupertinoSwitch(
                              value: bySms,
                              trackColor: colors(context).greyColor?.withOpacity(.65),
                                        activeColor:colors(context).primaryColor,
                              onChanged: (isChecked) {
                                setState(() {
                                  bySms = isChecked;
                                });
                                _bloc.add(UpdateNotificationSettingsEvent(
                                    notificationModeSms: bySms,
                                    notificationModeEmail: byEmail));
                              },
                            ),
                          ],
                        ),
                        16.verticalSpace,
                         Divider(
                           height: 0,thickness: 1,
                           color: colors(context).greyColor100,
                         ),
                          16.verticalSpace,
                        Row(
                          children: [
                            PhosphorIcon(
                              PhosphorIcons.envelopeSimple(
                                  PhosphorIconsStyle.bold),
                              color: colors(context).blackColor,
                            ),
                             8.horizontalSpace,
                            Text(AppLocalizations.of(context).translate("Email"),style: size16weight700.copyWith(color: colors(context).greyColor)),
                            Spacer(),
                            CupertinoSwitch(
                              value: byEmail,
                              trackColor: colors(context).greyColor?.withOpacity(.65),
                                        activeColor:colors(context).primaryColor,
                              onChanged: (isChecked) {
                                setState(() {
                                  byEmail = isChecked;
                                });
                                _bloc.add(UpdateNotificationSettingsEvent(
                                    notificationModeSms: bySms,
                                    notificationModeEmail: byEmail));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
