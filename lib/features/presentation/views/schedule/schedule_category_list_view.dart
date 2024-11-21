import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../base_view.dart';

class ScheduleCategoryListView extends BaseView {
  @override
  _ScheduleCategoryListViewState createState() =>
      _ScheduleCategoryListViewState();
}

class _ScheduleCategoryListViewState
    extends BaseViewState<ScheduleCategoryListView> {
  var bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("schedules"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kFundTransferSchedulingView);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 64.h,
                                  width: 64.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                      border: Border.all(
                                          color: colors(context).greyColor300 ?? Colors.black // Border width
                                      )
                                  ),
                                  child: PhosphorIcon(PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold),
                                  color: colors(context).primaryColor,
                                  ),
                                ),
                                24.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context).translate("fund_transfer"),
                                  style: size16weight700.copyWith(color: colors(context).blackColor),
                                ),
                                const Spacer(),
                                PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                color: colors(context).greyColor300,
                                )
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          Divider(
                            thickness: 1,
                            color: colors(context).greyColor100,
                            height: 0,
                          ),
                          16.verticalSpace,
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kScheduleBillPaymentView);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 64.h,
                                  width: 64.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                      border: Border.all(
                                          color: colors(context).greyColor300 ?? Colors.black // Border width
                                      )
                                  ),
                                  child: PhosphorIcon(PhosphorIcons.fileText(PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                ),
                                24.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context).translate("bill_payment"),
                                  style: size16weight700.copyWith(color: colors(context).blackColor),
                                ),
                                const Spacer(),
                                PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
