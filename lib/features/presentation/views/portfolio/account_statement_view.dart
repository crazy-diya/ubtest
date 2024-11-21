import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/filtered_chip.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_unbuild_content.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';


import '../../../../utils/text_editing_controllers.dart';
import '../../../data/models/responses/account_statements_response.dart';
import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_event.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/date_pickers/app_date_picker.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../../widgets/ub_radio_button.dart';
import '../base_view.dart';
import '../home/settings_view/transaction_limits/transaction_limits_list_view.dart';
import 'Data/account_statement_filter.dart';

class AccountStatementsArgs {
  final String? accNumber;
  final String? accType;
  final String? currency;

  AccountStatementsArgs({this.accNumber, this.accType, this.currency});
}

class PortfolioAccountStatementView extends BaseView {
  final AccountStatementsArgs accountStatementsArgs;

  PortfolioAccountStatementView({required this.accountStatementsArgs});

  @override
  _PortfolioAccountDetailsViewState createState() =>
      _PortfolioAccountDetailsViewState();
}

class _PortfolioAccountDetailsViewState
    extends BaseViewState<PortfolioAccountStatementView> {
  var bloc = injection<PortfolioBloc>();

  List<StatementResponseDto> accStatemnt = [];
  int? countL;
  // int countValues =0;
  Download download = Download.NON;
  double? totalCreditAmount = 0.0;
  double? totalDebitAmount = 0.0;
  String? firstDate;
  String? lastDate;
  String? fromDateIftoDateNotNull;
  String? toDateIfFromDateNotNull;
  int? size = 10;
  int pageNumberTran = 0;
  bool isUserEdited = false;
  bool isFiltered = false;
  late final _scrollControllerTran = ScrollController();
  AccountStatementFilterData accStatementFilterData = AccountStatementFilterData();
//////////////////////////
  CurrencyTextEditingController _controller3 = CurrencyTextEditingController();
  CurrencyTextEditingController _controller4 = CurrencyTextEditingController();

  // final TextEditingController _controller3 = TextEditingController();
  // final TextEditingController _controller4 = TextEditingController();
  String? toDate;
  String? fromDate;
  int? fromAmount = 0;
  int? toAmount = 0;
  String? status = "All";
  DateTime? fromDateV;
  DateTime? toDateV;
  var thousandFormatter = ThousandsSeparatorInputFormatter();
  AccountStatementFilterData? filterData;
/////////////////////////
  @override
  void initState() {
    super.initState();
    _scrollControllerTran.addListener(_onScrollTran);
    _loadInitialData();
    setState(() {});
  }

  void _loadInitialData() {
    bloc.add(AccountStatementsEvent(
        size: 10,
        page: 0,
        accountNo: widget.accountStatementsArgs.accNumber!,
        messageType: 'portfolioRequest',
        fromAmount: accStatementFilterData.fromAmount == 0
            ? null
            : accStatementFilterData.fromAmount,
        toAmount: accStatementFilterData.toAmount == 0
            ? null
            : accStatementFilterData.toAmount,
        status: accStatementFilterData.status ?? "All",
        fromDate: accStatementFilterData.fromDate ??
            Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString(),
        toDate: accStatementFilterData.toDate ??
            Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd'),
            // Jiffy.now().startOf(Unit.month).add(months: 1).format(pattern: 'yyyy-MM-dd').toString(),
        accountType: widget.accountStatementsArgs.accType));
  }

  void fromDateValue(String){
    if(accStatementFilterData.toDate != null && accStatementFilterData.fromDate == null){
      var jiffyFromDate = Jiffy.parse(accStatementFilterData.toDate! , pattern: 'yyyy-MM-dd').subtract(months: 3);
      fromDateIftoDateNotNull = DateFormat('yyyy-MM-dd').format(jiffyFromDate.dateTime);
    }
    if(accStatementFilterData.toDate == null && accStatementFilterData.fromDate != null){
      // if(DateTime.now().difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(accStatementFilterData.fromDate!)),)).inDays > 90)
      if(Jiffy.parse(DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(accStatementFilterData.fromDate!)) , pattern: 'yyyy-MM-dd').add(months: 3).dateTime.isBefore(Jiffy.now().dateTime))
      {
        var jiffyToDate = Jiffy.parse(accStatementFilterData.fromDate! , pattern: 'yyyy-MM-dd').add(months: 3);
        toDateIfFromDateNotNull = DateFormat('yyyy-MM-dd').format(jiffyToDate.dateTime);
      } else {
        toDateIfFromDateNotNull = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()));
      }
    }
    if(accStatementFilterData.toDate == null && accStatementFilterData.fromDate == null){
      var jiffyFromDate = Jiffy.now().subtract(months: 3).format(pattern: 'yyyy-MM-dd');
      fromDateIftoDateNotNull = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(jiffyFromDate));
      toDateIfFromDateNotNull = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()));
    }
  }

  void _onScrollTran() {
    if (countL != accStatemnt.length) {
      final maxScroll = _scrollControllerTran.position.maxScrollExtent;
      final currentScroll = _scrollControllerTran.position.pixels;
      if (maxScroll - currentScroll == 0) {
        if (accStatemnt.length >= 100) {
          showAppDialog(
              alertType: AlertType.WARNING,
              isSessionTimeout: true,
              title: AppLocalizations.of(context)
                  .translate("permissible_limit_exceeded"),
              message: AppLocalizations.of(context)
                  .translate("permissible_limit_exceeded_msg"),
              positiveButtonText:
                  AppLocalizations.of(context).translate("close"),
              onPositiveCallback: () async {});
        } else {
          pageNumberTran++;
          bloc.add(AccountStatementsEvent(
              size: 10,
              page: pageNumberTran,
              accountNo: widget.accountStatementsArgs.accNumber!,
              messageType: 'portfolioRequest',
              fromAmount: accStatementFilterData.fromAmount == 0
                  ? null
                  : accStatementFilterData.fromAmount,
              toAmount: accStatementFilterData.toAmount == 0
                  ? null
                  : accStatementFilterData.toAmount,
              status: accStatementFilterData.status ?? "All",
              fromDate: accStatementFilterData.fromDate ??
                  Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString(),
              toDate: accStatementFilterData.toDate ??
                  Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd'),
              accountType: widget.accountStatementsArgs.accType));
        }
      }
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("account_statement"),
        actions: [
          IconButton(
              onPressed: ()async{
              isUserEdited = false;
              isFiltered = false;
              fromDateIftoDateNotNull = null;
              toDateIfFromDateNotNull = null;
              clearFields();
              // AccountStatementFilterData() = AccountStatementFilterData();
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
                                title: AppLocalizations.of(context).translate("filter_transactions"),
                                buttons: [
                                  Expanded(
                                    child: AppButton(
                                        buttonType: ButtonType.OUTLINEENABLED,
                                        buttonText: AppLocalizations.of(context)
                                            .translate("reset"),
                                        onTapButton: () {
                                          clearFields();
                                          // WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                          // Navigator.of(context).pop(true);
                                          changeState(() {});
                                          setState(() {});
                                        }),
                                  ),
                                  16.horizontalSpace,
                                  Expanded(
                                    child: AppButton(
                                        // buttonType: _isButtonEnable() ? ButtonType.PRIMARYENABLED : ButtonType.PRIMARYDISABLED,
                                        buttonText: AppLocalizations.of(context).translate("apply"),
                                        onTapButton: () {
                                          if(!_isAFieldFilled()){
                                            return;
                                          }
                                          if(!_isAmountRangeValid()){
                                            return;
                                          }
                                          if(!_isDateRangeValid()){
                                            return;
                                          }
                                          if(isUserEdited == false){
                                            return;
                                          }
                                          filterData = AccountStatementFilterData(
                                              fromDate: fromDate,
                                              toDate: toDate,
                                              fromAmount: fromAmount == 0 ? null : fromAmount,
                                              toAmount: toAmount == 0 ? null : toAmount,
                                              status: status == "Credit" ? "C" : status == "Debit" ? "D" : status,
                                              isFilterd: true);
                                          isUserEdited = false;
                                          isFiltered = true;
                                          changeState(() {});
                                          setState(() {});
                                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                          Navigator.of(context).pop(true);
                                        }),
                                  ),
                                ],
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppDatePicker(
                                        isFromDateSelected: true,
                                        initialValue: ValueNotifier(
                                            fromDate != null ? DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDate!)) : null),
                                        firstDate: toDate == null ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 1).dateTime :
                                        Jiffy.parse(DateFormat('yyyy-MM-dd').format(toDateV!), pattern: 'yyyy-MM-dd').subtract(months: 3).dateTime,
                                        lastDate: toDate == null ? DateTime.now() : toDateV,
                                        labelText: AppLocalizations.of(context).translate("from_date"),
                                        onChange: (value) {
                                          setState(() {
                                            fromDate = value;
                                            fromDateV = DateTime.parse(fromDate!);
                                            isUserEdited = true;
                                          });
                                          changeState(() {});
                                        },
                                        // text: isResetClicked ? null : fromDate == null ? "":DateFormat('dd MMMM yyyy').format( DateTime.parse(fromDate!)),
                                        // selectedDate: isResetClicked ? null : fromDateV,
                                        initialDate: toDate == null ? DateTime.parse(fromDate ?? DateTime.now().toString()) : toDateV ?? DateTime.now(),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const SizedBox.shrink(),
                                          fromDate != null && toDate != null && toDateV!.isBefore(fromDateV!)
                                              ? Column(
                                                children: [
                                                  8.verticalSpace,
                                                  Text(
                                                                                              "From date cannot be greater than $toDate",
                                                                                              textAlign: TextAlign.end,
                                                                                              style: TextStyle(
                                                    color: toDateV!.isBefore(fromDateV!) ? colors(context).negativeColor : colors(context).blackColor),
                                                                                            ),
                                                ],
                                              )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      24.verticalSpace,
                                      AppDatePicker(
                                        isFromDateSelected: true,
                                        initialValue: ValueNotifier(
                                            toDate != null ? DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDate!)) : null),
                                        firstDate: (fromDate == null) ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(months: 9).dateTime :
                                        Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 1).dateTime,
                                        lastDate: (fromDate == null) ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').dateTime :
                                        Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 3).dateTime.isAfter(Jiffy.now().dateTime) ?
                                        Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').dateTime :
                                        Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 3).dateTime,
                                        labelText: AppLocalizations.of(context).translate("to_date"),
                                        onChange: (value) {
                                          setState(() {
                                            toDate = value;
                                            toDateV = DateTime.parse(toDate!);
                                            isUserEdited = true;
                                          });
                                          changeState(() {});
                                        },
                                        initialDate: (fromDate == null)
                                            ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').dateTime :
                                        Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!),
                                            pattern: 'yyyy-MM-dd').add(months: 3).dateTime.isAfter(Jiffy.now().dateTime) ?
                                        Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').dateTime :
                                        Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 3).dateTime,
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        controller: _controller3,
                                        // inputFormatter: [thousandFormatter],
                                        isCurrency: true,
                                        showCurrencySymbol: true,
                                        inputType: const TextInputType.numberWithOptions(decimal: true),
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context).translate("from_amount"),
                                        title: AppLocalizations.of(context).translate("from_amount"),
                                        onTextChanged: (value) {
                                          setState(() {
                                            fromAmount = double.parse(value.replaceAll(",", "")).toInt();
                                            isUserEdited = true;
                                          });
                                          changeState(() {});
                                        },
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        controller: _controller4,
                                        // inputFormatter: [thousandFormatter],
                                        isCurrency: true,
                                        showCurrencySymbol: true,
                                        inputType: const TextInputType.numberWithOptions(decimal: true),
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context).translate("to_amount"),
                                        title: AppLocalizations.of(context).translate("to_amount"),
                                        onTextChanged: (value) {
                                          setState(() {
                                            toAmount = double.parse(value.replaceAll(",", "")).toInt();
                                            isUserEdited = true;
                                          });
                                          changeState(() {});
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          const SizedBox.shrink(),
                                          fromAmount != 0 &&
                                              toAmount != 0 &&
                                              toAmount! <= fromAmount!
                                              ? Column(
                                                children: [
                                                  8.verticalSpace,
                                                  Text(
                                                    "${AppLocalizations.of(context).translate("minimum")} ${AppLocalizations.of(context).translate("lkr")} ${fromAmount! + 1}.00 ${AppLocalizations.of(context).translate("needed")}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                    color: toAmount! > fromAmount!
                                                        ? colors(context).blackColor
                                                        : colors(context)
                                                        .negativeColor),
                                                  ),
                                                ],
                                              )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      24.verticalSpace,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("status"),
                                            style: size14weight700.copyWith(
                                              color: colors(context).blackColor!,
                                            ),
                                          ),
                                          16.verticalSpace,
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  changeState(() {
                                                    status = 'All';
                                                    isUserEdited = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context).translate("all"),
                                                      style: size16weight400.copyWith(
                                                          color: colors(context)
                                                              .blackColor),
                                                    ),
                                                    Spacer(),
                                                    UBRadio<dynamic>(
                                                      value: 'All',
                                                      groupValue: status,
                                                      onChanged: (dynamic value) {
                                                        changeState(() {
                                                          status = value;
                                                          isUserEdited = true;
                                                        });
                                                      },
                                                    ),
                                                    8.horizontalSpace
                                                  ],
                                                ),
                                              ),
                                              24.verticalSpace,
                                              InkWell(
                                                onTap: () {
                                                  changeState(() {
                                                    status = 'Credit';
                                                    isUserEdited = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context).translate("credit"),
                                                      style: size16weight400.copyWith(
                                                          color: colors(context)
                                                              .blackColor),
                                                    ),
                                                    Spacer(),
                                                    UBRadio<dynamic>(
                                                      value: 'Credit',
                                                      groupValue: status,
                                                      onChanged: (dynamic value) {
                                                        changeState(() {
                                                          status = value;
                                                          isUserEdited = true;
                                                        });
                                                      },
                                                    ),
                                                    8.horizontalSpace
                                                  ],
                                                ),
                                              ),
                                              24.verticalSpace,
                                              InkWell(
                                                onTap: () {
                                                  changeState(() {
                                                    status = 'Debit';
                                                    isUserEdited = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context).translate("debit"),
                                                      style: size16weight400.copyWith(
                                                          color: colors(context)
                                                              .blackColor),
                                                    ),
                                                    Spacer(),
                                                    UBRadio<dynamic>(
                                                      value: 'Debit',
                                                      groupValue: status,
                                                      onChanged: (dynamic value) {
                                                        changeState(() {
                                                          status = value;
                                                          isUserEdited = true;
                                                        });
                                                      },
                                                    ),
                                                    8.horizontalSpace
                                                  ],
                                                ),
                                              ),
                                              // CustomRadioButton(
                                              //   value: 'read',
                                              //   groupValue: status,
                                              //   onChanged: (value) {
                                              //     changeState(() {
                                              //       status = value;
                                              //     });
                                              //   },
                                              //   label: 'Read',
                                              //   labelColor: status == null
                                              //       ? colors(context).greyColor!
                                              //       : colors(context).blackColor!,
                                              // ),

                                              // CustomRadioButton(
                                              //   value: 'unread',
                                              //   groupValue: status,
                                              //   onChanged: (value) {
                                              //     changeState(() {
                                              //       status = value;
                                              //     });
                                              //   },
                                              //   label: 'Unread',
                                              //   labelColor: status == null
                                              //       ? colors(context).greyColor!
                                              //       : colors(context).blackColor!,
                                              // ),
                                              20.verticalSpace,
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Text(
                                      //   AppLocalizations.of(context).translate("status"),
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w400,
                                      //     color: colors(context).blackColor,
                                      //   ),
                                      // ),
                                      // Column(
                                      //   children: [
                                      //     CustomRadioButton(
                                      //       value: 'All',
                                      //       groupValue: status,
                                      //       onChanged: (value) {
                                      //         setState(() {
                                      //           status = value;
                                      //         });
                                      //         changeState(() {});
                                      //       },
                                      //       label: 'All',
                                      //       labelColor: colors(context)
                                      //           .blackColor!,
                                      //     ),
                                      //     CustomRadioButton(
                                      //       value: 'Credit',
                                      //       groupValue: status,
                                      //       onChanged: (value) {
                                      //         setState(() {
                                      //           status = value;
                                      //         });
                                      //         changeState(() {});
                                      //       },
                                      //       label: 'Credit',
                                      //       labelColor: colors(context)
                                      //           .blackColor!,
                                      //     ),
                                      //     CustomRadioButton(
                                      //       value: 'Debit',
                                      //       groupValue: status,
                                      //       onChanged: (value) {
                                      //         setState(() {
                                      //           status = value;
                                      //         });
                                      //         changeState(() {});
                                      //       },
                                      //       label: 'Debit',
                                      //       labelColor: colors(context)
                                      //           .blackColor!,
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ],
                              );
                            }
                        ));
                setState(() {});
                // final result = await Navigator.pushNamed(
                //   context,
                //   Routes.kPortfolioFilterAcctStatementView,
                // );

              if (result == true) {
                setState(() {
                  accStatementFilterData = filterData as AccountStatementFilterData;
                  pageNumberTran = 0;
                });
                fromDateValue(String);
                bloc.add(AccountStatementsEvent(
                  size: 10,
                  page: pageNumberTran,
                  accountNo: widget.accountStatementsArgs.accNumber!,
                  messageType: 'portfolioRequest',
                  fromAmount: accStatementFilterData.fromAmount == 0
                      ? null
                      : accStatementFilterData.fromAmount,
                  toAmount: accStatementFilterData.toAmount == 0
                      ? null
                      : accStatementFilterData.toAmount,
                  status: accStatementFilterData.status??"All",
                  fromDate: accStatementFilterData.fromDate ??
                      fromDateIftoDateNotNull,
                  toDate: accStatementFilterData.toDate ??
                      toDateIfFromDateNotNull,
                   accountType:widget.accountStatementsArgs.accType
                ));
              }
            },
            icon: PhosphorIcon(PhosphorIcons.funnel(PhosphorIconsStyle.bold), color: colors(context).whiteColor,size: 24.w)
          ),
        ],
      ),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is AccountStatementsSuccessState) {
              setState(() {
                if (pageNumberTran == 0) {
                  accStatemnt = state.accStatements!;
                } else {
                  accStatemnt.addAll(state.accStatements!);
                }
                countL = state.count;
                totalCreditAmount = state.totalCreditAmount;
                totalDebitAmount = state.totalDebitAmount;
                firstDate = DateFormat('dd-MMMM-yyyy').format(
                    DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
                        .parse(state.firstTxnDate.toString()));
                lastDate = DateFormat('dd-MMMM-yyyy').format(
                    DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
                        .parse(state.lastTxnDate.toString()));
              });
            }
            else if (state is AccountStatementsPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo ACstat ${isFiltered == false ?
                  DateFormat('dd.MM.yyyy').format(DateTime.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString()))
                      : DateFormat('dd.MM.yyyy').format(DateTime.parse(accStatementFilterData.fromDate ?? fromDateIftoDateNotNull!))} - "
                      "${isFiltered == false ? DateFormat('dd.MM.yyyy').format(DateTime.parse(Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd')))
                      : DateFormat('dd.MM.yyyy').format(DateTime.parse(accStatementFilterData.toDate ?? toDateIfFromDateNotNull!))}",
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
            else if (state is AccountSatementsXcelDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo ACstat ${isFiltered == false ?
                  DateFormat('dd.MM.yyyy').format(DateTime.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString()))
                      : DateFormat('dd.MM.yyyy').format(DateTime.parse(accStatementFilterData.fromDate ?? fromDateIftoDateNotNull!))} - "
                      "${isFiltered == false ? DateFormat('dd.MM.yyyy').format(DateTime.parse(Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd')))
                      : DateFormat('dd.MM.yyyy').format(DateTime.parse(accStatementFilterData.toDate ?? toDateIfFromDateNotNull!))}",
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
            else if (state is AccountStatementsFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
            else if (state is AccountStatementsPdfDownloadFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
            else if (state is AccountSatementsXcelDownloadFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
          },
          child: Stack(
            children: [
              if(accStatemnt.isEmpty)
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
              Padding(
                padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h),
                child: Column(
                  children: [
                    // Visibility(
                    //   visible: accStatemnt.isNotEmpty &&
                    //       accStatementFilterData.isFilterd == null,
                    //   child: SizedBox(
                    //     height: 3.h,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             _downloadEReceipt(false);
                    //           },
                    //           child: Container(
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   AppAssets.icShareIcon,
                    //                   scale: 3,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 3.w,
                    //                 ),
                    //                 Text(
                    //                   AppLocalizations.of(context)
                    //                       .translate("share"),
                    //                   style: TextStyle(
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: colors(context)
                    //                         .secondaryColor,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
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
                    //                     color: colors(context)
                    //                         .secondaryColor,
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
                    if(accStatementFilterData.fromDate != null &&
                        accStatementFilterData.toDate != null ||
                        accStatementFilterData.status != null ||
                        accStatementFilterData.fromAmount != null &&
                            accStatementFilterData.toAmount != null ||
                        accStatementFilterData.fromDate != null &&
                            accStatementFilterData.toDate == null ||
                        accStatementFilterData.fromDate == null &&
                            accStatementFilterData.toDate != null ||
                        accStatementFilterData.fromAmount != null &&
                            accStatementFilterData.toAmount == null ||
                        accStatementFilterData.fromAmount == null &&
                            accStatementFilterData.toAmount != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                                                    children: [
                            if (accStatementFilterData.fromDate != null &&
                                accStatementFilterData.toDate != null)
                              FilteredChip(
                                onTap: () {
                                  setState(() {
                                  accStatementFilterData.fromDate = null;
                                  accStatementFilterData.toDate = null;
                                  if (accStatementFilterData.fromDate == null &&
                                      accStatementFilterData.toDate == null &&
                                      accStatementFilterData.fromAmount == null &&
                                      accStatementFilterData.toAmount == null &&
                                      accStatementFilterData.status == null) {
                                    accStatementFilterData.isFilterd = null;
                                  }
                                });
                                _loadStatement();
                                },
                                children: [
                                   Text("${DateFormat("dd-MMM-yyyy").format(DateTime.parse(accStatementFilterData.fromDate!))} to ${DateFormat("dd-MMM-yyy").format(DateTime.parse(accStatementFilterData.toDate!))}",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                ],
                              ),
                            if (accStatementFilterData.fromDate != null &&
                                accStatementFilterData.toDate == null)
                                 FilteredChip(
                                onTap: () {
                                 setState(() {
                                  accStatementFilterData
                                      .fromDate = null;

                                  if (accStatementFilterData.fromDate == null &&
                                      accStatementFilterData.toDate ==
                                          null &&
                                      accStatementFilterData
                                          .fromAmount ==
                                          null &&
                                      accStatementFilterData
                                          .toAmount ==
                                          null &&
                                      accStatementFilterData
                                          .status ==
                                          null) {
                                    accStatementFilterData
                                        .isFilterd = null;
                                  }
                                });
                                _loadStatement();
                                },
                                children: [
                                 Text(
                                    "${AppLocalizations.of(context).translate("from_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(accStatementFilterData.fromDate!))}",
                                    style: size14weight400.copyWith(color: colors(context).greyColor),
                                  ),
                                ],
                              ),
                            if (accStatementFilterData.fromDate == null &&
                                accStatementFilterData.toDate != null)
                               FilteredChip(
                                onTap: () {
                                 setState(() {
                                  accStatementFilterData
                                      .toDate = null;

                                  if (accStatementFilterData.fromDate == null &&
                                      accStatementFilterData.toDate ==
                                          null &&
                                      accStatementFilterData
                                          .fromAmount ==
                                          null &&
                                      accStatementFilterData
                                          .toAmount ==
                                          null &&
                                      accStatementFilterData
                                          .status ==
                                          null) {
                                    accStatementFilterData
                                        .isFilterd = null;
                                  }
                                });
                                _loadStatement();
                                },
                                children: [
                                 Text(
                                  "${AppLocalizations.of(context).translate("to_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(accStatementFilterData.toDate!))}",
                                  style:  size14weight400.copyWith(color: colors(context).greyColor),
                                ),
                                ],
                              ),
                            if (accStatementFilterData.fromAmount != null &&
                                accStatementFilterData.toAmount != null)
                              FilteredChip(
                                onTap: () {
                                  setState(() {
                                  accStatementFilterData
                                      .fromAmount = null;
                                  accStatementFilterData
                                      .toAmount = null;
                                  if (accStatementFilterData.fromDate == null &&
                                      accStatementFilterData.toDate ==
                                          null &&
                                      accStatementFilterData
                                          .fromAmount ==
                                          null &&
                                      accStatementFilterData
                                          .toAmount ==
                                          null &&
                                      accStatementFilterData
                                          .status ==
                                          null) {
                                    accStatementFilterData
                                        .isFilterd = null;
                                  }
                                });
                                _loadStatement();
                                },
                                children: [
                            Text(
                                      "${AppLocalizations.of(context).translate("lkr")} ${accStatementFilterData.fromAmount.toString().withThousandSeparator()} - ${accStatementFilterData.toAmount.toString().withThousandSeparator()}",
                                      style:  size14weight400.copyWith(color: colors(context).greyColor),
                                    ),
                                ],
                              ),
                            if (accStatementFilterData.fromAmount != null &&
                                accStatementFilterData.toAmount == null)
                              FilteredChip(
                                onTap: () {
                                 setState(() {
                                    accStatementFilterData
                                        .fromAmount = null;
  
                                    if (accStatementFilterData.fromDate == null &&
                                        accStatementFilterData.toDate ==
                                            null &&
                                        accStatementFilterData
                                            .fromAmount ==
                                            null &&
                                        accStatementFilterData
                                            .toAmount ==
                                            null &&
                                        accStatementFilterData
                                            .status ==
                                            null) {
                                      accStatementFilterData
                                          .isFilterd = null;
                                    }
                                  });
                                  _loadStatement();
                                },
                                children: [
                                    Text(
                                            "${AppLocalizations.of(context).translate("from_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${accStatementFilterData.fromAmount.toString().withThousandSeparator()}",
                                            style: size14weight400.copyWith(color: colors(context).greyColor),
                                          ),
                                ],
                              ),
                              
                            if (accStatementFilterData.fromAmount == null &&
                                accStatementFilterData.toAmount != null)
                              FilteredChip(
                                onTap: () {
                                setState(() {
                                  accStatementFilterData
                                      .toAmount = null;

                                  if (accStatementFilterData.fromDate == null &&
                                      accStatementFilterData.toDate ==
                                          null &&
                                      accStatementFilterData
                                          .fromAmount ==
                                          null &&
                                      accStatementFilterData
                                          .toAmount ==
                                          null &&
                                      accStatementFilterData
                                          .status ==
                                          null) {
                                    accStatementFilterData
                                        .isFilterd = null;
                                  }
                                });
                                _loadStatement();
                                },
                                children: [
                                    Text(
                                            "${AppLocalizations.of(context).translate("to_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${accStatementFilterData.toAmount.toString().withThousandSeparator()}",
                                            style: size14weight400.copyWith(color: colors(context).greyColor),
                                          ),
                                ],
                              ),
                              
                            if (accStatementFilterData.status != null)
                            FilteredChip(
                                onTap: () {
                                setState(() {
                                    accStatementFilterData
                                        .status = null;
                                    if (accStatementFilterData.fromDate == null &&
                                        accStatementFilterData.toDate ==
                                            null &&
                                        accStatementFilterData
                                            .fromAmount ==
                                            null &&
                                        accStatementFilterData
                                            .toAmount ==
                                            null &&
                                        accStatementFilterData
                                            .status ==
                                            null) {
                                      accStatementFilterData
                                          .isFilterd = null;
                                    }
                                  });
                                  _loadStatement();
                                },
                                children: [
                                    Text(
                                            "${accStatementFilterData.status == "C" ? AppLocalizations.of(context).translate("credit") : accStatementFilterData.status == "D" ? AppLocalizations.of(context).translate("debit") : AppLocalizations.of(context).translate("all")} ",
                                            style: size14weight400.copyWith(color: colors(context).greyColor),
                                          ),
                                ],
                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if(accStatemnt.isNotEmpty)
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (accStatementFilterData.isFilterd != true)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16).w,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context).translate("statements_period"),
                                                style: size14weight700.copyWith(color: colors(context).blackColor),
                                              ),
                                              16.horizontalSpace,
                                              Expanded(
                                                child: Text(
                                                  "${Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MMM-dd')} ${AppLocalizations.of(context).translate("to")} ${Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MMM-dd')}",
                                                  // "${Jiffy.now().subtract(months: 3).format(pattern: 'yyyy-MMM-dd')} to ${DateFormat("yyyy-MMM-dd").format(DateTime.now())}",
                                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                                  // overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                          16.verticalSpace,
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8).r,
                                              color: colors(context).greyColor50,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16).w,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${widget.accountStatementsArgs.currency == null || widget.accountStatementsArgs.currency == "" ? AppLocalizations.of(context).translate("lkr") : widget.accountStatementsArgs.currency} ${
                                                            totalCreditAmount
                                                                .toString()
                                                                .withThousandSeparator()
                                                        }",
                                                        style: size14weight700.copyWith(color: colors(context).positiveColor),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context).translate("open_balance"),
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
                                                        "${widget.accountStatementsArgs.currency == null || widget.accountStatementsArgs.currency == "" ? AppLocalizations.of(context).translate("lkr") : widget.accountStatementsArgs.currency} ${
                                                            totalDebitAmount
                                                                .toString()
                                                                .withThousandSeparator()
                                                        }",
                                                        style: size14weight700.copyWith(color: colors(context).negativeColor),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context).translate("close_balance"),
                                                        style: size12weight400.copyWith(color: colors(context).greyColor),
                                                      ),
              
                                                    ],
                                                  ),
              
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
                              ],
                            ),
                            24.verticalSpace,
                            Expanded(
                                child:  SingleChildScrollView(
                                  controller: _scrollControllerTran,
                                  physics: ClampingScrollPhysics(),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(16.w,16.h,16.w,0.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "$countL ${AppLocalizations.of(context).translate("results")}",
                                                style: size16weight700.copyWith(color: colors(context).blackColor)
                                            ),
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              // controller: _scrollControllerTran,
                                              itemCount: accStatemnt.length,
                                              // Adjust the item count as needed
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    UBPortfolioUnbuildContent(
                                                      title: accStatemnt[index].remarks ?? "",
                                                      subTitle: accStatemnt[index].referenceNumber ?? "",
                                                      data: accStatemnt[index].transactionAmount.toString().withThousandSeparator(),
                                                      subData: accStatemnt[index].transactionDateTime,
                                                      isCR: accStatemnt[index].drCr ?? "",
                                                      time: accStatemnt[index].transactionTime,
                                                      isFromAcctSt: true,
                                                      currency: widget.accountStatementsArgs.currency,
                                                    ),
                                                    if(accStatemnt.length-1 != index)
                                                      Divider(
                                                        height: 0,
                                                        thickness: 1,
                                                        color: colors(context).greyColor100,
                                                      )
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    // Visibility(
                    //   visible: accStatemnt.isNotEmpty &&
                    //       accStatementFilterData.isFilterd == true,
                    //   child: SizedBox(
                    //     height: 3.h,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 _downloadEReceipt(false);
                    //               },
                    //               child: Row(
                    //                 children: [
                    //                   Image.asset(
                    //                     AppAssets.icShareIcon,
                    //                     scale: 3,
                    //                   ),
                    //                   SizedBox(
                    //                     width: 3.w,
                    //                   ),
                    //                   Text(
                    //                     AppLocalizations.of(context)
                    //                         .translate("share"),
                    //                     style: TextStyle(
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: colors(context)
                    //                           .secondaryColor,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 3.w,
                    //             ),
                    //             VerticalDivider(
                    //               color: colors(context).secondaryColor300,
                    //               thickness: 1,
                    //             ),
                    //             SizedBox(
                    //               width: 3.w,
                    //             ),
                    //             GestureDetector(
                    //               onTap: () {
                    //                 _showBottomSheet(context);
                    //               },
                    //               child: Row(
                    //                 children: [
                    //                   Image.asset(
                    //                     AppAssets.icDwnldIcon,
                    //                     scale: 3,
                    //                   ),
                    //                   SizedBox(
                    //                     width: 3.w,
                    //                   ),
                    //                   Text(
                    //                     AppLocalizations.of(context)
                    //                         .translate("download"),
                    //                     style: TextStyle(
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: colors(context)
                    //                           .secondaryColor,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadStatement() {
    pageNumberTran = 0;
    bloc.add(AccountStatementsEvent(
        size: 10,
        page: pageNumberTran,
        accountNo: widget.accountStatementsArgs.accNumber!,
        messageType: 'portfolioRequest',
        fromAmount: accStatementFilterData.fromAmount,
        toAmount: accStatementFilterData.toAmount,
        status: accStatementFilterData.status ?? "All",
        fromDate: accStatementFilterData.fromDate ??
            Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString(),
        toDate: accStatementFilterData.toDate ??
            Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd'),
        accountType: widget.accountStatementsArgs.accType));
  }


  void updateList() {
    listener:
    (context, state) {
      if (state is AccountStatementsSuccessState) {
        setState(() {
          accStatemnt.clear();
          accStatemnt.addAll(state.accStatements!);
          countL:
          state.count;
        });

        // Navigator.pushNamed(
        //     context, Routes.kApplyPersonalLoanView);
      }
    };
  }

  _downloadEReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        AccountStatementsPdfDownloadEvent(
          accountNo: widget.accountStatementsArgs.accNumber!,
          fromAmount: accStatementFilterData.fromAmount.toString(),
          toAmount: accStatementFilterData.toAmount.toString(),
          status: accStatementFilterData.status ?? "All",
          fromDate: isFiltered == false ? Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString() :
          accStatementFilterData.fromDate ?? fromDateIftoDateNotNull,
          toDate: isFiltered == false ? Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd') :
          accStatementFilterData.toDate ?? toDateIfFromDateNotNull,
          accountType: widget.accountStatementsArgs.accType,
          shouldOpen: shouldStore,
        ),
      );
    });
  }

  _downloadExcelReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        AccountSatementsXcelDownloadEvent(
          accountNo: widget.accountStatementsArgs.accNumber!,
          fromAmount: accStatementFilterData.fromAmount.toString(),
          toAmount: accStatementFilterData.toAmount.toString(),
          status: accStatementFilterData.status ?? "All",
          fromDate: isFiltered == false ? Jiffy.now().startOf(Unit.month).subtract(months: 1).format(pattern: 'yyyy-MM-dd').toString() :
          accStatementFilterData.fromDate ?? fromDateIftoDateNotNull,
          toDate: isFiltered == false ? Jiffy.parse(Jiffy.now().startOf(Unit.month).subtract(months: 1 , days: 1).format(pattern: 'yyyy-MM-dd').toString()).add(months: 1).format(pattern: 'yyyy-MM-dd') :
          accStatementFilterData.toDate ?? toDateIfFromDateNotNull,
          accountType: widget.accountStatementsArgs.accType,
          shouldOpen: shouldStore,
        ),
      );
    });
  }

  void clearFields() {
    setState(() {
      toDate = null;
      fromDate = null;
      toDateV = null;
      fromDateV = null;
      fromAmount = 0;
      toAmount = 0;
      _controller3 = CurrencyTextEditingController();
      _controller4 = CurrencyTextEditingController();
      // _controller3.clear();
      // _controller4.clear();
      status = null;
    });
  }

  bool _isDateRangeValid() {
    if (fromDateV != null && toDateV != null) {
      return !toDateV!.isBefore(fromDateV!) && !fromDateV!.isAfter(toDateV!);
    } else if (fromDateV != null || toDateV != null) {
      return true; // Return true if either fromDateV or toDateV is not null.
    }
    return true; // Return true if both fromDateV and toDateV are null.
  }

  bool _isAFieldFilled() {
    if (fromDate != null ||
        toDate != null ||
        fromAmount != "0.00" ||
        toAmount != "0.00" ||
        status != null) {
      return true;
    }
    return false; // Return true if either fromDateV or toDateV is null.
  }

  bool _isButtonEnable() {
    if (_isAFieldFilled() && _isAmountRangeValid() && _isDateRangeValid()) {
      return true;
    }
    return false;
  }


  bool _isAmountRangeValid() {
    if (fromAmount == 0 || toAmount == 0) {
      return true;
    } else if (fromAmount! >= toAmount!) {
      return false;
    }
    return true; // Return true if either fromDateV or toDateV is null.
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
