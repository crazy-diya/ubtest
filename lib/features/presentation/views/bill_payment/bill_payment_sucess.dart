import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/service/app_permission.dart';
import 'package:union_bank_mobile/core/service/storage_service.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/bill_payment_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/biller_management/biller_management_event.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_process_view.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_summary_view.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/save_biller.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../utils/app_sizer.dart';
import '../../../data/models/responses/fund_transfer_scheduling_response.dart';
import '../../../data/models/responses/schedule_bill_payment_response.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../base_view.dart';
import '../schedule/schedule_bill_payment/widgets/schedule_bill_payment_data_component.dart';
import '../transaction_history/data/transaction_history_args.dart';

class SuccessBillStatusArgs {
  final SchedulingFundTransferResponse? schedulingFundTransferResponse;
  final ScheduleBillPaymentResponse? scheduleBillPaymentResponse;
  final TransactionHistoryArgs? billReceiptArgs;
  final bool? paymentSuccess;
  final String? message;
  final FundTransferEntity? fundTransferEntity;
  final String? toAccName;
  final String? toAccNumber;
  final String? remark;
  final String route;
  final BPRouteType? bpRouteType;
  final BillPaymentResponse? billPaymentResponse;
  final bool? isSaved;
  final BillPaymentSummeryArgs? billPaymentSummeryArgs;
  final BillPaymentViewArgs? billPaymentViewArgs;

  SuccessBillStatusArgs(
      {this.schedulingFundTransferResponse,
      this.billPaymentResponse,
      this.fundTransferEntity,
      this.paymentSuccess,
      this.message,
      this.billReceiptArgs,
      this.scheduleBillPaymentResponse,
      this.toAccNumber,
      this.toAccName,
      this.remark,
      required this.route,
      this.bpRouteType,
      this.isSaved,
      this.billPaymentSummeryArgs,
      this.billPaymentViewArgs});
}

class BillPaymentSucessView extends BaseView {
  //final FundTransferReceiptViewArgs fundTransferReceiptViewArgs;
  final SuccessBillStatusArgs? laterBillStatusArgs;

  BillPaymentSucessView({this.laterBillStatusArgs});

  @override
  _UnSavedPayeeLaterPaymentSucessViewState createState() =>
      _UnSavedPayeeLaterPaymentSucessViewState();
}

class _UnSavedPayeeLaterPaymentSucessViewState
    extends BaseViewState<BillPaymentSucessView> {
  var _bloc = injection<BillerManagementBloc>();
  final formatCurrency = NumberFormat.currency(symbol: '');

  Download download = Download.NON;

  String currentDateTime = DateTime.now().toIso8601String();

  // String payFromNum = "";
  // String payToNum = "";
  // @override
  // void initState() {
  //   setState(() {
  //     payFromNum = widget.laterBillStatusArgs?.fundTransferEntity!.payFromNum ?? "no num";
  //     payToNum = widget.laterBillStatusArgs!.fundTransferEntity!.payToacctnmbr ?? "no num";
  //   });
  // }



  @override
  void initState() {
    super.initState();
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
          title: AppLocalizations.of(context).translate("bill_payment_status"),
          onBackPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.kHomeBaseView,
              (Route<dynamic> route) => false,
            );
          },
        ),
        body: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocListener<BillerManagementBloc,
                  BaseState<BillerManagementState>>(
              listener: (_, state) async {
                if (state is BillerPdfDownloadSuccessState) {
                  var data = base64.decode(state.document!);
                  await StorageService(directoryName: 'UB').storeFile(
                      // fileName: widget.laterBillStatusArgs?.toAccNumber ??
                      //     widget.laterBillStatusArgs?.billReceiptArgs?.refId ??
                      //     "",
                      fileName: "UBgo Bill ${DateFormat("dd.MM.yyyy").format(DateTime.parse(currentDateTime))}",
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
                  // final data = base64.decode(state.image!);
                  // StorageService(directoryName: 'CDB Digital').storeFile(
                  //     fileName:
                  //     'cdb_transaction_receipt${widget.billStatusArgs!
                  //         .billPaymentArgs!.billerEntity!.billerId}',
                  //     fileExtension: 'pdf',
                  //     fileData: data,
                  //     onComplete: (file) async {
                  //       if (state.shouldOpen!) {
                  //         await OpenFilex.open(file.path);
                  //       } else {
                  //         Share.shareFiles(
                  //           [file.path],
                  //         );
                  //       }
                  //     },
                  //     onError: (error) {
                  //       ToastUtils.showCustomToast(
                  //           context, error, ToastStatus.fail);
                  //     });
                }
                else if (state is BillerExcelDownloadSuccessState) {
                  var data = base64.decode(state.document!);
                  StorageService(directoryName: 'UB').storeFile(
                      fileName: widget.laterBillStatusArgs?.toAccNumber ??
                          widget.laterBillStatusArgs?.billReceiptArgs?.refId ??
                          "",
                      //fileName: widget.billStatusArgs!.billPaymentResponse!.billerResponseDto!.accountNumber!,
                      fileExtension: 'xls',
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
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    24.h,
                    20.w,
                    20.h+ AppSizer.getHomeIndicatorStatus(context),
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
                                            colors(context).positiveColor!,
                                        icon: PhosphorIcons.check(
                                            PhosphorIconsStyle.bold),
                                        iconColor: colors(context).whiteColor,
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        widget.laterBillStatusArgs
                                                    ?.bpRouteType ==
                                                BPRouteType.NOW
                                            ? AppLocalizations.of(context)
                                                .translate(
                                                    "bill_was_payment_successful")
                                            : AppLocalizations.of(context)
                                                .translate(
                                                    "schedule_was_successful"),
                                        style: size18weight700.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("lkr")} ${widget.laterBillStatusArgs!.billReceiptArgs?.amount.toString().withThousandSeparator()}",
                                        style: size24weight700.copyWith(
                                            color:
                                                colors(context).primaryColor),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        widget.laterBillStatusArgs?.toAccName ??
                                            "",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16)
                                          .w,
                                  child: Column(
                                    children: [
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("pay_to"),
                                        data: widget.laterBillStatusArgs
                                                ?.toAccName ??
                                            "-",
                                        subData: widget.laterBillStatusArgs
                                                ?.toAccNumber ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("paid_from"),
                                        data: widget
                                                .laterBillStatusArgs
                                                ?.billReceiptArgs
                                                ?.fromAccName ??
                                            "-",
                                        subData: widget.laterBillStatusArgs
                                                ?.billReceiptArgs!.fromAccNumber??
                                            "-",
                                      ),
                                      if (BPRouteType.NOW ==
                                          widget
                                              .laterBillStatusArgs?.bpRouteType)
                                        BillPaymentDataComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("date_&_time"),
                                          data: DateFormat(
                                                      "dd-MMM-yyyy | hh:mm a")
                                                  .format(DateTime.parse(
                                                      currentDateTime)) ??
                                              "-",
                                        ),
                                      if (BPRouteType.LATER ==
                                          widget
                                              .laterBillStatusArgs?.bpRouteType)
                                        BillPaymentDataComponent(
                                          title: AppLocalizations.of(context)
                                              .translate(
                                                  "transaction_due_date"),
                                          data: widget
                                                      .laterBillStatusArgs
                                                      ?.scheduleBillPaymentResponse
                                                      ?.startDate !=
                                                  null
                                              ? "${DateFormat("dd-MMM-y").format(DateTime.parse(widget.laterBillStatusArgs!.scheduleBillPaymentResponse!.startDate!))} "
                                              : "-",
                                        ),
                                      if (BPRouteType.RECUURING ==
                                          widget
                                              .laterBillStatusArgs?.bpRouteType)
                                        Column(
                                          children: [
                                            BillPaymentDataComponent(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate("start_date"),
                                              data: widget
                                                          .laterBillStatusArgs
                                                          ?.scheduleBillPaymentResponse
                                                          ?.startDate !=
                                                      null
                                                  ? "${DateFormat("dd-MMM-y").format(DateTime.parse(widget.laterBillStatusArgs!.scheduleBillPaymentResponse!.startDate!))}"
                                                  : "-",
                                            ),
                                            BillPaymentDataComponent(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate("end_date"),
                                              data: widget
                                                          .laterBillStatusArgs
                                                          ?.scheduleBillPaymentResponse
                                                          ?.endDate !=
                                                      null
                                                  ? "${DateFormat("dd-MMM-y").format(DateTime.parse(widget.laterBillStatusArgs!.scheduleBillPaymentResponse!.endDate!))}"
                                                  : "-",
                                            ),
                                            BillPaymentDataComponent(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate("frequency"),
                                              data: widget
                                                      .laterBillStatusArgs!
                                                      .scheduleBillPaymentResponse
                                                      ?.frequency ??
                                                  "-",
                                            ),
                                            BillPaymentDataComponent(
                                              title: AppLocalizations.of(
                                                      context)
                                                  .translate("no_of_transfers"),
                                              data: getNumberOfTrans(),
                                            ),
                                          ],
                                        ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("remarks"),
                                        //data: widget.laterBillStatusArgs?.billReceiptArgs?.remark??"-",
                                        data: widget.laterBillStatusArgs
                                                        ?.remark !=
                                                    '' &&
                                                widget.laterBillStatusArgs
                                                        ?.remark !=
                                                    null
                                            ? widget
                                                .laterBillStatusArgs!.remark!
                                            : "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("transaction_category"),
                                        data: widget
                                                .laterBillStatusArgs
                                                ?.billPaymentViewArgs!
                                                .billerCategoryEntity
                                                ?.categoryName ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("service_charge"),
                                        amount: widget.laterBillStatusArgs
                                            ?.billReceiptArgs?.serviceFee
                                            .toString()
                                            .withThousandSeparator(),
                                        isCurrency: true,
                                      ),
                                      BillPaymentDataComponent(
                                        isLastItem: true,
                                        title: AppLocalizations.of(context)
                                            .translate("reference_number"),
                                        data: widget
                                                        .laterBillStatusArgs
                                                        ?.billReceiptArgs
                                                        ?.refId !=
                                                    '' &&
                                                widget
                                                        .laterBillStatusArgs
                                                        ?.billReceiptArgs
                                                        ?.refId !=
                                                    null
                                            ? "${widget.laterBillStatusArgs!.billReceiptArgs!.refId!}"
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
                      if (widget.laterBillStatusArgs?.bpRouteType ==
                          BPRouteType.NOW)
                        Padding(
                          padding: const EdgeInsets.only(top: 16).h,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(53,12,39,12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _downloadPDFReceipt(false);
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
                                      // _showBottomSheet(context);
                                      _downloadPDFReceipt(true);
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
                      if (widget.laterBillStatusArgs?.isSaved == false)
                        Padding(
                          padding: const EdgeInsets.only(top: 16).w,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.kSaveBillerView,
                                arguments: SaveBillerArgs(
                                    accNumber:
                                        widget.laterBillStatusArgs!.toAccNumber,
                                    billPaymentViewArgs: widget
                                        .laterBillStatusArgs
                                        ?.billPaymentViewArgs,
                                    billerCatogory: widget
                                        .laterBillStatusArgs
                                        ?.billPaymentSummeryArgs!
                                        .billerCategoryEntity!
                                        .categoryName,
                                    serviceProvider: widget
                                        .laterBillStatusArgs
                                        ?.billPaymentSummeryArgs!
                                        .billerEntity!
                                        .billerName!,
                                    serviceProviderId: widget
                                        .laterBillStatusArgs!
                                        .billPaymentViewArgs!
                                        .serviceProviderId!,
                                    route: widget.laterBillStatusArgs!.route),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        PhosphorIcon(
                                          PhosphorIcons.floppyDisk(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor,
                                        ),
                                        8.horizontalSpace,
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate("save_biller"),
                                          style: size14weight700.copyWith(
                                              color:
                                                  colors(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      20.verticalSpace,
                      Column(
                        children: [
                          AppButton(
                              buttonText: AppLocalizations.of(context)
                                  .translate("make_another_payment"),
                              onTapButton: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.kPayBillsMenuView,
                                  arguments: widget.laterBillStatusArgs!.route,
                                  (Route<dynamic> route) =>
                                      route.settings.name ==
                                      widget.laterBillStatusArgs!.route,
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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<bool>(
        isScrollControlled: true,
        useRootNavigator: true,
        useSafeArea: true,
        context: context,
        barrierColor: colors(context).blackColor?.withOpacity(.85),
        backgroundColor: Colors.transparent,
        builder: (
          context,
        ) =>
            StatefulBuilder(builder: (context, changeState) {
              return BottomSheetBuilder(
                isAttachmentSheet: true,
                title: AppLocalizations.of(context)
                    .translate("select_downloading_option"),
                buttons: [
                  // Expanded(
                  //   child: AppButton(
                  //     buttonType: (download == Download.NON)
                  //         ? ButtonType.PRIMARYDISABLED
                  //         : ButtonType.PRIMARYENABLED,
                  //     buttonText:
                  //         AppLocalizations.of(context).translate("download"),
                  //     onTapButton: () {
                  //       download == Download.PDF
                  //           ? _downloadPDFReceipt(true)
                  //           : _downloadExcelReceipt(true);
                  //       Navigator.pop(context);
                  //     },
                  //   ),
                  // )
                ],
                children: [
                   Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).primaryColor50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              changeState(() {
                                download = Download.EX;
                                _downloadExcelReceipt(true);
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(8),
                              color: download == Download.EX
                                  ? colors(context).greyColor50 // Set color when selected
                                  : Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Center(
                                      child: PhosphorIcon(
                                        PhosphorIcons.fileXls(PhosphorIconsStyle.bold),
                                        color: colors(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Text(AppLocalizations.of(context).translate("excel") , style: size14weight700.copyWith(color: colors(context).primaryColor),)
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeState(() {
                                download = Download.PDF; // Update the selected option
                                _downloadPDFReceipt(true);
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(8),
                              color: download == Download.PDF
                                  ? colors(context).greyColor50
                                  : Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Center(
                                      child: PhosphorIcon(
                                        PhosphorIcons.filePdf(PhosphorIconsStyle.bold),
                                        color: colors(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Text(AppLocalizations.of(context).translate("pdf") , style: size14weight700.copyWith(color: colors(context).primaryColor),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  _downloadPDFReceipt(bool shouldStore) {
    _bloc.add(
      BillerPdfDDownloadEvent(
        transactionType: "BP",
        transactionId: widget.laterBillStatusArgs?.billPaymentResponse?.txnId,
        shouldOpen: shouldStore,
      ),
    );
    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  _downloadExcelReceipt(bool shouldStore) {
    _bloc.add(
      BillerExcelDownloadEvent(
        transactionType: "BP",
        transactionId: widget.laterBillStatusArgs?.billPaymentResponse?.txnId,
        shouldOpen: shouldStore,
      ),
    );
    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  String getNumberOfTrans() {
    String trans;

    Duration difference = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
          .parse(widget.laterBillStatusArgs!.billPaymentSummeryArgs!.endDate!)),
    ).difference(DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
          widget.laterBillStatusArgs!.billPaymentSummeryArgs!.startDate!)),
    ));
    if (widget.laterBillStatusArgs!.billPaymentSummeryArgs!.scheduleFrequency ==
        "Daily") {
      trans = (difference.inDays + 1).toString();
      return trans.toString();
    } else if (widget
            .laterBillStatusArgs!.billPaymentSummeryArgs!.scheduleFrequency ==
        "Weekly") {
      trans = ((difference.inDays / 7) + 1).floor().toString();
      return trans.toString();
    } else if (widget
            .laterBillStatusArgs!.billPaymentSummeryArgs!.scheduleFrequency ==
        "Monthly") {
      trans = ((DateTime.parse(
                    DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                        .parse(widget.laterBillStatusArgs!
                            .billPaymentSummeryArgs!.endDate!)),
                  ).month -
                  DateTime.parse(
                    DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                        .parse(widget.laterBillStatusArgs!
                            .billPaymentSummeryArgs!.startDate!)),
                  ).month +
                  (DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(
                                DateFormat('d MMMM y').parse(widget
                                    .laterBillStatusArgs!
                                    .billPaymentSummeryArgs!
                                    .endDate!)),
                          ).year -
                          DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(
                                DateFormat('d MMMM y').parse(widget
                                    .laterBillStatusArgs!
                                    .billPaymentSummeryArgs!
                                    .startDate!)),
                          ).year) *
                      12) +
              1)
          .toString();
      return trans.toString();
    } else {
      trans = (DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.laterBillStatusArgs!.billPaymentSummeryArgs!
                        .endDate!)),
              ).year -
              DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.laterBillStatusArgs!.billPaymentSummeryArgs!
                        .startDate!)),
              ).year)
          .toString();
      return trans.toString();
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
