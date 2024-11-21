import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../base_view.dart';
import '../schedule/schedule_bill_payment/widgets/schedule_bill_payment_data_component.dart';

class QRPaymentFailArgs {
  String? amount;
  String? remark;
  String? payFromName;
  String? payToName;
  String? payFromNum;
  String? payToNum;
  String? dateTime;
  String? refNum;
  double? serviceCharge;
  final String? route;
  String? failReason;

  QRPaymentFailArgs(
      {this.remark,
      this.amount,
      this.payFromNum,
      this.payFromName,
      this.dateTime,
      this.payToName,
      this.payToNum,
      this.refNum,
      this.serviceCharge,
      this.route,
      this.failReason});
}

class QRPaymentFailStatusView extends BaseView {
  final QRPaymentFailArgs? qrPaymentFailArgs;

  QRPaymentFailStatusView({this.qrPaymentFailArgs});

  @override
  _QRPaymentFailStatusViewState createState() =>
      _QRPaymentFailStatusViewState();
}

class _QRPaymentFailStatusViewState
    extends BaseViewState<QRPaymentFailStatusView> {
  var _bloc = injection<SplashBloc>();

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
            title: AppLocalizations.of(context).translate("transaction_status"),
            onBackPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.kHomeBaseView,
                (Route<dynamic> route) => false,
              );
            },
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(20.w,0,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              24.verticalSpace,
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
                                        AppLocalizations.of(context)
                                            .translate("qr_payment_failed"),
                                        style: size18weight700.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                      8.verticalSpace,
                                      Padding(
                                        padding: EdgeInsets.only(left: 16 , right: 16),
                                        child: Text(
                                          widget.qrPaymentFailArgs?.failReason ??
                                              "-",
                                          style: size14weight400.copyWith(
                                              color: colors(context).greyColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("lkr")} ${widget.qrPaymentFailArgs!.amount!.toString().withThousandSeparator()}",
                                        style: size24weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        widget.qrPaymentFailArgs?.payToName ??
                                            "-",
                                        style: size16weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
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
                                  padding: const EdgeInsets.fromLTRB(16,0,16,16).w,
                                  child: Column(
                                    children: [
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("paid_from"),
                                        data: widget.qrPaymentFailArgs!
                                                .payFromName ??
                                            "-",
                                        subData: widget
                                                .qrPaymentFailArgs!.payFromNum??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("pay_to"),
                                        data: widget
                                                .qrPaymentFailArgs!.payToName ??
                                            "-",
                                        subData: widget
                                                .qrPaymentFailArgs!.payToNum ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("date_&_time"),
                                        data: widget.qrPaymentFailArgs
                                                    ?.dateTime !=
                                                null
                                            ? DateFormat(
                                                    'dd-MMM-yyyy | hh:mm a')
                                                .format(
                                                DateTime.parse(widget
                                                        .qrPaymentFailArgs
                                                        ?.dateTime ??
                                                    DateTime.now()
                                                        .toString()
                                                        .toString()),
                                              )
                                            : "-",
                                      ),
                                      BillPaymentDataComponent(
                                        isLastItem: true,
                                        title: AppLocalizations.of(context)
                                            .translate("reference_number"),
                                        data: "-",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))),
                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                          buttonText: AppLocalizations.of(context)
                              .translate("back_to_home"),
                          onTapButton: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.kHomeBaseView,
                              (Route<dynamic> route) => false,
                            );
                          }),
                    ],
                  )
                ],
              ))),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
