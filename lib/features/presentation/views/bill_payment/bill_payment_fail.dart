// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../utils/app_sizer.dart';
import '../../widgets/app_button.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../base_view.dart';
import '../schedule/schedule_bill_payment/widgets/schedule_bill_payment_data_component.dart';

class BillStatusFailArgs {
  final BPRouteType? bpRouteType;
  final String? message;
  final String? payFromName;
  final String? payFromNumber;
  final String? payToNumber;
  final String? payToName;
  final String? date;
  final String? refId;
  final String route;
  final String? amount;

  BillStatusFailArgs({
    this.bpRouteType,
    this.message,
    this.payFromName,
    this.payFromNumber,
    this.payToNumber,
    this.payToName,
    this.date,
    this.refId,
    required this.route,
    this.amount,
  });
}

class BillPaymentFailView extends BaseView {
  final BillStatusFailArgs? billStatusFailArgs;

  BillPaymentFailView({this.billStatusFailArgs});

  @override
  _UnSavedPayeeLaterPaymentFailViewState createState() =>
      _UnSavedPayeeLaterPaymentFailViewState();
}

class _UnSavedPayeeLaterPaymentFailViewState
    extends BaseViewState<BillPaymentFailView> {
  var bloc = injection<SplashBloc>();
  String? date;

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.kHomeBaseView,
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: colors(context).primaryColor50,
          appBar: UBAppBar(
            title:
                AppLocalizations.of(context).translate("bill_payment_status"),
            onBackPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.kHomeBaseView,
                (Route<dynamic> route) => false,
              );
            },
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(
                20.w,
                24.h,
                20.w,
                20.h + AppSizer.getHomeIndicatorStatus(context),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding: const EdgeInsets.all(24).w,
                              child: Column(
                                children: [
                                  CommonStatusIcon(
                                    backGroundColor:
                                        colors(context).negativeColor!,
                                    icon: PhosphorIcons.warning(
                                        PhosphorIconsStyle.bold),
                                    iconColor: colors(context).whiteColor,
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    widget.billStatusFailArgs?.bpRouteType ==
                                            BPRouteType.NOW
                                        ? AppLocalizations.of(context)
                                            .translate(
                                                "bill_was_payment_failed")
                                        : AppLocalizations.of(context)
                                            .translate("schedule_was_failed"),
                                    style: size18weight700.copyWith(
                                        color: colors(context).blackColor),
                                  ),
                                  8.verticalSpace,
                                  Padding(
                                    padding: EdgeInsets.only(left: 16 , right: 16),
                                    child: Text(
                                      widget.billStatusFailArgs?.message ?? "-",
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "${AppLocalizations.of(context).translate("lkr")} ${widget.billStatusFailArgs?.amount.toString().withThousandSeparator()}",
                                    style: size24weight700.copyWith(
                                        color: colors(context).primaryColor),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    widget.billStatusFailArgs?.payToName ?? "",
                                    style: size16weight700.copyWith(
                                        color: colors(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 0, 16, 16).w,
                              child: Column(
                                children: [
                                  BillPaymentDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("pay_to"),
                                    data:
                                        widget.billStatusFailArgs!.payToName ??
                                            "-",
                                    subData: widget
                                            .billStatusFailArgs!.payToNumber ??
                                        "-",
                                  ),
                                  BillPaymentDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("paid_from"),
                                    data: widget
                                            .billStatusFailArgs!.payFromName ??
                                        "-",
                                    subData: widget
                                            .billStatusFailArgs!.payFromNumber??
                                        "-",
                                  ),
                                  BillPaymentDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("date_&_time"),
                                    data: DateFormat("dd-MMM-yyyy | hh:mm a")
                                            .format(DateTime.parse(widget
                                                .billStatusFailArgs!.date!)),
                                  ),
                                  BillPaymentDataComponent(
                                    isLastItem: true,
                                    title: AppLocalizations.of(context)
                                        .translate("reference_number"),
                                    data: widget.billStatusFailArgs?.refId !=
                                                null &&
                                            widget.billStatusFailArgs?.refId !=
                                                ""
                                        ? "${widget.billStatusFailArgs?.refId!}"
                                        : "-",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppSizer.verticalSpacing(
                              AppSizer.getHomeIndicatorStatus(context)),
                        ],
                      ),
                    ),
                  ),
                  AppButton(
                      buttonText: AppLocalizations.of(context)
                          .translate("back_to_home"),
                      onTapButton: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kHomeBaseView,
                          (Route<dynamic> route) => false,
                        );
                      })
                ],
              ))),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
