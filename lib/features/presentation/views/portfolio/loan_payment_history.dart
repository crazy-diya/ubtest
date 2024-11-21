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
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/loan&lease_history_component.dart';


import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';


import '../../../data/models/responses/loan_history_response.dart';
import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_event.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class LoanDetailsHistoryArgs {
  final String? loanTitle;
  final String? loanAmount;
  final String? loanNumber;
  final String currency;

  LoanDetailsHistoryArgs({
    this.loanTitle,
    this.loanAmount,
    this.loanNumber,
    required this.currency,
  });
}

class PortfolioLoanPaymentHistoryView extends BaseView {
  final LoanDetailsHistoryArgs loanDetailsArgs;

  PortfolioLoanPaymentHistoryView({required this.loanDetailsArgs});

  @override
  _PortfolioLoanPaymentHistoryViewState createState() =>
      _PortfolioLoanPaymentHistoryViewState();
}

class _PortfolioLoanPaymentHistoryViewState
    extends BaseViewState<PortfolioLoanPaymentHistoryView> {
  var bloc = injection<PortfolioBloc>();

  List<LoanHistoryResponseDto> history = [];
  Download download = Download.NON;

  int? size = 10;
  int? countL;
   int pageNumberTran = 0;


  late final _scrollControllerTran = ScrollController();

  @override
  void initState() {
    super.initState();
      _scrollControllerTran.addListener(_onScrollTran);

    _loadInitialData();
  }

  void _loadInitialData() {
    bloc.add(LoanHistoryEvent(
        accountNo: widget.loanDetailsArgs.loanNumber!,
        messageType: 'portfolioRequest',
        page: pageNumberTran,
        size: 10));
  }

    void _onScrollTran() {
    if(countL !=history.length){
    final maxScroll = _scrollControllerTran.position.maxScrollExtent;
    final currentScroll = _scrollControllerTran.position.pixels;
    if (maxScroll - currentScroll == 0) {
      pageNumberTran++;
       bloc.add(LoanHistoryEvent(
        accountNo: widget.loanDetailsArgs.loanNumber!,
        messageType: 'portfolioRequest',
        page: pageNumberTran,
        size: 10));
    }
    }
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("loan_payment_history"),
      ),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is LoanHistorySuccessState) {
               setState(() {
                if (pageNumberTran == 0) {
                  history = state.history!;
                } else {
                  history.addAll(state.history!);
                }

                countL = state.count;
               });

              // Navigator.pushNamed(
              //     context, Routes.kApplyPersonalLoanView);
            }
            else if (state is AccountStatementsPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo Loan ${DateFormat('dd.MM.yyyy').format(history.first.transactionDateTime!)} - ${DateFormat('dd.MM.yyyy').format(history.last.transactionDateTime!)}",
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
            else if (state is LoanHistoryExcelDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo Loan ${DateFormat('dd.MM.yyyy').format(history.first.transactionDateTime!)} - ${DateFormat('dd.MM.yyyy').format(history.last.transactionDateTime!)}",
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
            else if (state is LoanHistoryFailedState) {
              ToastUtils.showCustomToast(
                        context, state.message??AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              // Navigator.pushNamed(
              //     context, Routes.kApplyPersonalLoanView);
            }
            else if (state is AccountStatementsPdfDownloadFailedState) {
             ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
            else if (state is LoanHistoryExcelDownloadFailedState) {
              ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
          },
          child: Stack(
            children: [
              if(history.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors(context).secondaryColor300,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
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
                          AppLocalizations.of(context).translate("adjust_your_filters"),
                          style: size14weight400.copyWith(color: colors(context).greyColor),
                          textAlign: TextAlign.center,
                        ),
                        // 317.verticalSpace,
                      ],
                    ),
                  ),
             if(history.isNotEmpty) Padding(
                padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h),
                child: Column(
                  children: [
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
                    // UBPortfolioContainerDefaultColored(
                    //   title: widget.loanDetailsArgs.loanTitle!,
                    //   amount: widget.loanDetailsArgs.loanAmount!.withThousandSeparator(),
                    //   subTitle: widget.loanDetailsArgs.loanNumber!,
                    //   category: 'loan',
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         _downloadEReceipt(false);
                    //       },
                    //       child: Container(
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
                    //                 color: colors(context)
                    //                     .primaryColor,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 3.w,
                    //     ),
                    //     VerticalDivider(
                    //       color: colors(context).secondaryColor300,
                    //       thickness: 1,
                    //     ),
                    //     SizedBox(
                    //       width: 3.w,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         _showBottomSheet(context);
                    //       },
                    //       child: Container(
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
                    //                 color: colors(context)
                    //                     .primaryColor,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w , right: 16.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _scrollControllerTran,
                                itemCount: history.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Column(
                                      children: [
                                        UBPortfolioUnbuildLoanLeaseContent(
                                          title: history[index].description??"",
                                          subTitle: history[index].referenceNumber??"",
                                          data: history[index].transactionAmount.toString().withThousandSeparator(),
                                          subData: history[index].transactionDateTime,
                                          isLoan: true,
                                          currency: widget.loanDetailsArgs.currency,
                                        ),
                                        if(history.length-1 != index)
                                          Divider(
                                            height: 0,
                                            thickness: 1,
                                            color: colors(context).greyColor100,
                                          )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // _downloadEReceipt(bool shouldStore) {
  //   AppPermissionManager.requestExternalStoragePermission(context, () {
  //     bloc.add(
  //       LoanHistoryPdfDownloadEvent(
  //         accountNumber: widget.loanDetailsArgs.loanNumber,
  //         shouldOpen: shouldStore,
  //       ),
  //     );
  //   });
  // }

  _downloadEReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {

        bloc.add(
          LoanHistoryPdfDownloadEvent(
            accountNumber: widget.loanDetailsArgs.loanNumber,
            shouldOpen: shouldStore,
          ),
        );

    });
  }

  _downloadExcelReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        LoanHistoryExcelDownloadEvent(
          loanNumber: widget.loanDetailsArgs.loanNumber,
          shouldOpen: shouldStore,
        ),
      );
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
