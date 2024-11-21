import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/widgets/ub_transaction_status_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';

import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_event.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/common_status_icon.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class TransactionDetailsArgs {
  final String? paidFromAccName;
  final String? paidFromAccNum;
  final String? paidToAccName;
  final String? paidToAccNum;
  final String? amount;
  final String? serviceCharge;
  final String? category;
  final String? remarks;
  final String? email;
  final String? mobile;
  final String? date;
  final String? referenceId;
  final String? tranId;
  final String? currency;

  TransactionDetailsArgs({
    this.paidFromAccName,
    this.paidFromAccNum,
    this.paidToAccName,
    this.paidToAccNum,
    this.amount,
    this.serviceCharge,
    this.category,
    this.remarks,
    this.email,
    this.mobile,
    this.date,
    this.referenceId,
    this.tranId,
    this.currency,
  });
}

class PortfolioTransactionHistoryStatusView extends BaseView {
  final TransactionDetailsArgs transactionDetailsArgs;

  PortfolioTransactionHistoryStatusView({required this.transactionDetailsArgs});

  @override
  _PortfolioTransactionHistoryStatusViewState createState() =>
      _PortfolioTransactionHistoryStatusViewState();
}

class _PortfolioTransactionHistoryStatusViewState
    extends BaseViewState<PortfolioTransactionHistoryStatusView> {
  var bloc = injection<PortfolioBloc>();

  Download download = Download.NON;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("transaction_status"),
      ),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is AccountTransactionStatusPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: widget.transactionDetailsArgs.paidFromAccNum??widget.transactionDetailsArgs.date.toString(),
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
            else if (state is AccountTransactionStatusExcelDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: widget.transactionDetailsArgs.paidFromAccNum??widget.transactionDetailsArgs.date.toString(),
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
            else if (state is AccountTransactionStatusPdfDownloadFailedState) {
              ToastUtils.showCustomToast(
                        context, state.message??'', ToastStatus.FAIL);
            }
            else if (state is AccountTransactionStatusExcelDownloadFailedState) {
               ToastUtils.showCustomToast(
                        context, state.message??'', ToastStatus.FAIL);
            }
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h+ AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Column(
                                    children: [
                                      24.verticalSpace,
                                      CommonStatusIcon(
                                        backGroundColor: colors(context).positiveColor!,
                                        icon: PhosphorIcons.check(PhosphorIconsStyle.bold),
                                        iconColor: colors(context).whiteColor,
                                      ),
                                      16.verticalSpace,
                                      Text(AppLocalizations.of(context)
                                          .translate("fund_transfer_successful"),
                                          style: size18weight700.copyWith(color: colors(context).blackColor)),
                                      16.verticalSpace,
                                      Text("${widget.transactionDetailsArgs.currency == null || widget.transactionDetailsArgs.currency == ""?AppLocalizations.of(context).translate("lkr"):widget.transactionDetailsArgs.currency} ${widget.transactionDetailsArgs.amount?.withThousandSeparator()?? "-"}",
                                          style: size24weight700.copyWith(color: colors(context).primaryColor)),
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
                                    padding: EdgeInsets.only(left: 16.w , right: 16.w , bottom: 16.w),
                                    child: Column(
                                      children: [
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("paid_from"),
                                          data: (widget.transactionDetailsArgs.paidFromAccName == null || widget.transactionDetailsArgs.paidFromAccName == "") ? "-" :
                                          widget.transactionDetailsArgs.paidFromAccName ?? "-",
                                          subData: (widget.transactionDetailsArgs.paidFromAccNum == null || widget.transactionDetailsArgs.paidFromAccNum == "") ? "-" :
                                          widget.transactionDetailsArgs.paidFromAccNum?? "-",
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("pay_to"),
                                          data: (widget.transactionDetailsArgs.paidToAccName == null || widget.transactionDetailsArgs.paidToAccName == "") ? "-" :
                                          widget.transactionDetailsArgs.paidToAccName?? "-",
                                          subData: (widget.transactionDetailsArgs.paidToAccNum == null || widget.transactionDetailsArgs.paidToAccNum == "") ? "-" :
                                          widget.transactionDetailsArgs.paidToAccNum?? "-",
                                        ),
                                        // UBTransactionStatusComponent(
                                        //   title: AppLocalizations.of(context)
                                        //       .translate("amount"),
                                        //   amount:(widget.transactionDetailsArgs.amount == null || widget.transactionDetailsArgs.amount == "") ? "-" :
                                        //   widget.transactionDetailsArgs.amount?? "-"
                                        //       .toString()
                                        //       .withThousandSeparator(),
                                        //   // double.parse(widget.tranArgs.tranItem.amount!),
                                        //   isCurrency: true,
                                        // ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("remarks"),
                                          data: (widget.transactionDetailsArgs.remarks == null || widget.transactionDetailsArgs.remarks == "") ? "-" :
                                          widget.transactionDetailsArgs.remarks?? "-",
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("transaction_category"),
                                          data: (widget.transactionDetailsArgs.category == null || widget.transactionDetailsArgs.category == "") ?
                                          "-" : widget.transactionDetailsArgs.category?? "-",
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("service_charge"),
                                          currency: widget.transactionDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                                          amount: (widget.transactionDetailsArgs.serviceCharge == null || widget.transactionDetailsArgs.serviceCharge == "") ? "-" :
                                          widget.transactionDetailsArgs.serviceCharge?? "-"
                                              .toString()
                                              .withThousandSeparator(),
                                          // double.parse(
                                          //     widget.tranArgs.tranItem.serviceFee!),
                                          isCurrency: true,
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("beneficiary_mobile_no"),
                                          data: (widget.transactionDetailsArgs.mobile == null || widget.transactionDetailsArgs.mobile == "") ? "-" :
                                          widget.transactionDetailsArgs.mobile?? "-",
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("date_&_time"),
                                          data: DateFormat('dd-MMM-yyyy').format(
                                              DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
                                                  .parse(
                                                widget.transactionDetailsArgs.date?? "-",
                                              )),
                                        ),
                                        UBTransactionStatusComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("reference_number"),
                                          data: (widget.transactionDetailsArgs.referenceId == null || widget.transactionDetailsArgs.referenceId == "") ? "-" :
                                          widget.transactionDetailsArgs.referenceId ?? "-",
                                          isLastItem: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                 20.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _downloadEReceipt(false);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  PhosphorIcon(PhosphorIcons.shareNetwork(PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                      AppLocalizations.of(context).translate("share"),
                                      style: size14weight700.copyWith(color: colors(context).primaryColor)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: colors(context).secondaryColor300,
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              _downloadEReceipt(true);
                            },
                            // async {
                            //   final result = await showModalBottomSheet<bool>(
                            //       isScrollControlled: true,
                            //       useRootNavigator: true,
                            //       useSafeArea: true,
                            //       context: context,
                            //       barrierColor: colors(context).blackColor?.withOpacity(.85),
                            //       backgroundColor: Colors.transparent,
                            //       builder: (context,) => StatefulBuilder(
                            //           builder: (context,changeState) {
                            //             return BottomSheetBuilder(
                            //               isAttachmentSheet: true,
                            //               title: AppLocalizations.of(context).translate('download'),
                            //               buttons: [
                            //                 // Expanded(
                            //                 //   child: AppButton(
                            //                 //       buttonType: download == Download.NON ? ButtonType.OUTLINEDISABLED : ButtonType.PRIMARYENABLED,
                            //                 //       buttonText: AppLocalizations.of(context) .translate("download"),
                            //                 //       onTapButton: () {
                            //                 //         download == Download.PDF
                            //                 //             ? _downloadEReceipt(true)
                            //                 //             : _downloadExcelReceipt(true);
                            //                 //         Navigator.pop(context);
                            //                 //         changeState(() {});
                            //                 //         setState(() {});
                            //                 //       }),
                            //                 // ),
                            //               ],
                            //               children: [
                            //                 Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius: BorderRadius.circular(8).r,
                            //                     color: colors(context).primaryColor50,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(16.0).w,
                            //                     child: Row(
                            //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                       children: [
                            //                         InkWell(
                            //                           onTap: () {
                            //                             changeState(() {
                            //                               download = Download.EX;
                            //                               _downloadExcelReceipt(true);
                            //                             });
                            //                           },
                            //                           child: Material(
                            //                             borderRadius: BorderRadius.circular(8),
                            //                             color: download == Download.EX
                            //                                 ? colors(context).greyColor50 // Set color when selected
                            //                                 : Colors.transparent,
                            //                             child: Row(
                            //                               children: [
                            //                                 SizedBox(
                            //                                   child: Center(
                            //                                     child: PhosphorIcon(
                            //                                       PhosphorIcons.fileXls(PhosphorIconsStyle.bold),
                            //                                       color: colors(context).primaryColor,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                                 8.horizontalSpace,
                            //                                 Text(AppLocalizations.of(context).translate("excel") , style: size14weight700.copyWith(color: colors(context).primaryColor),)
                            //                               ],
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         InkWell(
                            //                           onTap: () {
                            //                             changeState(() {
                            //                               download = Download.PDF; // Update the selected option
                            //                               _downloadEReceipt(true);
                            //                             });
                            //                           },
                            //                           child: Material(
                            //                             borderRadius: BorderRadius.circular(8),
                            //                             color: download == Download.PDF
                            //                                 ? colors(context).greyColor50
                            //                                 : Colors.transparent,
                            //                             child: Row(
                            //                               children: [
                            //                                 SizedBox(
                            //                                   child: Center(
                            //                                     child: PhosphorIcon(
                            //                                       PhosphorIcons.filePdf(PhosphorIconsStyle.bold),
                            //                                       color: colors(context).primaryColor,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                                 8.horizontalSpace,
                            //                                 Text(AppLocalizations.of(context).translate("pdf") , style: size14weight700.copyWith(color: colors(context).primaryColor),)
                            //                               ],
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             );
                            //           }
                            //       ));
                            //   setState(() {});
                            // },
                            //     () {
                            //   _showBottomSheet(context);
                            // },
                            child: Container(
                              child: Row(
                                children: [
                                  PhosphorIcon(PhosphorIcons.downloadSimple(PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate("download"),
                                      style: size14weight700.copyWith(color: colors(context).primaryColor)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 3.h,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           _downloadEReceipt(false);
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Image.asset(
                  //               AppAssets.icShareIcon,
                  //               scale: 3,
                  //             ),
                  //             SizedBox(
                  //               width: 3.w,
                  //             ),
                  //             Text(
                  //               AppLocalizations.of(context)
                  //                   .translate("share"),
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: colors(context).secondaryColor300,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 3.w,
                  //       ),
                  //       VerticalDivider(
                  //         color: colors(context).secondaryColor300,
                  //         thickness: 1,
                  //       ),
                  //       SizedBox(
                  //         width: 3.w,
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {
                  //           _showBottomSheet(context);
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Image.asset(
                  //               AppAssets.icDwnldIcon,
                  //               scale: 3,
                  //             ),
                  //             SizedBox(
                  //               width: 3.w,
                  //             ),
                  //             Text(
                  //               AppLocalizations.of(context)
                  //                   .translate("download"),
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: colors(context).secondaryColor300,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              )),
        ),
      ),
    );
  }


  _downloadEReceipt(bool shouldStore) {
    bloc.add(
      AccountTransactionStatusPdfDownloadEvent(
        paidFromAccountName: widget.transactionDetailsArgs.paidFromAccName,
        paidToAccountNo: widget.transactionDetailsArgs.paidToAccNum,
        paidFromAccountNo: widget.transactionDetailsArgs.paidFromAccNum,
        paidToAccountName: widget.transactionDetailsArgs.paidToAccName,
        amount: widget.transactionDetailsArgs.amount,
        serviceCharge: widget.transactionDetailsArgs.serviceCharge,
        transactionCategory: widget.transactionDetailsArgs.category,
        remarks: widget.transactionDetailsArgs.remarks,
        beneficiaryEmail: widget.transactionDetailsArgs.email,
        beneficiaryMobileNo: widget.transactionDetailsArgs.mobile,
        dateAndTime: widget.transactionDetailsArgs.date,
        referenceId: widget.transactionDetailsArgs.referenceId ?? "-",
        shouldOpen: shouldStore,
      ),
    );

    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  _downloadExcelReceipt(bool shouldStore) {
    bloc.add(
      AccountTransactionStatusExcelDownloadEvent(
        paidFromAccountName: widget.transactionDetailsArgs.paidFromAccName,
        paidToAccountNo: widget.transactionDetailsArgs.paidToAccNum,
        paidFromAccountNo: widget.transactionDetailsArgs.paidFromAccNum,
        paidToAccountName: widget.transactionDetailsArgs.paidToAccName,
        amount: widget.transactionDetailsArgs.amount,
        serviceCharge: widget.transactionDetailsArgs.serviceCharge,
        transactionCategory: widget.transactionDetailsArgs.category,
        remarks: widget.transactionDetailsArgs.remarks,
        beneficiaryEmail: widget.transactionDetailsArgs.email,
        beneficiaryMobileNo: widget.transactionDetailsArgs.mobile,
        dateAndTime: widget.transactionDetailsArgs.date,
        referenceId: widget.transactionDetailsArgs.referenceId ?? "-",
        shouldOpen: shouldStore,
      ),
    );

    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
