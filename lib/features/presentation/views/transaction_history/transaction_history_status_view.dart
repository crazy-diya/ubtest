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
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/widgets/ub_transaction_status_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../data/models/responses/transcation_details_response.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class TranArgs {
  final TxnDetailList tranItem;
  String? txnType;

  TranArgs({required this.tranItem, this.txnType});
}

class TransactionHistoryStatusView extends BaseView {
  final TranArgs tranArgs;

  TransactionHistoryStatusView({required this.tranArgs});

  @override
  _TransactionHistoryStatusViewState createState() =>
      _TransactionHistoryStatusViewState();
}

class _TransactionHistoryStatusViewState
    extends BaseViewState<TransactionHistoryStatusView> {
  var _bloc = injection<TransactionBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("transaction_status"),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<TransactionBloc, BaseState<TransactionState>>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is TransactionStatusPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName:
                  widget.tranArgs.txnType == "OWNUB" ? "UBgo FTME ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : widget.tranArgs.txnType == "BILLPAY" ? "UBgo Bill ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : widget.tranArgs.txnType == "LQR" ? "UBgo QR ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : widget.tranArgs.txnType == "WITHINUB" ? "UBgo FTUB ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : widget.tranArgs.txnType == "OTHERBANK" ? "UBgo FTOB ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : widget.tranArgs.txnType == "JP" ? "UBgo FTJP ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}"
                  : "UBgo Activity ${DateFormat('dd.MM.yyyy').format(widget.tranArgs.tranItem.modifiedDate ?? DateTime.now())}",
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
                  });
            }
          },
          child: Padding(
              padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 14.h+AppSizer.getHomeIndicatorStatus(context)),
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
                                            colors(context).positiveColor!,
                                        icon: PhosphorIcons.check(
                                            PhosphorIconsStyle.bold),
                                        iconColor: colors(context).whiteColor,
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("${getType(widget.tranArgs.tranItem.txnType ?? "")}")} ${AppLocalizations.of(context).translate("payment_success_tail")}",
                                        style: size18weight700.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("lkr")} ${widget.tranArgs.tranItem.amount.toString().withThousandSeparator()}",
                                        style: size24weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                      if (widget.tranArgs.tranItem.toBankCode !=
                                              null &&
                                          widget.tranArgs.tranItem.toBankCode !=
                                              "")
                                        Column(
                                          children: [
                                            Text(
                                              kBankList
                                                      .firstWhere(
                                                        (element) =>
                                                            element.id
                                                                .toString() ==
                                                            widget
                                                                .tranArgs
                                                                .tranItem
                                                                .toBankCode,
                                                        orElse: () =>
                                                            CommonDropDownResponse(),
                                                      )
                                                      .description ??
                                                  "",
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        )
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
                                  padding: const EdgeInsets.all(16).w,
                                  child: Column(
                                    children: [
                                      UBTransactionStatusComponent(
                                        isFirstItem: true,
                                        title: AppLocalizations.of(context)
                                            .translate("paid_from"),
                                        data: (widget.tranArgs.tranItem
                                                        .fromAccountName ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .fromAccountName ==
                                                    null)
                                            ? "-"
                                            : widget.tranArgs.tranItem
                                                .fromAccountName!,
                                        subData: (widget.tranArgs.tranItem
                                                        .fromAccountNumber ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .fromAccountNumber ==
                                                    null)
                                            ? "-"
                                            : widget.tranArgs.tranItem
                                                .fromAccountNumber!,
                                      ),
                                      UBTransactionStatusComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("pay_to"),
                                        data: (widget.tranArgs.tranItem
                                                        .toAccountName ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .toAccountName ==
                                                    null)
                                            ? "-"
                                            : widget.tranArgs.tranItem
                                                .toAccountName!,
                                        subData: (widget.tranArgs.tranItem
                                                        .toAccountNumber ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .toAccountNumber ==
                                                    null)
                                            ? "-"
                                            : widget.tranArgs.tranItem
                                                .toAccountNumber!,
                                      ),
                                      UBTransactionStatusComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("date_&_time"),
                                        data:
                                            DateFormat('dd-MMM-yyyy | HH:mm a')
                                                .format(widget.tranArgs.tranItem
                                                        .modifiedDate ??
                                                    DateTime.now()),
                                      ),
                                      UBTransactionStatusComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("remarks"),
                                        data: (widget.tranArgs.tranItem
                                                        .remarks ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .remarks ==
                                                    null)
                                            ? "-"
                                            : widget.tranArgs.tranItem.remarks!,
                                      ),
                                      UBTransactionStatusComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("transaction_category"),
                                        data: (widget.tranArgs.tranItem
                                                        .txnCategory ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .txnCategory ==
                                                    null)
                                            ? "-"
                                            : widget
                                                .tranArgs.tranItem.txnCategory!,
                                        // widget.tranArgs.tranItem.txnType!
                                      ),
                                      UBTransactionStatusComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("service_charge"),
                                        amount: (widget.tranArgs.tranItem
                                                        .serviceFee ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .serviceFee ==
                                                    null)
                                            ? "-"
                                            : widget
                                                .tranArgs.tranItem.serviceFee
                                                .toString()
                                                .withThousandSeparator(),
                                        isCurrency: true,
                                      ),

                                      // UBTransactionStatusComponent(
                                      //   title: AppLocalizations.of(context)
                                      //       .translate("beneficiary_email"),
                                      //   data: widget.tranArgs.tranItem.email ?? "",
                                      // ),
                                      UBTransactionStatusComponent(
                                        isLastItem: true,
                                        title: AppLocalizations.of(context)
                                            .translate("reference_number"),
                                        data: (widget.tranArgs.tranItem
                                                        .traceNumber ==
                                                    "" ||
                                                widget.tranArgs.tranItem
                                                        .traceNumber ==
                                                    null)
                                            ? "-"
                                            : widget
                                                .tranArgs.tranItem.traceNumber!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))),

                    16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(53,12,39,12),
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
                                      color: colors(context).primaryColor),
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
                                      color: colors(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  String getType(String type) {
    switch (type) {
      case "BILLPAY":
        return "bill_payment";
      case "LQR":
        return "qr_payment";
      default:
        return "fund_transfer";
    }
  }

  _downloadEReceipt(bool shouldStore) {
    _bloc.add(
      TransactionStatusPdfDownloadEvent(
        messageType: "txnDetailsReq",
        tranNum: widget.tranArgs.tranItem.transactionId,
        shouldOpen: shouldStore,
      ),
    );

    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
