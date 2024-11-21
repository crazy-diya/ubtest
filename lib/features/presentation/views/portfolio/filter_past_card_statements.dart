import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_bloc.dart';

import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_unbuild_content.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';

import '../../../../utils/app_sizer.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../data/models/responses/past_card_statement_response.dart';
import '../../bloc/portfolio/portfolio_event.dart';
import '../../bloc/portfolio/portfolio_state.dart';

import '../../widgets/bottom_sheet.dart';

import '../../widgets/toast_widget/toast_widget.dart';
import '../../widgets/ub_radio_button.dart';
import '../base_view.dart';

class AccountNumberArgs {
  String accountNumber;

  AccountNumberArgs({
    required this.accountNumber,
  });
}

class PastCardStatementsFilterView extends BaseView {
  final AccountNumberArgs accountNumberArgs;

  PastCardStatementsFilterView({required this.accountNumberArgs});

  @override
  _PastCardStatementsFilterViewState createState() =>
      _PastCardStatementsFilterViewState();
}

class _PastCardStatementsFilterViewState
    extends BaseViewState<PastCardStatementsFilterView> {
  var bloc = injection<PortfolioBloc>();
  String? month;
  String? monthTemp;
  int? monthKey;
  int? monthKeyTemp;
  int? monthToAPI;
  String? year;
  String? yearToAPI;
  String? yearTemp;
  String? titleA;
  String? subTitleA;
  String? dataA;
  String? subDataA;
  bool isMonthFilled = false;
  bool isYearFilled = false;
  bool isStatementVisible = false;
  bool isMonthTwoDigit = false;

  List<PrimaryTxnDetail> statements = [];

  Download download = Download.NON;

  @override
  void initState() {
    super.initState();
    updateValues();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("past_card_statements"),
      ),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is PastCardStatementsSuccessState) {
              setState(() {
                statements.clear();
                statements.addAll(state.statements!);
                if(statements.isNotEmpty){
                  isStatementVisible = true;
                  setState(() {

                  });
                } else {
                  isStatementVisible = false;
                  setState(() {

                  });
                }
              });
            }
            if ( state is PastCardStatementsFailedState){
              isStatementVisible = false;
             if(state.errorCode == "02"){
               showAppDialog(
                 title: AppLocalizations.of(context).translate("invalid_date_range"),
                 alertType: AlertType.FAIL,
                 message: state.message ?? AppLocalizations.of(context).translate("fail"),
                 positiveButtonText: AppLocalizations.of(context).translate("ok"),
                 onPositiveCallback: () {
                 },
               );
             } else {
               showAppDialog(
                 title: AppLocalizations.of(context).translate("something_went_wrong"),
                 alertType: AlertType.FAIL,
                 message: state.message ?? AppLocalizations.of(context).translate("fail"),
                 positiveButtonText: AppLocalizations.of(context).translate("ok"),
                 onPositiveCallback: () {
                 },
               );
             }
              setState(() {});
            }
            else if (state is CardSTPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo CCstat",
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
            else if (state is AccountStatementsPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo CCstat",
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
            else if (state is CardSTPdfDownloadFailedState) {
              ToastUtils.showCustomToast(
                        context, state.message?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
            else if (state is PastCardStatementsPdfDownloadFailedState) {
              ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
            else if (state is AccountStatementsPdfDownloadFailedState) {
                ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h+ AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0).w,
                          child: Column(
                            children: [
                              AppDropDown(
                                initialValue: year,
                                onTap: () async{
                                  statements.clear();
                                  final result = await showModalBottomSheet<bool>(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                      backgroundColor: Colors.transparent,
                                      builder: (context,) =>
                                          StatefulBuilder(
                                              builder: (context, changeState) {
                                                return BottomSheetBuilder(
                                                  title: AppLocalizations.of(context).translate("select_year"),
                                                  buttons: [
                                                    Expanded(
                                                      child: AppButton(
                                                          buttonType: ButtonType.PRIMARYENABLED,
                                                          buttonText: AppLocalizations.of(context).translate("continue"),
                                                          onTapButton: () {
                                                            year = yearTemp;
                                                            yearToAPI = yearTemp;
                                                            yearToAPI = yearToAPI?.substring(yearToAPI!.length - 2);
                                                            isYearFilled = true;
                                                            if (isMonthFilled) {
                                                              bloc.add(
                                                                  PastCardStatementEvent(
                                                                    maskedPrimaryCardNumber: widget.accountNumberArgs.accountNumber,
                                                                    billMonth: isMonthTwoDigit == true ? "$yearToAPI$monthToAPI" : "$yearToAPI${"0"}$monthToAPI",
                                                                  ));
                                                            }
                                                            changeState(() {});
                                                            setState(() {});
                                                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                            Navigator.of(context).pop(true);
                                                          }),
                                                    ),
                                                  ],
                                                  children: [
                                                    ListView.builder (
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: AppConstants.kYearList.length,
                                                      shrinkWrap: true,
                                                       padding: EdgeInsets.zero,
                                                      itemBuilder: (context, index) {
                                                        return InkWell(
                                                          onTap: (){
                                                            yearTemp = AppConstants.kYearList[index].description;
                                                            changeState(() {});
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.fromLTRB(0,index == 0 ?0:24.h,0,24.h),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      AppConstants.kYearList[index].description!,
                                                                      style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(right: 8).w,
                                                                      child: UBRadio<dynamic>(
                                                                        value: AppConstants.kYearList[index].description ?? "",
                                                                        groupValue: yearTemp,
                                                                        onChanged: (value) {
                                                                          yearTemp = AppConstants.kYearList[index].description;
                                                                          changeState(() {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if(AppConstants.kYearList.length-1 != index)
                                                                Divider(
                                                                  thickness: 1,
                                                                  height:0,
                                                                  color: colors(context).greyColor100,
                                                                )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                );
                                              }
                                          ));
                                  setState(() {});
                                  // Navigator.pushNamed(context, Routes.kDropDownView,
                                  //     arguments: DropDownViewScreenArgs(
                                  //       isSearchable: false,
                                  //       pageTitle: AppLocalizations.of(context).translate("year"),
                                  //       dropDownEvent: GetYearEvent(),
                                  //     )).then((value) {
                                  //   if (value != null &&
                                  //       value is CommonDropDownResponse) {
                                  //     setState(() {
                                  //       year = value.description;
                                  //       isYearFilled = true; // Set the isYearFilled to true when a value is selected.
                                  //     });
                                  //     if (isMonthFilled) {
                                  //       bloc.add(
                                  //         PastCardStatementEvent(
                                  //             accountNo: widget.accountNumberArgs.accountNumber,
                                  //             month: monthKey!,
                                  //             page: 0,
                                  //             size: 20,
                                  //             year: int.parse(year!),
                                  //             messageType: "creditCardTxnDetails"),
                                  //       );
                                  //     }
                                  //   }
                                  // });
                                },
                                labelText: AppLocalizations.of(context).translate("select_year"),
                                label: AppLocalizations.of(context).translate("year"),
                              ),
                              24.verticalSpace,
                              AppDropDown(
                                initialValue: month,
                                label: AppLocalizations.of(context).translate("month"),
                                onTap: () async{
                                  statements.clear();
                                  final result = await showModalBottomSheet<bool>(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                      backgroundColor: Colors.transparent,
                                      builder: (context,) =>
                                          StatefulBuilder(
                                              builder: (context, changeState) {
                                                return BottomSheetBuilder(
                                                  title: AppLocalizations.of(context).translate("select_month"),
                                                  buttons: [
                                                    Expanded(
                                                      child: AppButton(
                                                          buttonType: ButtonType.PRIMARYENABLED,
                                                          buttonText: AppLocalizations.of(context).translate("continue"),
                                                          onTapButton: () {
                                                            month = monthTemp;
                                                            monthKey = monthKeyTemp;
                                                            isMonthFilled = true;
                                                            if (monthToAPI! > 9) {
                                                              isMonthTwoDigit = true;
                                                              setState(() {});
                                                            } else {
                                                              monthToAPI = int.parse('0$monthToAPI');
                                                              isMonthTwoDigit = false;
                                                              setState(() {});
                                                            }
                                                            if (isYearFilled) {
                                                              bloc.add(
                                                                  PastCardStatementEvent(
                                                                    maskedPrimaryCardNumber: widget.accountNumberArgs.accountNumber,
                                                                    billMonth: isMonthTwoDigit == true ? "$yearToAPI$monthToAPI" : "$yearToAPI${"0"}$monthToAPI",
                                                                  ));
                                                            }
                                                            changeState(() {});
                                                            setState(() {});
                                                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                            Navigator.of(context).pop(true);
                                                          }),
                                                    ),
                                                  ],
                                                  children: [
                                                    ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: AppConstants.kMonthList.length,
                                                      shrinkWrap: true,
                                                       padding: EdgeInsets.zero,
                                                      itemBuilder: (context, index) {
                                                        return InkWell(
                                                          onTap: (){
                                                            monthTemp = AppConstants.kMonthList[index].description;
                                                            monthKeyTemp = AppConstants.kMonthList[index].id;
                                                            monthToAPI = int.parse(AppConstants.kMonthList[index].key ?? "0");
                                                            changeState(() {});
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.fromLTRB(0,index == 0 ?0:24.h,0,24.h),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      AppConstants.kMonthList[index].description!,
                                                                      style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(right: 8).w,
                                                                      child: UBRadio<dynamic>(
                                                                        value: AppConstants.kMonthList[index].description ?? "",
                                                                        groupValue: monthTemp,
                                                                        onChanged: (value) {
                                                                          monthTemp = AppConstants.kYearList[index].description;
                                                                          monthKeyTemp = AppConstants.kYearList[index].id;
                                                                          changeState(() {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if(AppConstants.kMonthList.length-1 != index)
                                                                Divider(
                                                                  thickness: 1,
                                                                  height:0,
                                                                  color: colors(context).greyColor100,
                                                                )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                );
                                              }
                                          ));
                                  setState(() {});
                                },
                                //     () {
                                //   Navigator.pushNamed(context, Routes.kDropDownView,
                                //       arguments: DropDownViewScreenArgs(
                                //         isSearchable: false,
                                //         pageTitle: AppLocalizations.of(context).translate("month"),
                                //         dropDownEvent: GetMonthEvent(),
                                //       )).then((value) {
                                //     if (value != null &&
                                //         value is CommonDropDownResponse) {
                                //       setState(() {
                                //         month = value.description;
                                //         monthKey = value.id;
                                //         isMonthFilled = true; // Set the isMonthFilled to true when a value is selected.
                                //       });
                                //       if (isYearFilled) {
                                //         bloc.add(
                                //           PastCardStatementEvent(
                                //               accountNo: widget.accountNumberArgs.accountNumber,
                                //               month: monthKey!,
                                //               page: 0,
                                //               size: 10,
                                //               year: int.parse(year!),
                                //               messageType: "creditCardTxnDetails"),
                                //         );
                                //       }
                                //     }
                                //   });
                                // },
                                labelText: AppLocalizations.of(context).translate("select_month"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      if(isStatementVisible == true)
                        Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
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
                                                            padding: const EdgeInsets.all(16).w,
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
                                                                        0.96.horizontalSpace,
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
                                                                        0.96.horizontalSpace,
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
                                    ],
                                  ),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     IconButton(
                              //       onPressed: () {
                              //         _showBottomSheet(context);
                              //       },
                              //       icon: Icon(
                              //         Icons.download_rounded,
                              //         color:
                              //             colors(context).secondaryColor300,
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         _showBottomSheet(context);
                              //       },
                              //       child: Text(
                              //         AppLocalizations.of(context)
                              //             .translate("download"),
                              //         style: TextStyle(
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.w600,
                              //           color: colors(context)
                              //               .secondaryColor,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              16.verticalSpace,
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.w,0.h,16.w,0.h),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: statements.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: UBPortfolioUnbuildContent(
                                                title: statements[index].resTransDesc,
                                                subTitle: statements[index].resRefNo,
                                                data: statements[index].resTxnAmount?.replaceAll('-', '').withThousandSeparator(),
                                                subData: statements[index].resTransPostDate,
                                                isCR:statements[index].resDebitsCreditIndicator,
                                              ),
                                            ),
                                            if(statements.length-1 != index)
                                              Divider(
                                                thickness: 1,
                                                color: colors(context).greyColor100,
                                              )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isStatementVisible == false,
                  child: Column(
                    children: [
                      AppButton(
                        buttonType: isYearFilled && isMonthFilled
                            ? ButtonType.PRIMARYENABLED // Enable the button when both dropdowns have values.
                            : ButtonType.PRIMARYDISABLED,
                        // Disable the button when either dropdown is empty.
                        buttonText: AppLocalizations.of(context).translate("confirm"),
                        onTapButton: () {
                          bloc.add(
                              PastCardStatementEvent(
                                maskedPrimaryCardNumber: widget.accountNumberArgs.accountNumber,
                                billMonth: isMonthTwoDigit == true ? "$yearToAPI$monthToAPI" : "$yearToAPI${"0"}$monthToAPI",
                              ));
                          setState(() {
                          });
                        },
                      ),
                      // AppSizer.verticalSpacing(20.h + AppSizer.getHomeIndicatorStatus(context))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateValues() {
    final int currentYear = DateTime.now().year;
    AppConstants.kYearList.addAll(List<CommonDropDownResponse>.generate(
        21,
        (index) => CommonDropDownResponse(
            id: (currentYear - 20 + index),
            description: (currentYear - 20 + index).toString())).reversed);
  }


  _downloadEReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        CardSTPdfDownloadEvent(
          maskedPrimaryCardNumber: widget.accountNumberArgs.accountNumber,
          billMonth: isMonthTwoDigit == true ? "$yearToAPI$monthToAPI" : "$yearToAPI${"0"}$monthToAPI",
          shouldOpen: shouldStore,
        ),
      );
    });
  }

  _downloadExcelReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        PastCardExcelDownloadEvent(
          maskedPrimaryCardNumber: widget.accountNumberArgs.accountNumber,
          billMonth: isMonthTwoDigit == true ? "$yearToAPI$monthToAPI" : "$yearToAPI${"0"}$monthToAPI",
          shouldOpen: shouldStore,
        ),
      );
    });
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
                isSearch: false,
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
                  //           ? _downloadEReceipt(true)
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
            }));
    setState(() {});
    // showModalBottomSheet(
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    //     ),
    //     context: context,
    //     builder: (context) {
    //       return StatefulBuilder(builder: (BuildContext context,
    //           StateSetter setState /*You can rename this!*/) {
    //         return SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.4,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   AppLocalizations.of(context)
    //                       .translate("select_downloading_option"),
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.w600,
    //                     color: colors(context).blackColor,
    //                   ),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     InkWell(
    //                       onTap: () {
    //                         setState(() {
    //                           download =
    //                               Download.EX; // Update the selected option
    //                         });
    //                       },
    //                       child: Material(
    //                         borderRadius: BorderRadius.circular(8),
    //                         color: download == Download.EX
    //                             ? const Color(
    //                                 0xffD9D9D9) // Set color when selected
    //                             : Colors.transparent,
    //                         child: SizedBox(
    //                           width: 100,
    //                           height: 100,
    //                           child: Center(
    //                             child: Image.asset(
    //                               AppAssets.icExcel,
    //                               scale: 3,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     InkWell(
    //                       onTap: () {
    //                         setState(() {
    //                           download =
    //                               Download.PDF; // Update the selected option
    //                         });
    //                       },
    //                       child: Material(
    //                         borderRadius: BorderRadius.circular(8),
    //                         color: download == Download.PDF
    //                             ? const Color(
    //                                 0xffD9D9D9) // Set color when selected
    //                             : Colors.transparent,
    //                         child: SizedBox(
    //                           width: 100,
    //                           height: 100,
    //                           child: Center(
    //                             child: Image.asset(
    //                               AppAssets.icPdf,
    //                               scale: 3,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: AppButton(
    //                     buttonType: (download == Download.NON)
    //                         ? ButtonType.PRIMARYDISABLED
    //                         : ButtonType.PRIMARYENABLED,
    //                     buttonText:
    //                         AppLocalizations.of(context).translate("download"),
    //                     onTapButton: () {
    //                       download == Download.PDF
    //                           ? _downloadEReceipt(true)
    //                           : _downloadExcelReceipt(true);
    //                       Navigator.pop(context);
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ));
    //       });
    //     });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
