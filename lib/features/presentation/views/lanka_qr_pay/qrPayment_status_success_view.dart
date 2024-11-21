import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../schedule/schedule_bill_payment/widgets/schedule_bill_payment_data_component.dart';

class QRPaymentSuccessArgs {
  String? amount;
  String? remark;
  String? payFromName;
  String? payToName;
  String? payFromNum;
  String? payToNum;
  String? instrumentId;
  String? dateTime;
  String? refNum;
  String? txnAmount;
  String? transactionId;
  double? serviceCharge;
  final String? route;

  QRPaymentSuccessArgs({
    this.instrumentId,
    this.remark,
    this.amount,
    this.payFromNum,
    this.payFromName,
    this.dateTime,
    this.payToName,
    this.payToNum,
    this.txnAmount,
    this.refNum,
    this.transactionId,
    this.serviceCharge,
    this.route,
  });
}

class QRPaymentSuccessStatusView extends BaseView {
  final QRPaymentSuccessArgs qrPaymentSuccessArgs;

  QRPaymentSuccessStatusView({required this.qrPaymentSuccessArgs});

  @override
  _QRPaymentSuccessStateViewState createState() =>
      _QRPaymentSuccessStateViewState();
}

class _QRPaymentSuccessStateViewState
    extends BaseViewState<QRPaymentSuccessStatusView> {
  var _bloc = injection<AccountBloc>();
  Download download = Download.NON;
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
        body: BlocProvider<AccountBloc>(
          create: (_) => _bloc,
          child: BlocListener<AccountBloc, BaseState<AccountState>>(
              listener: (context, state) async {
                if (state is QrPaymentPdfDownloadSuccessState) {
                  var data = base64.decode(state.document!);
                  await StorageService(directoryName: 'UB').storeFile(
                      fileName: "UBgo QR ${DateFormat('dd.MM.yyyy').format(DateTime.parse(widget.qrPaymentSuccessArgs.dateTime ??
                          dateTime.toString()))}",
                      fileExtension: 'pdf',
                      fileData: data,
                      onComplete: (file) async {
                        if (state.shouldOpen!) {
                          await OpenFilex.open(file.path);
                        } else {
                          Share.shareXFiles(
                            [file],
                          );
                        }
                      },
                      onError: (error) {
                        ToastUtils.showCustomToast(
                            context, error, ToastStatus.FAIL);
                      },);
                }
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
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
                                        borderRadius:
                                            BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24).w,
                                      child: Column(
                                        children: [
                                          CommonStatusIcon(
                                            backGroundColor:
                                                colors(context).positiveColor!,
                                            icon: PhosphorIcons.check(
                                                PhosphorIconsStyle.bold),
                                            iconColor:
                                                colors(context).whiteColor,
                                          ),
                                          16.verticalSpace,
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "qr_payment_successful"),
                                            style: size18weight700.copyWith(
                                                color:
                                                    colors(context).blackColor),
                                          ),
                                          16.verticalSpace,
                                          Text(
                                            "${AppLocalizations.of(context).translate("lkr")} ${widget.qrPaymentSuccessArgs.amount!.toString().withThousandSeparator()}",
                                            style: size24weight700.copyWith(
                                                color: colors(context)
                                                    .primaryColor),
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            widget.qrPaymentSuccessArgs
                                                    .payToName ??
                                                "",
                                            style: size16weight700.copyWith(
                                                color: colors(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(16,0,16,16).w,
                                      child: Column(
                                        children: [
                                          BillPaymentDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("paid_from"),
                                            data: widget.qrPaymentSuccessArgs
                                                    .payFromName ??
                                                "-",
                                            subData: widget.qrPaymentSuccessArgs
                                                    .payFromNum ??
                                                "-",
                                          ),
                                          BillPaymentDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("pay_to"),
                                            data: widget.qrPaymentSuccessArgs
                                                    .payToName ??
                                                "-",
                                            subData: widget.qrPaymentSuccessArgs
                                                    .payToNum ??
                                                "-",
                                          ),
                                          BillPaymentDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("date_&_time"),
                                            data: widget.qrPaymentSuccessArgs
                                                        .dateTime !=
                                                    null
                                                ? DateFormat(
                                                        'dd-MMM-yyyy | hh:mm a')
                                                    .format(DateTime.parse(widget
                                                            .qrPaymentSuccessArgs
                                                            .dateTime ??
                                                        DateTime.now()
                                                            .toString()
                                                            .toString()))
                                                : "-",
                                          ),
                                          BillPaymentDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("remarks"),
                                            data: widget.qrPaymentSuccessArgs
                                                            .remark ==
                                                        null ||
                                                    widget.qrPaymentSuccessArgs
                                                            .remark ==
                                                        ""
                                                ? "-"
                                                : widget.qrPaymentSuccessArgs
                                                        .remark ??
                                                    "-",
                                          ),
                                          BillPaymentDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("service_charge"),
                                            amount: widget.qrPaymentSuccessArgs
                                                .serviceCharge
                                                .toString()
                                                .withThousandSeparator(),
                                            isCurrency: true,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16).w,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(53,12,39,12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _downloadEReceipt(false);
                                  },
                                  child: Row(
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIcons.shareNetwork(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).primaryColor,
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("share"),
                                        style: size14weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _downloadEReceipt(true);
                                  },
                                  child: Row(
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIcons.downloadSimple(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).primaryColor,
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("download"),
                                        style: size14weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Column(
                        children: [
                          20.verticalSpace,
                          AppButton(
                              buttonText: AppLocalizations.of(context)
                                  .translate("make_another_payment"),
                              onTapButton: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.kScanQRCodeView,
                                  arguments: widget.qrPaymentSuccessArgs.route,
                                  (Route<dynamic> route) =>
                                      route.settings.name ==
                                      widget.qrPaymentSuccessArgs.route,
                                );
                              }),
                          16.verticalSpace,
                          AppButton(
                              buttonType: ButtonType.OUTLINEENABLED,
                              buttonColor: Colors.transparent,
                              buttonText: AppLocalizations.of(context)
                                  .translate("home"),
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
        ),
      ),
    );
  }

  _downloadEReceipt(bool shouldStore) {
    _bloc.add(
      QRPaymentPdfDownloadEvent(
        txnAmount: widget.qrPaymentSuccessArgs.txnAmount,
        date: widget.qrPaymentSuccessArgs.dateTime,
        referenceNo: widget.qrPaymentSuccessArgs.refNum,
        remarks: widget.qrPaymentSuccessArgs.remark == null ||
                widget.qrPaymentSuccessArgs.remark == ""
            ? "-"
            : widget.qrPaymentSuccessArgs.remark!,
        serviceCharge: "30",
        status: "Success",
        shouldOpen: shouldStore,
        transactionId: widget.qrPaymentSuccessArgs.transactionId
      ),
    );
    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
