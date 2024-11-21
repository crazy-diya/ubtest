import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/app_permission.dart';
import '../../../../../core/service/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service/storage_service.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';

import '../../../bloc/fund_transfer/fund_transfer_bloc.dart';
import '../../../bloc/fund_transfer/fund_transfer_event.dart';
import '../../../bloc/fund_transfer/fund_transfer_state.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../notifications/notifications_view.dart';
import '../data/fund_transfer_recipt_view_args.dart';
import '../widgets/fund_transfer_data_component.dart';

class OwnAcctNowPaymentSucessView extends BaseView {
  final FundTransferReceiptViewArgs fundTransferReceiptViewArgs;

  OwnAcctNowPaymentSucessView({required this.fundTransferReceiptViewArgs});

  @override
  _OwnAcctNowPaymentSucessViewState createState() =>
      _OwnAcctNowPaymentSucessViewState();
}

class _OwnAcctNowPaymentSucessViewState
    extends BaseViewState<OwnAcctNowPaymentSucessView> {
  final bloc = injection<FundTransferBloc>();
  String? fundTranId;
  Download download = Download.NON;
  String payFromNum = "";
  String payToNum = "";
  late DateTime dateTime ;

  @override
  void initState() {
    super.initState();
    setState(() {
      dateTime = DateTime.now();
          // DateFormat('dd-MMM-yyyy|hh:mm a').parse(DateFormat('dd-MMM-yyyy|hh:mm a').format(DateTime.now()));
      payFromNum =
          widget.fundTransferReceiptViewArgs.fundTransferEntity.payFromNum ??
              "no num";
      payToNum =
          widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctnmbr ??
              "no num";
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          goBackEnabled: false,
          title: AppLocalizations.of(context).translate("fund_transfer_status"),
        ),
        body: BlocProvider<FundTransferBloc>(
          create: (_) => bloc,
          child: BlocListener<FundTransferBloc, BaseState<FundTransferState>>(
              bloc: bloc,
              listener: (_, state) {
                if (state is FundTransferReceiptDownloadSuccessState) {
                  var data = base64.decode(state.document!);
                  StorageService(directoryName: 'UB').storeFile(
                      fileName:
                      widget.fundTransferReceiptViewArgs.fundTransferEntity.tranType == "OWNUB" ? "UBgo FTME ${DateFormat('dd.MM.yyyy').format(dateTime)}"
                      : widget.fundTransferReceiptViewArgs.fundTransferEntity.tranType == "WITHINUB" ? "UBgo FTUB ${DateFormat('dd.MM.yyyy').format(dateTime)}"
                      : widget.fundTransferReceiptViewArgs.fundTransferEntity.tranType == "OTHERBANK" ? "UBgo FTOB ${DateFormat('dd.MM.yyyy').format(dateTime)}"
                      : "UBgo FTJP ${DateFormat('dd.MM.yyyy').format(dateTime)}",
                      // widget.fundTransferReceiptViewArgs
                      //     .fundTransferEntity.tranId!,
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
                if (state is FundTransferExcelDownloadSuccessState) {
                  var data = base64.decode(state.document!);
                  StorageService(directoryName: 'UB').storeFile(
                      fileName: widget.fundTransferReceiptViewArgs
                          .fundTransferEntity.tranId!,
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
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0),
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
                                        backGroundColor: colors(context).positiveColor!,
                                        icon: PhosphorIcons.check(PhosphorIconsStyle.bold),
                                        iconColor: colors(context).whiteColor,
                                      ),
                                      16.verticalSpace,
                                      if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNNOW ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW
                                      )
                                        Text(AppLocalizations.of(context)
                                            .translate("fund_transfer_was_successful"),
                                            style: size18weight700.copyWith(color: colors(context).blackColor)),
                                      if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNLATER ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNRECUURING ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING ||
                                          widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER
                                      )
                                        Text(
                                            AppLocalizations.of(context).translate("schedule_successful"),
                                            style: size18weight700.copyWith(color: colors(context).blackColor)),
                                      16.verticalSpace,
                                      Center(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(AppLocalizations.of(context).translate("lkr") , style: size20weight700.copyWith(color: colors(context).primaryColor),),
                                            8.horizontalSpace,
                                            Text('${widget.fundTransferReceiptViewArgs.fundTransferEntity.amount!.toString().withThousandSeparator()}' , style: size20weight700.copyWith(color: colors(context).primaryColor),),
                                          ],
                                        ),
                                      ),
                                      // 4.verticalSpace,
                                      Text(widget.fundTransferReceiptViewArgs.fundTransferEntity.bankName??"${widget.fundTransferReceiptViewArgs.fundTransferEntity.bankCode == AppConstants.ubBankCode? AppConstants.unionBankTitle:""}", style: size14weight700.copyWith(color: colors(context).primaryColor),),
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
                                    padding: const EdgeInsets.fromLTRB(16,0,16,0).w,
                                    child: Column(
                                      children: [
                                        FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("paid_from"),
                                            data: widget.fundTransferReceiptViewArgs.fundTransferEntity.payFromName ?? "-",
                                            subData: payFromNum
                                        ),
                                        FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("pay_to"),
                                            data: widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctname ?? "-",
                                            subData: payToNum
                                        ),
                                        if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER)
                                          FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("to_account_name"),
                                            data: widget.fundTransferReceiptViewArgs.fundTransferEntity.name ?? "-",
                                          ),
                                        if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNRECUURING ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING)
                                          Column(
                                            children: [
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context).translate("schedule_type"),
                                                data: "Repeat",
                                              ),
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context).translate("schedule_start_date"),
                                                data: widget.fundTransferReceiptViewArgs.fundTransferEntity.startDate ?? "-",
                                              ),
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context).translate("frequency"),
                                                data:AppLocalizations.of(context).translate (widget.fundTransferReceiptViewArgs.fundTransferEntity.scheduleFrequency??"daily"),
                                              ),
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context).translate("schedule_end_date"),
                                                data: widget.fundTransferReceiptViewArgs.fundTransferEntity.endDate ?? "-",
                                              ),
                                            ],
                                          ),
                                        if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNNOW ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW)
                                          FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("date_&_time"),
                                            data: "${DateFormat('dd-MMMM-yyyy | hh:mm a').format(dateTime)}",
                                          ),
                                        if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNLATER ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER ||
                                            widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER)
                                          FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("transaction_due_date"),
                                            data: widget.fundTransferReceiptViewArgs.fundTransferEntity.transactionDate ?? "-",
                                          ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("remarks"),
                                          data: widget.fundTransferReceiptViewArgs.fundTransferEntity.remark == null || widget.fundTransferReceiptViewArgs.fundTransferEntity.remark == "" ? "-" : widget.fundTransferReceiptViewArgs.fundTransferEntity.remark ?? "-",
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("transaction_category"),
                                          data: widget.fundTransferReceiptViewArgs.fundTransferEntity.transactionCategory ?? "-",
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("service_charge"),
                                          amount: widget.fundTransferReceiptViewArgs.fundTransferEntity.serviceCharge,
                                          isCurrency: true,
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("reference_number"),
                                          isLastItem: true,
                                          data: widget.fundTransferReceiptViewArgs.fundTransferEntity.tranId ?? widget.fundTransferReceiptViewArgs.fundTransferEntity.reference ?? "-",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNNOW ||
                                    widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW ||
                                    widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12 , bottom: 12),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 53),
                                            child: GestureDetector(
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
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 39),
                                            child: GestureDetector(
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
                                              //      backgroundColor: Colors.transparent,
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
                                              //                                 Text(AppLocalizations.of(context).translate("excel"), style: size14weight700.copyWith(color: colors(context).primaryColor),)
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
                                              //
                                              //               ],
                                              //             );
                                              //           }
                                              //       ));
                                              //   setState(() {});
                                              // },
                                              // //     () {
                                              // //   _showBottomSheet(context);
                                              // // },
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if(widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW ||
                                    widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER ||
                                    widget.fundTransferReceiptViewArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING)
                                  Column(
                                    children: [
                                      16.verticalSpace,
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16).w,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, Routes.kFDsavePayeeView,
                                                      arguments: FundTransferReceiptViewArgs(
                                                          fundTransferEntity: widget
                                                              .fundTransferReceiptViewArgs
                                                              .fundTransferEntity));
                                                },
                                                child: Row(
                                                  children: [
                                                    PhosphorIcon(PhosphorIcons.floppyDisk(PhosphorIconsStyle.bold),
                                                      color: colors(context).primaryColor,
                                                    ),
                                                    24.horizontalSpace,
                                                    Center(
                                                      child: Text(
                                                          AppLocalizations.of(context).translate("save_as_payee"),
                                                          style: size14weight700.copyWith(color: colors(context).primaryColor)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          ))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0.w,20.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
                    child: Column(
                      children: [
                        AppButton(
                            buttonText: AppLocalizations.of(context).translate("make_another_transfer"),
                            onTapButton: () {
                              Navigator.pushNamedAndRemoveUntil(
                            context,Routes.kFundTransferNewView,
                            arguments: RequestMoneyValues(),
                                (Route<dynamic> route) => route.settings.name == widget.fundTransferReceiptViewArgs.fundTransferEntity.route,
                          );
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("home"),
                          onTapButton: () {
                           Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }


  _downloadEReceipt(bool shouldStore) {
    bloc.add(
      FundTransferReceiptDownloadEvent(
          transactionId:
              widget.fundTransferReceiptViewArgs.fundTransferEntity.tranId,
          shouldOpen: shouldStore,
          transactionType: 'FT',
          messageType: 'fundTransferAndBillPaymentPDFDownload'),
    );
    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  _downloadExcelReceipt(bool shouldStore) {
    bloc.add(
      FundTransferExcelDownloadEvent(
          transactionId:
              widget.fundTransferReceiptViewArgs.fundTransferEntity.tranId,
          shouldOpen: shouldStore,
          transactionType: 'FT',
          messageType: 'fundTransferAndBillPaymentPDFDownload'),
    );
    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}


// String formatNumber(String number) {
//   if (number.isEmpty) return number;
//
//   int firstGroupLength = number.length % 4;
//   String formattedNumber;
//
//   if (firstGroupLength == 0) {
//     formattedNumber = number.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ').trim();
//   } else {
//     formattedNumber = number.substring(0, firstGroupLength) +
//         ' ' +
//         number.substring(firstGroupLength).replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ').trim();
//   }
//
//   return formattedNumber.trim();
// }
