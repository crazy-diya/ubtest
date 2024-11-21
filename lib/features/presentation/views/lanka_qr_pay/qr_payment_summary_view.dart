import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/lanka_qr_pay/qrPayment_status_fail_view.dart';
import 'package:union_bank_mobile/features/presentation/views/lanka_qr_pay/qrPayment_status_success_view.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/common/lanka_qr_payload.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../base_view.dart';
import 'widgets/qr_payment_summary_component.dart';
import '../otp/otp_view.dart';

class QRPaymentSuummaryArgs {
  final List<AccountEntity> accountList;
  LankaQrPayload? lankaQrPayload;
  double amount;
  String? remark;
  String? payFromName;
  String? payFromNum;
  String? instrumentId;
  String? refnumber;
  String beforeTrans;
  double? serviceCharge;
  final String? route;

  QRPaymentSuummaryArgs({
    this.lankaQrPayload,
    required this.accountList,
    required this.amount,
    this.remark,
    this.payFromName,
    this.payFromNum,
    this.instrumentId,
    this.refnumber,
    required this.beforeTrans,
    this.serviceCharge,
    this.route,
  });
}

class QRPaymentSummary extends BaseView {
  final QRPaymentSuummaryArgs? qrPaymentSuummaryArgs;

  QRPaymentSummary({this.qrPaymentSuummaryArgs});

  @override
  _QRPaymentSummaryState createState() => _QRPaymentSummaryState();
}

class _QRPaymentSummaryState extends BaseViewState<QRPaymentSummary> {
  var _bloc = injection<AccountBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("qr_payment_summary"),
      ),
      body: BlocProvider<AccountBloc>(
        create: (_) => _bloc,
        child: BlocListener<AccountBloc, BaseState<AccountState>>(
          listener: (_, state) {
            if (state is QRPaymentSuccessState) {
              Navigator.pushNamed(
                context,
                Routes.kQRPaymentSuccessStatusView,
                arguments: QRPaymentSuccessArgs(
                    route: widget.qrPaymentSuummaryArgs!.route,
                    amount:
                        widget.qrPaymentSuummaryArgs!.amount.toString() ?? "",
                    remark: widget.qrPaymentSuummaryArgs!.remark ?? "",
                    instrumentId: widget.qrPaymentSuummaryArgs!.instrumentId,
                    payFromNum: widget.qrPaymentSuummaryArgs!.payFromNum,
                    payFromName: widget.qrPaymentSuummaryArgs!.payFromName,
                    payToName: widget.qrPaymentSuummaryArgs!.lankaQrPayload!
                            .merchantName ??
                        "",
                    payToNum: widget.qrPaymentSuummaryArgs!.lankaQrPayload!
                            .merchantCity ??
                        "",
                    dateTime: state.qrPaymentResponse?.date,
                    refNum: state.qrPaymentResponse?.referenceNo ??
                        widget.qrPaymentSuummaryArgs!.refnumber,
                    txnAmount: state.qrPaymentResponse!.txnAmount,
                    transactionId: state.qrPaymentResponse?.transactionId,
                    serviceCharge: widget.qrPaymentSuummaryArgs!.serviceCharge),
              );
            } else if (state is QRPaymentFailState) {
              Navigator.pushNamed(
                context,
                Routes.kQRPaymentFailStatusView,
                arguments: QRPaymentFailArgs(
                    failReason: state.errorMessage,
                    route: widget.qrPaymentSuummaryArgs!.route,
                    amount:
                        widget.qrPaymentSuummaryArgs!.amount.toString() ?? "",
                    remark: widget.qrPaymentSuummaryArgs?.remark,
                    payFromNum: widget.qrPaymentSuummaryArgs!.payFromNum,
                    payFromName: widget.qrPaymentSuummaryArgs!.payFromName,
                    payToName: widget.qrPaymentSuummaryArgs!.lankaQrPayload!
                            .merchantName ??
                        "",
                    payToNum: widget.qrPaymentSuummaryArgs!.lankaQrPayload!
                            .merchantCity ??
                        "",
                    dateTime: state.qrPaymentResponse?.date,
                    refNum: state.qrPaymentResponse?.referenceNo ??
                        widget.qrPaymentSuummaryArgs!.refnumber,
                    serviceCharge: widget.qrPaymentSuummaryArgs!.serviceCharge),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context),),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        24.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                              color: colors(context).whiteColor,
                              borderRadius: BorderRadius.circular(8).r),
                          child: Padding(
                            padding: const EdgeInsets.all(16).w,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colors(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8).r),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 24.h, horizontal: 20.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).translate("lkr")} ${widget.qrPaymentSuummaryArgs!.beforeTrans.toString().withThousandSeparator()}",
                                            style: size14weight700.copyWith(
                                                color:
                                                    colors(context).whiteColor),
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "balance_before_transfer"),
                                            style: size12weight400.copyWith(
                                                color:
                                                    colors(context).whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 40.h,
                                      color: colors(context).primaryColor300,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).translate("lkr")} ${(double.parse(widget.qrPaymentSuummaryArgs!.beforeTrans) - (widget.qrPaymentSuummaryArgs!.amount + widget.qrPaymentSuummaryArgs!.serviceCharge!)).toString().withThousandSeparator()}",
                                            style: size14weight700.copyWith(
                                                color:
                                                    colors(context).whiteColor),
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "balance_after_transfer"),
                                            style: size12weight400.copyWith(
                                                color:
                                                    colors(context).whiteColor),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                              color: colors(context).whiteColor,
                              borderRadius: BorderRadius.circular(8).r),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16).w,
                            child: Column(
                              children: [
                                QRPaymentSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("paid_from"),
                                  data: widget
                                          .qrPaymentSuummaryArgs!.payFromName ??
                                      "-",
                                  subData: widget
                                          .qrPaymentSuummaryArgs!.payFromNum ??
                                      "-",
                                ),
                                QRPaymentSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("Pay_To"),
                                  data: widget.qrPaymentSuummaryArgs!
                                          .lankaQrPayload!.merchantName ??
                                      "-",
                                  subData: widget.qrPaymentSuummaryArgs!
                                          .lankaQrPayload!.merchantCity ??
                                      "-",
                                ),
                                QRPaymentSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("amount"),
                                  isCurrency: true,
                                  amount: widget.qrPaymentSuummaryArgs!.amount
                                      .toString()
                                      .withThousandSeparator(),
                                ),
                                QRPaymentSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("remarks"),
                                  data: widget.qrPaymentSuummaryArgs?.remark ==
                                              null ||
                                          widget.qrPaymentSuummaryArgs
                                                  ?.remark ==
                                              ""
                                      ? "-"
                                      : widget.qrPaymentSuummaryArgs!.remark!,
                                ),
                                QRPaymentSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("transaction_date"),
                                    data: DateFormat('dd-MMM-yyyy')
                                        .format(DateTime.now())),
                                QRPaymentSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("reference_number"),
                                  data:
                                      widget.qrPaymentSuummaryArgs!.refnumber ??
                                          widget.qrPaymentSuummaryArgs!
                                              .lankaQrPayload!.referenceId!,
                                  //subData: "4865 2563 2056",
                                ),
                                QRPaymentSummeryDataComponent(
                                  isLastItem: true,
                                  title: AppLocalizations.of(context)
                                      .translate("service_charge"),
                                  isCurrency: true,
                                  amount: widget
                                      .qrPaymentSuummaryArgs!.serviceCharge
                                      .toString()
                                      .withThousandSeparator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        Navigator.pushNamed(context, Routes.kOtpView,
                            arguments: OTPViewArgs(
                              phoneNumber:
                                  AppConstants.profileData.mobileNo.toString(),
                              appBarTitle: 'otp_verification',
                              requestOTP: true,

                              ///todo: change the OTP type
                              otpType: kFundTransOTPType,
                            )).then((value) {
                          if (value != null) {
                            if (value == true) {
                              _bloc.add(QRPaymentEvent(
                                txnAmount: widget.qrPaymentSuummaryArgs?.amount
                                    .toString(),
                                tidNo: (widget.qrPaymentSuummaryArgs
                                                ?.lankaQrPayload?.terminalId ==
                                            "" ||
                                        widget.qrPaymentSuummaryArgs
                                                ?.lankaQrPayload?.terminalId ==
                                            null)
                                    ? "0000"
                                    : widget.qrPaymentSuummaryArgs
                                        ?.lankaQrPayload?.terminalId,
                                lankaQRcode: widget.qrPaymentSuummaryArgs!
                                    .lankaQrPayload!.qrMaiData,
                                // paymentToken: widget.qrPaymentSuummaryArgs!.lankaQrPayload!.storeId,
                                mcc: widget.qrPaymentSuummaryArgs!
                                    .lankaQrPayload!.merchantCategoryCode,
                                instrumentId:
                                    widget.qrPaymentSuummaryArgs!.instrumentId,
                                remarks: widget.qrPaymentSuummaryArgs!.remark,
                                referenceNo:
                                    widget.qrPaymentSuummaryArgs!.refnumber,
                                merchantAccountNumber: widget
                                    .qrPaymentSuummaryArgs!
                                    .lankaQrPayload!
                                    .qrMaiData,
                                merchantName: widget.qrPaymentSuummaryArgs!
                                    .lankaQrPayload!.merchantName,
                              ));
                            }
                          }
                        });
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonColor: Colors.transparent,
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                          title: AppLocalizations.of(context)
                              .translate("cancel_qr_payment"),
                          alertType: AlertType.QR,
                          message: AppLocalizations.of(context)
                              .translate("cancel_qr_payment_des"),
                          onPositiveCallback: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.kHomeBaseView,
                              (Route<dynamic> route) => false,
                            );
                            // Navigator.pushNamed(context, Routes.kFundTransferView);
                          },
                          positiveButtonText: AppLocalizations.of(context)
                              .translate("yes,_cancel"),
                          negativeButtonText:
                              AppLocalizations.of(context).translate("no"),
                        );
                      },
                    ),
                  ],
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
