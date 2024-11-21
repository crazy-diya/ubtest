import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/account_transaction_history_details_view.dart';


import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_unbuild_content.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';


import '../../../data/models/responses/account_transaction_history_response.dart';
import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_event.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class AccountTransactionHistoryArgs {
  final String? title;
  final String? accNumber;
  final String? balance;
  final String? accName;
  final String? accountType;
  final String? currency;

  AccountTransactionHistoryArgs({
    this.title,
    this.accNumber,
    this.balance,
    this.accName,
    this.accountType,
    this.currency
  });
}

class PortfolioAccountTransactionHistoryView extends BaseView {
  final AccountTransactionHistoryArgs accountTransactionHistoryArgs;

  PortfolioAccountTransactionHistoryView(
      {required this.accountTransactionHistoryArgs});

  @override
  _PortfolioAccountTransactionHistoryViewState createState() =>
      _PortfolioAccountTransactionHistoryViewState();
}

class _PortfolioAccountTransactionHistoryViewState
    extends BaseViewState<PortfolioAccountTransactionHistoryView> {
  var bloc = injection<PortfolioBloc>();

  List<RecentTransactionList> tranHistory = [];
  Download download = Download.NON;

  int? size = 10;
  int pageNumberTran = 0;
  int? countL;


  double? totalCreditAmount = 0.0;

  double? totalDebitAmount = 0.0;


  late final _scrollControllerTran = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollControllerTran.addListener(_onScrollTran);
    _loadInitialData();
  }

  void _loadInitialData() {
    bloc.add(AccountTransactionsEvent(
      accountType: widget.accountTransactionHistoryArgs.accountType!,
      size: 10,
      page: 0,
      accountNo: widget.accountTransactionHistoryArgs.accNumber!,
      messageType: "portfolioRequest",
    ));

  }

  // void _onScrollTran() {
  //   if(countL !=tranHistory.length){
  //   final maxScroll = _scrollControllerTran.position.maxScrollExtent;
  //   final currentScroll = _scrollControllerTran.position.pixels;
  //   if (maxScroll - currentScroll == 0) {
  //     pageNumberTran++;
  //       bloc.add(AccountTransactionsEvent(
  //           accountType: widget.accountTransactionHistoryArgs.accountType!,
  //           size: 10,
  //           page: pageNumberTran,
  //           accountNo: widget.accountTransactionHistoryArgs.accNumber!,
  //           messageType: "portfolioRequest",
  //         ));
  //   }
  //   }
  // }



  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        // title: AppLocalizations.of(context).translate("loan_payment_history"),
        title: AppLocalizations.of(context).translate("recent_transactions"),
      ),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is AccountTransactionsSuccessState) {
              setState(() {
                totalCreditAmount = state.totalCreditAmount;
                totalDebitAmount = state.totalDebitAmount;
                 if (pageNumberTran == 0) {
                  tranHistory = state.accountTransactions!;
                } else {
                  tranHistory.addAll(state.accountTransactions!);
                }
                countL = state.count;
              });
            }
            else if (state is AccountTransactionPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo 10trxn",
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
            else if (state is AccountTransactionExcelDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo 10trxn",
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
            else if(state is AccountTransactionsFailedState){
               ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);

            }
            else if(state is AccountTransactionPdfDownloadFailedState){
              ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);

            }
            else if(state is AccountTransactionExcelDownloadFailedState){
              ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);

            }
          },
          child:
          Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.w),
            child:
            Column(
              children: [
                if(tranHistory.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: colors(context).secondaryColor300,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: PhosphorIcon(
                                PhosphorIcons.article(PhosphorIconsStyle.bold),
                                color: colors(context).whiteColor,
                                size: 28,
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate("filterd_empty_mail_title"),
                            style: size18weight700.copyWith(color: colors(context).blackColor),
                            textAlign: TextAlign.center,
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate("no_recent_activities_description"),
                            style: size14weight400.copyWith(color: colors(context).greyColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                if(tranHistory.isNotEmpty)
                  Expanded(
                    child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0).w,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).greyColor50,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0).w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.accountTransactionHistoryArgs.currency == null || widget.accountTransactionHistoryArgs.currency == "" ? AppLocalizations.of(context).translate("lkr") : widget.accountTransactionHistoryArgs.currency} ${
                                            totalCreditAmount
                                                .toString()
                                                .withThousandSeparator()
                                        }",
                                        style: size14weight700.copyWith(color: colors(context).positiveColor),
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context).translate("total_of_last")} ${ tranHistory.length } ${AppLocalizations.of(context).translate("credit")}",
                                        style: size12weight400.copyWith(color: colors(context).greyColor),
                                      ),

                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 42.h,
                                    color: colors(context).greyColor200,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.accountTransactionHistoryArgs.currency == null || widget.accountTransactionHistoryArgs.currency == "" ? AppLocalizations.of(context).translate("lkr") : widget.accountTransactionHistoryArgs.currency} ${
                                            totalDebitAmount
                                                .toString()
                                                .withThousandSeparator()
                                        }",
                                        style: size14weight700.copyWith(color: colors(context).negativeColor),
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context).translate("total_of_last")} ${ tranHistory.length } ${AppLocalizations.of(context).translate("debit")}",
                                        style: size12weight400.copyWith(color: colors(context).greyColor),
                                      ),

                                    ],
                                  ),

                            ],
                          ),
                        ),
                      ),
                    ),),
                                    // UBPortfolioContainerDefaultColored(
                                    //   title: widget.accountTransactionHistoryArgs.title!,
                                    //   amount: widget.accountTransactionHistoryArgs.balance!,
                                    //   subTitle: widget.accountTransactionHistoryArgs.accNumber!,
                                    //   category: 'account',
                                    // ),
                                    16.verticalSpace,
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
                                  onTap: () async {
                                    final result = await showModalBottomSheet<bool>(
                                        isScrollControlled: true,
                                        useRootNavigator: true,
                                        useSafeArea: true,
                                        context: context,
                                        barrierColor: colors(context).blackColor?.withOpacity(.85),
                                        backgroundColor: Colors.transparent,
                                        builder: (context,) => StatefulBuilder(
                                            builder: (context,changeState) {
                                              return BottomSheetBuilder(
                                                isAttachmentSheet: true,
                                                title: AppLocalizations.of(context).translate('download'),
                                                buttons: [
                                                  // Expanded(
                                                  //   child: AppButton(
                                                  //       buttonType: download == Download.NON ? ButtonType.OUTLINEDISABLED : ButtonType.PRIMARYENABLED,
                                                  //       buttonText: AppLocalizations.of(context) .translate("download"),
                                                  //       onTapButton: () {
                                                  //         download == Download.PDF
                                                  //             ? _downloadEReceipt(true)
                                                  //             : _downloadExcelReceipt(true);
                                                  //         Navigator.pop(context);
                                                  //         changeState(() {});
                                                  //         setState(() {});
                                                  //       }),
                                                  // ),
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
                                                                _downloadEReceipt(true);
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
                                            }
                                        ));
                                    setState(() {});
                                  },
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
                              ),
                            ],
                          ),
                        ),
                      ),
                                    16.verticalSpace,
                                    Expanded(
                                        child:  SingleChildScrollView(
                                           physics: ClampingScrollPhysics(),
                                            child: Padding(
                                             padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                                                child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16.w,16.h,16.w,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                // SizedBox(
                                //   height: 3.h,
                                //   child: Visibility(
                                //     visible: tranHistory.isNotEmpty,
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         GestureDetector(
                                //           onTap: () {
                                //             _downloadEReceipt(false);
                                //           },
                                //           child: Row(
                                //             children: [
                                //               Image.asset(
                                //                 AppAssets.icShareIcon,
                                //                 scale: 3,
                                //               ),
                                //               SizedBox(
                                //                 width: 3.w,
                                //               ),
                                //               Text(
                                //                 AppLocalizations.of(context)
                                //                     .translate("share"),
                                //                 style: TextStyle(
                                //                   fontSize: 18,
                                //                   fontWeight: FontWeight.w600,
                                //                   color:
                                //                       colors(context).secondaryColor300,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         SizedBox(
                                //           width: 3.w,
                                //         ),
                                //         VerticalDivider(
                                //           color: colors(context).secondaryColor300,
                                //           thickness: 1,
                                //         ),
                                //         SizedBox(
                                //           width: 3.w,
                                //         ),
                                //         GestureDetector(
                                //           onTap: () {
                                //             _showBottomSheet(context);
                                //           },
                                //           child: Container(
                                //             child: Row(
                                //               children: [
                                //                 Image.asset(
                                //                   AppAssets.icDwnldIcon,
                                //                   scale: 3,
                                //                 ),
                                //                 SizedBox(
                                //                   width: 3.w,
                                //                 ),
                                //                 Text(
                                //                   AppLocalizations.of(context)
                                //                       .translate("download"),
                                //                   style: TextStyle(
                                //                     fontSize: 18,
                                //                     fontWeight: FontWeight.w600,
                                //                     color:
                                //                         colors(context).secondaryColor300,
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                      Text(
                                          "${tranHistory.length} ${AppLocalizations.of(context).translate("results")}",
                                          style: size16weight700.copyWith(color: colors(context).blackColor)
                                      ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  controller: _scrollControllerTran,
                                  itemCount: tranHistory.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            Routes.kPortfolioTransactionHistoryStatusView,
                                            arguments: TransactionDetailsArgs(
                                                paidFromAccName: tranHistory[index].fromAccountName,
                                                paidFromAccNum: tranHistory[index].fromAccountNumber,
                                                paidToAccName:
                                                    tranHistory[index].toAccountName,
                                                paidToAccNum:
                                                    tranHistory[index].toAccountNumber,
                                                amount: tranHistory[index]
                                                    .amount
                                                    .toString(),
                                                serviceCharge: tranHistory[index]
                                                    .serviceFee
                                                    .toString(),
                                                category: tranHistory[index].txnType,
                                                remarks: tranHistory[index].remarks,
                                                mobile: tranHistory[index].mobileNumber,
                                                date: tranHistory[index]
                                                    .createdDate
                                                    .toString(),
                                                referenceId:
                                                    tranHistory[index].reference,
                                                tranId:
                                                    tranHistory[index].transactionId,
                                                currency: widget.accountTransactionHistoryArgs.currency,
                                                email: tranHistory[index].email));
                                      },
                                      child: Column(
                                        children: [
                                          UBPortfolioUnbuildContent(
                                            title: tranHistory[index].txnType,
                                            subTitle: tranHistory[index].reference,
                                            data: tranHistory[index].amount.toString().withThousandSeparator(),
                                            subData: tranHistory[index].txnTime,
                                            isCR: tranHistory[index].crDr,
                                            currency: widget.accountTransactionHistoryArgs.currency,
                                          ),
                                          if(tranHistory.length-1 != index)
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                              color: colors(context).greyColor100,
                                            )
                                        ],
                                      ),
                                    );
                                  },
                                ),],),
                              ),
                            ),
                      ),
                        )
                      ),
                      // if (tranHistory.isNotEmpty)
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Image.asset(
                      //               AppAssets.icGreenDot,
                      //               scale: 3,
                      //             ),
                      //             const SizedBox(
                      //               height: 5,
                      //             ),
                      //             Text(
                      //               AppLocalizations.of(context)
                      //                   .translate("total_credit_amount"),
                      //               style: TextStyle(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: colors(context).blackColor,
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 5,
                      //             ),
                      //               SingleChildScrollView(
                      //                     scrollDirection: Axis.horizontal,
                      //                 child: Row(
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     Image.asset(
                      //                       AppAssets.icLkrFrme,
                      //                       scale: 3,
                      //                     ),
                      //                   const SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                   Text(
                      //                       totalCreditAmount
                      //                           .toString()
                      //                           .withThousandSeparator(),
                      //                       style: TextStyle(
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w600,
                      //                         color: colors(context).blackColor,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Image.asset(
                      //               AppAssets.icRedDot,
                      //               scale: 3,
                      //             ),
                      //             const SizedBox(
                      //               height: 5,
                      //             ),
                      //             Text(
                      //               "Total Debit Amount",
                      //               style: TextStyle(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: colors(context).blackColor,
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 5,
                      //             ),
                      //             SingleChildScrollView(
                      //                     scrollDirection: Axis.horizontal,
                      //               child: Row(
                      //                 children: [
                      //                   Image.asset(
                      //                     AppAssets.icLkrFrme,
                      //                     scale: 3,
                      //                   ),
                      //                   const SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                   Text(
                      //                       totalDebitAmount.toString().withThousandSeparator(),
                      //                       style: TextStyle(
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w600,
                      //                         color: colors(context).blackColor,
                      //                       ),
                      //                     ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],),
                  ),
              ],
            )
          )
        ),
      ),
    );
  }


  _downloadEReceipt(bool shouldStore) {

    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        AccountTransactionPdfDownloadEvent(
          accountNumber: widget.accountTransactionHistoryArgs.accNumber,
          accountType: widget.accountTransactionHistoryArgs.accountType,
          shouldOpen: shouldStore,
        ),
      );

    });
  }

  _downloadExcelReceipt(bool shouldStore) {


    AppPermissionManager.requestExternalStoragePermission(context, () { bloc.add(
      AccountTransactionExcelDownloadEvent(
        accountNumber: widget.accountTransactionHistoryArgs.accNumber,
          accountType: widget.accountTransactionHistoryArgs.accountType,
          shouldOpen: shouldStore,
        ),
    );});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
