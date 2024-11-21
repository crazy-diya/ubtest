import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';

import '../../../widgets/app_button.dart';

import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../base_view.dart';
import '../data/fund_transfer_recipt_view_args.dart';
import '../widgets/fund_transfer_data_component.dart';

class OwnAcctNowPaymentFailView extends BaseView {
  final FundTransferReceiptViewArgs fundTransferReceiptViewArgs;

  OwnAcctNowPaymentFailView({required this.fundTransferReceiptViewArgs});

  @override
  _OwnAcctNowPaymentFailViewState createState() =>
      _OwnAcctNowPaymentFailViewState();
}

class _OwnAcctNowPaymentFailViewState
    extends BaseViewState<OwnAcctNowPaymentFailView> {
  var bloc = injection<SplashBloc>();
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.kHomeBaseView,
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          goBackEnabled: false,
          title: AppLocalizations.of(context).translate("fund_transfer_status"),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Column(
                              children: [
                                24.verticalSpace,
                                CommonStatusIcon(
                                  backGroundColor:
                                      colors(context).negativeColor!,
                                  icon: PhosphorIcons.warning(),
                                  iconColor: colors(context).whiteColor,
                                ),
                                16.verticalSpace,
                                if (widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.OWNNOW ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.NEWNOW ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.SAVEDNOW)
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate("fund_transfer_was_fail"),
                                      style: size18weight700.copyWith(
                                          color: colors(context).blackColor)),
                                if (widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.OWNLATER ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.OWNRECUURING ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.SAVEDLATER ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.SAVEDRECURRING ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.NEWRECURRING ||
                                    widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.ftRouteType ==
                                        FtRouteType.NEWLATER)
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate("schedule_failed"),
                                      style: size18weight700.copyWith(
                                          color: colors(context).blackColor)),
                                4.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.only(left: 16 , right: 16),
                                  child: Text(
                                      widget.fundTransferReceiptViewArgs
                                              .message ??
                                          AppLocalizations.of(context).translate("something_went_wrong"),
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                                16.verticalSpace,
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate("lkr"),
                                        style: size20weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        '${widget.fundTransferReceiptViewArgs.fundTransferEntity.amount!.toString().withThousandSeparator()}',
                                        style: size20weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  widget.fundTransferReceiptViewArgs
                                          .fundTransferEntity.bankName ??
                                      "${widget.fundTransferReceiptViewArgs.fundTransferEntity.bankCode == AppConstants.ubBankCode ? AppConstants.unionBankTitle : ""}",
                                  style: size14weight700.copyWith(
                                      color: colors(context).primaryColor),
                                ),
                                24.verticalSpace,
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0.w , right: 16.w),
                              child: Column(
                                children: [
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("paid_from"),
                                    data: widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.payFromName ??
                                        "-",
                                    subData: widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.payFromNum ??
                                        "0",
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("pay_to"),
                                    data: widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.payToacctname ??
                                        "-",
                                    subData: widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.payToacctnmbr ??
                                        "0",
                                  ),
                                  // FTSummeryDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("amount"),
                                  //   amount: widget.fundTransferReceiptViewArgs.fundTransferEntity.amount ?? 0,
                                  //   isCurrency: true,
                                  // ),
                                  // FTSummeryDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("transaction_category"),
                                  //   data: widget.fundTransferReceiptViewArgs.fundTransferEntity.transactionCategory ?? "no category",
                                  // ),
                                  // FTSummeryDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("beneficiary_mobile_no"),
                                  //   data: widget.fundTransferReceiptViewArgs.fundTransferEntity.beneficiaryMobile ?? "no mobile",
                                  // ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("date_&_time"),
                                    data:
                                        "${DateFormat('dd-MMMM-yyyy | hh:mm a').format(dateTime)}",
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("reference_number"),
                                    isLastItem: true,
                                    data: widget.fundTransferReceiptViewArgs
                                            .fundTransferEntity.reference ??
                                        "-",
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w,
                  20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  AppButton(
                      buttonText: AppLocalizations.of(context)
                          .translate("back_to_home"),
                      onTapButton: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kHomeBaseView,
                          (route) => false,
                        );
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,Routes.kFundTransferNewView,
                        //   arguments: RequestMoneyValues(),
                        //       (Route<dynamic> route) => route.settings.name == widget.fundTransferReceiptViewArgs.fundTransferEntity.route,
                        // );
                      }),
                  // 1.9.verticalSpace,
                  // AppButton(
                  //   buttonType: ButtonType.OUTLINEENABLED,
                  //   buttonColor: Colors.transparent,
                  //   buttonText: AppLocalizations.of(context).translate("home"),
                  //   onTapButton: () {
                  //     Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
