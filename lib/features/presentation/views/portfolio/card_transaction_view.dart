// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_unbuild_content.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/theme/text_styles.dart';

import '../../../../utils/app_sizer.dart';
import '../../../../utils/text_editing_controllers.dart';
import '../../../data/models/responses/card_management/card_list_response.dart';
import '../../../data/models/responses/card_management/card_txn_history_response.dart';
import '../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/date_pickers/app_date_picker.dart';
import '../../widgets/filtered_chip.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../../widgets/ub_radio_button.dart';
import '../base_view.dart';
import '../home/settings_view/transaction_limits/transaction_limits_list_view.dart';
import 'Data/card_transaction_filter_data.dart';

class CardTransactionArgs {
  final String? availableCreditLimit;

  final String accountNumber;
  final String? cardNumber;

  final String? cardType;

  final List<CardResLast5Txn> transaction;

  CardTransactionArgs({
    this.availableCreditLimit,
    required this.accountNumber,
    this.cardNumber,
    this.cardType,
    required this.transaction,
  });
}

class PortfolioCardTransactionView extends BaseView {
  final CardTransactionArgs cardTransactionArgs;

  PortfolioCardTransactionView({super.key, required this.cardTransactionArgs});

  @override
  _PortfolioCardTransactionViewState createState() =>
      _PortfolioCardTransactionViewState();
}

class _PortfolioCardTransactionViewState
    extends BaseViewState<PortfolioCardTransactionView> {
  var bloc = injection<CreditCardManagementBloc>();
  List<CardTxnHistoryResponse> tranHistoryList = [];
  int? countL;

  Download download = Download.NON;

  String? firstDate;
  String? lastDate;
  int? size = 5;
  
  num totalCreditAmount = 0;

  num totalDebitAmount = 0;

  int pageNumberTran = 0;
  bool isUserEdited = false;
  bool isFilterd = false;
  // late final _scrollControllerTran = ScrollController();

  CardTransactionFilterData cardTransactionFilterData = CardTransactionFilterData();

  //////////////////////
  // final TextEditingController _controller3 = TextEditingController();
  CurrencyTextEditingController _controller3 = CurrencyTextEditingController();
  CurrencyTextEditingController _controller4 = CurrencyTextEditingController();
  // final TextEditingController _controller4 = TextEditingController();
  String? toDate;
  String? fromDate;
  double? fromAmount = 0.0;
  double? toAmount = 0.0;
  String? status = "All";
  String? billingStatus;
  DateTime? fromDateV;
  DateTime? toDateV;
  int tranCount = 0;
  bool isShow = true;
  late final _scrollControllerTran = ScrollController()
    ..addListener(_onScrollTran);
  List<TxnDetail> txnHistory = [];
  var thousandFormatter = ThousandsSeparatorInputFormatter();
  /////////////////////

  @override
  void initState() {
    super.initState();
    // countL = widget.cardTransactionArgs.transaction.length;
    bloc.add(GetCardTxnHistoryEvent(
      maskedCardNumber: widget.cardTransactionArgs.cardNumber,
      page: pageNumberTran, size: 10,
      txnMonthsFrom: Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd'),
      txnMonthsTo: Jiffy.now().format(pattern: 'yyMMdd'),
    ));
    // _scrollControllerTran.addListener(_onScrollTran);
    // _loadInitialData();
    // if (widget.cardTransactionArgs.transaction.isNotEmpty)
    //   widget.cardTransactionArgs.transaction.forEach((element) {
    //     if (element.resDebitCreditIndicator!.startsWith("C")) {
    //       totalCreditAmount += double.parse(element.resAmount ?? "0.00");
    //     } else {
    //       totalDebitAmount += double.parse(element.resAmount ?? "0.00");
    //     }
    //   });
  }

  _onScrollTran() {
    final maxScroll = _scrollControllerTran.position.maxScrollExtent;
    final currentScroll = _scrollControllerTran.position.pixels;
    if(countL !=txnHistory.length ) {
      if (maxScroll - currentScroll == 0) {
        if (txnHistory.length >=100 && isFilterd == true) {
          isShow = false;
          showAppDialog(
            alertType: AlertType.DOCUMENT3,
            negativeButtonText:AppLocalizations.of(context).translate("close"),
            title: AppLocalizations.of(context).translate("exceed_record"),
            message:AppLocalizations.of(context).translate("exceed_record_msg"),
            positiveButtonText:AppLocalizations.of(context).translate("Try_Again"),
            onBottomButtonCallback: () {
            },
          );
          setState(() {});
        } else {
          bloc.add(GetCardTxnHistoryEvent(
              size: 10,
              page: pageNumberTran,
              maskedCardNumber: widget.cardTransactionArgs.cardNumber,
              fromAmount: fromAmount == 0 || fromAmount == 0.0 || fromAmount == 0.00 ? null : fromAmount,
              toAmount: toAmount == 0 || toAmount == 0.0 || toAmount == 0.00 ? null : toAmount,
              status: status,
              txnMonthsFrom: fromDate == null && toDate == null
                  ? Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd')
                  : fromDate == null && toDate != null
                  ? Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd')
                  : Jiffy.parse(fromDate!).format(pattern: 'yyMMdd'),
              txnMonthsTo: fromDate == null && toDate == null
                  ? Jiffy.now().format(pattern: 'yyMMdd')
                  : fromDate != null && toDate == null
                  ? (Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now())
                  ? Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'yyMMdd')
                  : Jiffy.now().format(pattern: 'yyMMdd'))
                  : Jiffy.parse(toDate!).format(pattern: 'yyMMdd'),
              billingStatus: billingStatus
          ));
        }
      }
    }
  }

  _loadStatement() {
    pageNumberTran = 0;
    bloc.add(GetCardTxnHistoryEvent(
        size: 10,
        page: pageNumberTran,
        maskedCardNumber: widget.cardTransactionArgs.cardNumber,
        fromAmount: fromAmount == 0 || fromAmount == 0.0 || fromAmount == 0.00 ? null : fromAmount,
        toAmount: toAmount == 0 || toAmount == 0.0 || toAmount == 0.00 ? null : toAmount,
        status: status,
        txnMonthsFrom: fromDate == null && toDate == null
            ? Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd')
            : fromDate == null && toDate != null
            ? Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd')
            : Jiffy.parse(fromDate!).format(pattern: 'yyMMdd'),
        txnMonthsTo: fromDate == null && toDate == null
            ? Jiffy.now().format(pattern: 'yyMMdd')
            : fromDate != null && toDate == null
            ? (Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now())
            ? Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'yyMMdd')
            : Jiffy.now().format(pattern: 'yyMMdd'))
            : Jiffy.parse(toDate!).format(pattern: 'yyMMdd'),
      billingStatus: billingStatus
        ));
  }

  // void _loadInitialData() {
  //   bloc.add(CardTransactionsEvent(
  //       size: 10,
  //       page: pageNumberTran,
  //       accountNo: widget.cardTransactionArgs.accountNumber,
  //       messageType: 'creditCardTxnDetails'));
  // }

  // void _onScrollTran() {
  //   if (countL != transaction.length) {
  //     final maxScroll = _scrollControllerTran.position.maxScrollExtent;
  //     final currentScroll = _scrollControllerTran.position.pixels;
  //     if (maxScroll - currentScroll == 0) {
  //       pageNumberTran++;
  //       bloc.add(CardTransactionsEvent(
  //           size: 10,
  //           page: pageNumberTran,
  //           accountNo: widget.cardTransactionArgs.accountNumber,
  //           messageType: 'creditCardTxnDetails'));
  //     }
  //   }
  // }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("card_transaction_history"),
        actions: [
          IconButton(
            onPressed: ()async{
              isUserEdited = false;
              status = null;
              billingStatus = null;
              clearFields();
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
                              title: AppLocalizations.of(context).translate("filter_by"),
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
                                        pageNumberTran = 0;
                                        // cardTransactionFilterData = CardTransactionFilterData(
                                        //     fromDate: fromDate,
                                        //     toDate: toDate,
                                        //     fromAmount: fromAmount == 0.0 ? 0.0 : fromAmount,
                                        //     toAmount: toAmount == 0.0 ? 0.0 : toAmount,
                                        //     status: status,
                                        //     isFilterd: true);
                                        isFilterd = true;
                                        txnHistory.clear();
                                        bloc.add(GetCardTxnHistoryEvent(
                                          maskedCardNumber: widget.cardTransactionArgs.cardNumber,
                                          page: pageNumberTran,
                                          size: 10,
                                          txnMonthsFrom:fromDate == null && toDate == null
                                              ? Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd')
                                              : fromDate == null && toDate != null
                                              ? Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd')
                                              : Jiffy.parse(fromDate!).format(pattern: 'yyMMdd'),
                                          /* if fromDate and toDate both == null ? fromDate =  Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd') and toDate = Jiffy.now().format(pattern: 'yyMMdd') */
                                            /* if fromDate == null and toDate == not null ? fromDate =  Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd') and toDate = Jiffy.parse(toDate!).format(pattern: 'yyMMdd')*/
                                            /* if fromDate == not null and toDate == null ? fromDate = Jiffy.parse(fromDate!).format(pattern: 'yyMMdd') and toDate = Jiffy.parse(toDate!).add(months: 1).isBefore(Jiffy.now()) ? Jiffy.parse(toDate!).format(pattern: 'yyMMdd') : Jiffy.now().format(pattern: 'yyMMdd') */
                                            /* if fromDate == not null and toDate == not null ? fromDate = Jiffy.parse(fromDate!).format(pattern: 'yyMMdd') and toDate = Jiffy.parse(toDate!).format(pattern: 'yyMMdd') */
                                          txnMonthsTo: fromDate == null && toDate == null
                                              ? Jiffy.now().format(pattern: 'yyMMdd')
                                              : fromDate != null && toDate == null
                                              ? (Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now())
                                              ? Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'yyMMdd')
                                              : Jiffy.now().format(pattern: 'yyMMdd'))
                                              : Jiffy.parse(toDate!).format(pattern: 'yyMMdd'),
                                          fromAmount: fromAmount == 0.0 ? null : fromAmount,
                                          toAmount: toAmount == 0.0 ? null : toAmount,
                                          status: status ?? null,
                                          billingStatus: billingStatus ?? null
                                        ));
                                        // bloc.add(
                                        //     GetCardTxnHistoryEvent(
                                        //       maskedCardNumber: widget.cardTransactionArgs.cardNumber,
                                        //       txnMonthsFrom: "240119",
                                        //       txnMonthsTo: "240619"
                                        //     )
                                        // );
                                        isUserEdited = false;
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
                                      // firstDate: toDate == null ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 10).dateTime :
                                      // Jiffy.parse(DateFormat('yyyy-MM-dd').format(toDateV!), pattern: 'yyyy-MM-dd').subtract(months: 24).dateTime,
                                      lastDate: toDate == null ? DateTime.now()  : toDateV,
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
                                      initialDate: toDate == null ? DateTime.parse(fromDate ?? DateTime.now().toString() ): toDateV ?? DateTime.now().subtract(Duration(days: 1)) ,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // const SizedBox.shrink(),
                                        fromDate != null && toDate != null && toDateV!.isBefore(fromDateV!)
                                            ? Column(
                                              children: [
                                                8.verticalSpace,
                                                Text(
                                                  "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                  color: toDateV!.isBefore(fromDateV!) ? colors(context).negativeColor : colors(context).blackColor),),
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
                                      // firstDate: (fromDate == null) ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(months: 24).dateTime :
                                      // Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 10).dateTime,
                                      lastDate: DateTime.now(),

                                      // Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(days: 1).dateTime :
                                      // Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 24).dateTime.isAfter(Jiffy.now().dateTime) ?
                                      // Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(days: 24).dateTime :
                                      // Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 24).dateTime,
                                      labelText: AppLocalizations.of(context).translate("to_date"),
                                      onChange: (value) {
                                        setState(() {
                                          toDate = value;
                                          toDateV = DateTime.parse(toDate!);
                                          isUserEdited = true;
                                        });
                                        changeState(() {});
                                      },
                                      initialDate: DateTime.now(),
                                      //     ? Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(days: 1).dateTime :
                                      // Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!),
                                      //     pattern: 'yyyy-MM-dd').add(months: 1).dateTime.isAfter(Jiffy.now().dateTime) ?
                                      // Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(days: 1).dateTime :
                                      // Jiffy.parse(DateFormat('yyyy-MM-dd').format(fromDateV!), pattern: 'yyyy-MM-dd').add(months: 24).dateTime,
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
                                          fromAmount = double.parse(value.replaceAll(",", ""));
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
                                          toAmount = double.parse(value.replaceAll(",", ""));
                                          isUserEdited = true;
                                        });
                                        changeState(() {});
                                      },
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .end,
                                      children: [
                                        const SizedBox.shrink(),
                                        fromAmount != 0.0 &&
                                            toAmount != 0.0 &&
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
                                                  status = 'Cr';
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
                                                    value: 'Cr',
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
                                                  status = 'Dr';
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
                                                    value: 'Dr',
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
                                    24.verticalSpace,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate("billing_status"),
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
                                                  billingStatus = 'Billed';
                                                  isUserEdited = true;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context).translate("billed"),
                                                    style: size16weight400.copyWith(
                                                        color: colors(context)
                                                            .blackColor),
                                                  ),
                                                  Spacer(),
                                                  UBRadio<dynamic>(
                                                    value: 'Billed',
                                                    groupValue: billingStatus,
                                                    onChanged: (dynamic value) {
                                                      changeState(() {
                                                        billingStatus = value;
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
                                                  billingStatus = 'Unbilled';
                                                  isUserEdited = true;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context).translate("unbilled"),
                                                    style: size16weight400.copyWith(
                                                        color: colors(context)
                                                            .blackColor),
                                                  ),
                                                  Spacer(),
                                                  UBRadio<dynamic>(
                                                    value: 'Unbilled',
                                                    groupValue: billingStatus,
                                                    onChanged: (dynamic value) {
                                                      changeState(() {
                                                        billingStatus = value;
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
              //   Routes.kPortfolioFilterPastCardView,
              // );
              // if (result != null) {
              //   setState(() {
              //     cardTransactionFilterData = result as CardTransactionFilterData;
              //   });
                // bloc.add(CardTransactionsEvent(
                //   size: 10,
                //   page: pageNumberTran,
                //   accountNo: widget.cardTransactionArgs.accountNumber,
                //   messageType: 'creditCardTxnDetails',
                //   fromAmount: cardTransactionFilterData.fromAmount.toString(),
                //   toAmount: cardTransactionFilterData.toAmount.toString(),
                //   status: cardTransactionFilterData.status,
                //   fromDate: cardTransactionFilterData.fromDate,
                //   toDate: cardTransactionFilterData.toDate,
                //   billingStatus: cardTransactionFilterData.billingStatus,

                //   ///TODO:have to add billing status(back end request issue)
                // ));
              // }
            },
            icon:PhosphorIcon(PhosphorIcons.funnel(PhosphorIconsStyle.bold)),
          ),
        ],
      ),
      body: BlocProvider<CreditCardManagementBloc>(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc, BaseState<CreditCardManagementState>>(
          bloc: bloc,
          listener: (context, state) async {
            if(state is GetCardTxnHistorySuccessState){
              tranCount = state.cardTxnHistoryResponse!.txnDetails!.length;
              countL = state.cardTxnHistoryResponse?.noOfTransactions ?? 0;
              totalCreditAmount = state.cardTxnHistoryResponse?.totalCredit ?? 0;
              totalDebitAmount = state.cardTxnHistoryResponse?.totalDebit ?? 0;
              txnHistory.addAll(state.cardTxnHistoryResponse!.txnDetails!.map((e)=>TxnDetail(
                resAmount: e.resAmount,
                resDebitCreditIndicator: e.resDebitCreditIndicator,
                resLocalTxnAmount: e.resLocalTxnAmount,
                resLocalTxnCcy: e.resLocalTxnCcy,
                resMaskedCardNum: e.resMaskedCardNum,
                resOrgTxnAmt: e.resOrgTxnAmt,
                resOrgTxnCcy: e.resOrgTxnCcy,
                resRefNo: e.resRefNo,
                resTransDate: e.resTransDate,
                resTransDesc: e.resTransDesc,
                resTxnStatus: e.resTxnStatus
              )).toList());
              pageNumberTran = pageNumberTran + 1;
            }
            if(state is GetCardTxnHistoryFailedState){
              txnHistory = [];
            }


            // if (state is CardTransactionsSuccessState) {
            //   setState(() {
            //     if (pageNumberTran == 0) {
            //       transaction = state.transactions!;
            //     } else {
            //       transaction.addAll(state.transactions!);
            //     }
            //
            //     countL = state.count;
            //
            //     firstDate = DateFormat('dd-MMMM-yyyy').format(
            //         DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
            //             .parse(state.firstTxnDate.toString()));
            //     lastDate = DateFormat('dd-MMMM-yyyy').format(
            //         DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
            //             .parse(state.lastTxnDate.toString()));
            //     totalCreditAmount = state.totalCreditAmount;
            //     totalDebitAmount = state.totalDebitAmount;
            //   });
            // }
            else if (state is CCTransactionPdfDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo CCHist ${fromDate == null ? toDate == null ?
                  Jiffy.now().subtract(months: 1).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(toDate!).add(months: 1).isBefore(Jiffy.now()) ?
                  Jiffy.parse(toDate!).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(fromDate!).format(pattern: 'dd.MM.yyyy')} - ${toDate == null ? fromDate == null ?
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now()) ?
                  Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'dd.MM.yyyy')}",
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
            else if (state is CCTransactionExcelDownloadSuccessState) {
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo CCHist ${fromDate == null ? toDate == null ?
                  Jiffy.now().subtract(months: 1).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(toDate!).add(months: 1).isBefore(Jiffy.now()) ?
                  Jiffy.parse(toDate!).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(fromDate!).format(pattern: 'dd.MM.yyyy')} - ${toDate == null ? fromDate == null ?
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now()) ?
                  Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'dd.MM.yyyy') :
                  Jiffy.now().format(pattern: 'dd.MM.yyyy') :
                  Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'dd.MM.yyyy')}",
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
            else if (state is CCTransactionExcelDownloadFailedState) {
             ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
            else if (state is CCTransactionPdfDownloadFailedState) {
               ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);
            }
          },
          child: Stack(
            children: [
              // if(fromDate != null && toDate != null && fromAmount != null && toAmount != null && status != null && isFilterd == true)
              if(txnHistory.isEmpty)
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
              Column(
                children: [
                  if(isFilterd == true)
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: [
                                if (fromDate != null && toDate != null)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        fromDate = null;
                                        toDate = null;
                                        txnHistory.clear();
                                        if (fromDate == null &&
                                            toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData.isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text("${DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate!))} to ${DateFormat("dd-MMM-yyy").format(DateTime.parse(toDate!))}",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (fromDate != null && toDate == null)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        fromDate = null;
                                        if (fromDate == null &&
                                            toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).translate("from_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate!))}",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (fromDate == null && toDate != null)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        toDate = null;
                                        if (fromDate == null && toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).translate("to_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(toDate!))}",
                                        style:  size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (fromAmount != 0.00 && toAmount != 0.00)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        fromAmount = 0.0;
                                        toAmount = 0.0;
                                        if (fromDate == null &&
                                            toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null)
                                        {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).translate("lkr")} ${fromAmount.toString().withThousandSeparator()} - ${toAmount.toString().withThousandSeparator()}",
                                        style:  size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (fromAmount != 0.00 && toAmount == 0.0)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        fromAmount = 0.0;
                                        if (fromDate == null && toDate ==null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).translate("from_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${fromAmount.toString().withThousandSeparator()}",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (toAmount != 0.00 && fromAmount == 0.0)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        toAmount = 0.0;
                                        if (fromDate == null &&
                                            toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).translate("to_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${toAmount.toString().withThousandSeparator()}",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (status != null && isFilterd == true)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        status = null;
                                        if (fromDate == null && toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            billingStatus == null &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${status == "Cr" ? AppLocalizations.of(context).translate("credit") : status == "Dr" ? AppLocalizations.of(context).translate("debit") : AppLocalizations.of(context).translate("all")} ",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                if (billingStatus != null && isFilterd == true)
                                  FilteredChip(
                                    onTap: () {
                                      setState(() {
                                        txnHistory.clear();
                                        billingStatus = null;
                                        if (fromDate == null && toDate == null &&
                                            fromAmount == 0.0 &&
                                            toAmount == 0.0 &&
                                            status == null) {
                                          // accStatementFilterData
                                          //     .isFilterd = null;
                                        }
                                      });
                                      _loadStatement();
                                    },
                                    children: [
                                      Text(
                                        "${billingStatus == "Billed" ? AppLocalizations.of(context).translate("billed") :  AppLocalizations.of(context).translate("unbilled")} ",
                                        style: size14weight400.copyWith(color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(txnHistory.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w,16.h,20.w,0.h),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
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
                                              "${AppLocalizations.of(context).translate("lkr")} ${
                                                  totalCreditAmount
                                                      .toString()
                                                      .withThousandSeparator()
                                              }",
                                              style: size14weight700.copyWith(color: colors(context).positiveColor),
                                            ),
                                            Text(
                                              AppLocalizations.of(context).translate("total_credit"),
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
                                              "${AppLocalizations.of(context).translate("lkr")} ${
                                                  totalDebitAmount
                                                      .toString()
                                                      .withThousandSeparator()
                                              }",
                                              style: size14weight700.copyWith(color: colors(context).negativeColor),
                                            ),
                                            Text(
                                              AppLocalizations.of(context).translate("total_debit"),
                                              style: size12weight400.copyWith(color: colors(context).greyColor),
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Visibility(
                            //   visible: cardTransactionFilterData.isFilterd == null ,
                            //   child: UBTransactionHistoryContainer(
                            //     title: widget.cardTransactionArgs.cardType!,
                            //     subTitle: widget.cardTransactionArgs.cardNumber??"",
                            //     amount: widget.cardTransactionArgs.availableCreditLimit!,
                            //   ),
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
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // cardTransactionFilterData.fromDate != null &&
                            //             cardTransactionFilterData.toDate != null ||
                            //         cardTransactionFilterData.fromDate != null &&
                            //             cardTransactionFilterData.toDate == null ||
                            //         cardTransactionFilterData.fromDate == null &&
                            //             cardTransactionFilterData.toDate != null ||
                            //         cardTransactionFilterData.status != null ||
                            //         cardTransactionFilterData.fromAmount != null &&
                            //             cardTransactionFilterData.toAmount != null ||
                            //         cardTransactionFilterData.fromAmount != null &&
                            //             cardTransactionFilterData.toAmount == null ||
                            //         cardTransactionFilterData.fromAmount == null &&
                            //             cardTransactionFilterData.toAmount != null
                            //     ? Padding(
                            //       padding: const EdgeInsets.only(left: 25,right: 25),
                            //       child: Wrap(
                            //         children: [
                            //           if (cardTransactionFilterData.fromDate !=
                            //                   null &&
                            //               cardTransactionFilterData.toDate != null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "${DateFormat("dd-MMM-yyy").format(DateTime.parse(cardTransactionFilterData.fromDate!))} to ${DateFormat("dd-MMM-yyy").format(DateTime.parse(cardTransactionFilterData.toDate!))}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .fromDate = null;
                            //                               cardTransactionFilterData
                            //                                   .toDate = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null ){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.fromDate !=
                            //                   null &&
                            //               cardTransactionFilterData.toDate == null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "From Date - ${DateFormat("dd-MMM-yyy").format(DateTime.parse(cardTransactionFilterData.fromDate!))}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .fromDate = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.fromDate ==
                            //                   null &&
                            //               cardTransactionFilterData.toDate != null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "To Date - ${DateFormat("dd-MMM-yyy").format(DateTime.parse(cardTransactionFilterData.toDate!))}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .toDate = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.fromAmount !=
                            //                   null &&
                            //               cardTransactionFilterData.toAmount != null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "Rs.${cardTransactionFilterData.fromAmount} to Rs.${cardTransactionFilterData.toAmount}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .fromAmount = null;
                            //                               cardTransactionFilterData
                            //                                   .toAmount = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.fromAmount !=
                            //                   null &&
                            //               cardTransactionFilterData.toAmount == null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "From Amount - Rs.${cardTransactionFilterData.fromAmount}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .fromAmount = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null ){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.fromAmount ==
                            //                   null &&
                            //               cardTransactionFilterData.toAmount != null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "To Amount - Rs.${cardTransactionFilterData.fromAmount}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .toAmount = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           if (cardTransactionFilterData.status != null)
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   right: 5, bottom: 5),
                            //               child: IntrinsicWidth(
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(4),
                            //                     color: colors(context)
                            //                         .greyColor400,
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       children: [
                            //                         Text(
                            //                           "${cardTransactionFilterData.status}",
                            //                           style: const TextStyle(
                            //                               fontSize: 15),
                            //                         ),
                            //                         VerticalDivider(
                            //                           color: colors(context)
                            //                               .greyColor200,
                            //                           thickness: 1,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             setState(() {
                            //                               cardTransactionFilterData
                            //                                   .status = null;
                            //                               if(cardTransactionFilterData
                            //                                   .fromDate == null && cardTransactionFilterData
                            //                                   .toDate == null && cardTransactionFilterData
                            //                                   .fromAmount == null && cardTransactionFilterData
                            //                                   .toAmount == null && cardTransactionFilterData
                            //                                   .status == null ){
                            //                                 cardTransactionFilterData.isFilterd=null;
                            //                               }
                            //                             });
                            //                             _loadTransactions();
                            //                           },
                            //                           child: Image.asset(
                            //                             AppAssets.icCancelIcon,
                            //                             scale: 3,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //         ],
                            //       ),
                            //     )
                            //     : Padding(
                            //       padding: const EdgeInsets.only(left: 25,right: 25),
                            //       child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             const Text(
                            //               "Transaction History Period",
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.w400, fontSize: 14),
                            //             ),
                            //             const SizedBox(height: 5),
                            //             Text(
                            //               "$firstDate to $lastDate",
                            //               style: const TextStyle(
                            //                   fontWeight: FontWeight.w700, fontSize: 16),
                            //             ),
                            //           ],
                            //         ),
                            //     ),
                            // Text(
                            //   "No of Results : $countL",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w700,
                            //     fontSize: 16,
                            //     color: colors(context).primaryColor,
                            //   ),
                            // ),
                            16.verticalSpace,
                            Expanded(
                              child: SingleChildScrollView(
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
                                      padding: EdgeInsets.fromLTRB(16.w,16.h,16.w,0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "$countL ${AppLocalizations.of(context).translate("results")}",
                                              style: size16weight700.copyWith(color: colors(context).blackColor)
                                          ),
                                          // 16.verticalSpace,
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: txnHistory.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  UBPortfolioUnbuildContent(
                                                    title: txnHistory[index].resTransDesc.toString(),
                                                    subTitle: txnHistory[index].resRefNo!,
                                                    data: txnHistory[index].resAmount.toString().withThousandSeparator(),
                                                    subData: txnHistory[index].resTransDate,
                                                    //DateFormat('').parse(txnHistory[index].resTransDate??""),
                                                    isCR: txnHistory[index].resDebitCreditIndicator!,
                                                  ),
                                                  if(txnHistory.length-1 != index)
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  // if (widget.cardTransactionArgs.transaction.isNotEmpty)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Column(
                  //         children: [
                  //           Image.asset(
                  //             AppAssets.icGreenDot,
                  //             scale: 3,
                  //           ),
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)
                  //                 .translate("total_credit_amount"),
                  //             style: TextStyle(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //               color: colors(context).blackColor,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //           Row(
                  //             children: [
                  //               Image.asset(
                  //                 AppAssets.icLkrFrme,
                  //                 scale: 3,
                  //               ),
                  //               const SizedBox(
                  //                 width: 5,
                  //               ),
                  //               RichText(
                  //                   text: TextSpan(children: [
                  //                 TextSpan(
                  //                   text: totalCreditAmount.toString().withThousandSeparator(),
                  //                   style: TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w600,
                  //                     color: colors(context).blackColor,
                  //                   ),
                  //                 ),
                  //               ])),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
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
                  //               // AppLocalizations.of(context)
                  //               //     .translate("total_credit_amount"),
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
                  //             Row(
                  //               children: [
                  //                 Image.asset(
                  //                   AppAssets.icLkrFrme,
                  //                   scale: 3,
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 RichText(
                  //                     text: TextSpan(children: [
                  //                   TextSpan(
                  //                     text: totalDebitAmount.toString().withThousandSeparator(),
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w600,
                  //                       color: colors(context).blackColor,
                  //                     ),
                  //                   ),
                  //                 ])),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadTransactions() {
    // bloc.add(CardTransactionsEvent(
    //   size: 10,
    //   page: 0,
    //   accountNo: widget.cardTransactionArgs.accountNumber,
    //   messageType: 'creditCardTxnDetails',
    //   fromAmount: cardTransactionFilterData.fromAmount.toString(),
    //   toAmount: cardTransactionFilterData.toAmount.toString(),
    //   status: cardTransactionFilterData.status,
    //   fromDate: cardTransactionFilterData.fromDate,
    //   toDate: cardTransactionFilterData.toDate,
    //   billingStatus: cardTransactionFilterData.billingStatus,
    // ));
  }

  // _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (BuildContext context,
  //             StateSetter setState /*You can rename this!*/) {
  //           return SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.4,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     AppLocalizations.of(context)
  //                         .translate("select_downloading_option"),
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w600,
  //                       color: colors(context).blackColor,
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       InkWell(
  //                         onTap: () {
  //                           setState(() {
  //                             download =
  //                                 Download.EX; // Update the selected option
  //                           });
  //                         },
  //                         child: Material(
  //                           borderRadius: BorderRadius.circular(8),
  //                           color: download == Download.EX
  //                               ? const Color(
  //                                   0xffD9D9D9) // Set color when selected
  //                               : Colors.transparent,
  //                           child: SizedBox(
  //                             width: 100,
  //                             height: 100,
  //                             child: Center(
  //                               child: Image.asset(
  //                                 AppAssets.icExcel,
  //                                 scale: 3,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           setState(() {
  //                             download =
  //                                 Download.PDF; // Update the selected option
  //                           });
  //                         },
  //                         child: Material(
  //                           borderRadius: BorderRadius.circular(8),
  //                           color: download == Download.PDF
  //                               ? const Color(
  //                                   0xffD9D9D9) // Set color when selected
  //                               : Colors.transparent,
  //                           child: SizedBox(
  //                             width: 100,
  //                             height: 100,
  //                             child: Center(
  //                               child: Image.asset(
  //                                 AppAssets.icPdf,
  //                                 scale: 3,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(10),
  //                     child: AppButton(
  //                       buttonType: (download == Download.NON)
  //                           ? ButtonType.PRIMARYDISABLED
  //                           : ButtonType.PRIMARYENABLED,
  //                       buttonText:
  //                           AppLocalizations.of(context).translate("download"),
  //                       onTapButton: () {
  //                         download == Download.PDF
  //                             ? _downloadEReceipt(true)
  //                             : _downloadExcelReceipt(true);
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ));
  //         });
  //       });
  // }

  _downloadEReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        CCTransactionPdfDownloadEvent(
          maskedCardNumber: widget.cardTransactionArgs.cardNumber,
          txnMonthsFrom: fromDate == null && toDate == null
              ? Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd')
              : fromDate == null && toDate != null
              ? Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd')
              : Jiffy.parse(fromDate!).format(pattern: 'yyMMdd'),
          txnMonthsTo: fromDate == null && toDate == null
              ? Jiffy.now().format(pattern: 'yyMMdd')
              : fromDate != null && toDate == null
              ? (Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now())
              ? Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'yyMMdd')
              : Jiffy.now().format(pattern: 'yyMMdd'))
              : Jiffy.parse(toDate!).format(pattern: 'yyMMdd'),
          fromAmount: fromAmount == 0 || fromAmount == 0.0 || fromAmount == 0.00 ? null : fromAmount,
          toAmount: toAmount == 0 || toAmount == 0.0 || toAmount == 0.00 ? null : toAmount,
          status: status,
          billingStatus: billingStatus,
          shouldOpen: shouldStore,
        ),
      );
    });
  }

  _downloadExcelReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      bloc.add(
        CCTransactionExcelDownloadEvent(
          maskedCardNumber: widget.cardTransactionArgs.cardNumber,
          txnMonthsFrom: fromDate == null && toDate == null
              ? Jiffy.now().subtract(months: 1).format(pattern: 'yyMMdd')
              : fromDate == null && toDate != null
              ? Jiffy.parse(toDate!).subtract(months: 1).format(pattern: 'yyMMdd')
              : Jiffy.parse(fromDate!).format(pattern: 'yyMMdd'),
          txnMonthsTo: fromDate == null && toDate == null
              ? Jiffy.now().format(pattern: 'yyMMdd')
              : fromDate != null && toDate == null
              ? (Jiffy.parse(fromDate!).add(months: 1).isBefore(Jiffy.now())
              ? Jiffy.parse(fromDate!).add(months: 1).format(pattern: 'yyMMdd')
              : Jiffy.now().format(pattern: 'yyMMdd'))
              : Jiffy.parse(toDate!).format(pattern: 'yyMMdd'),
          fromAmount: fromAmount == 0 || fromAmount == 0.0 || fromAmount == 0.00 ? null : fromAmount,
          toAmount: toAmount == 0 || toAmount == 0.0 || toAmount == 0.00 ? null : toAmount,
          status: status,
          billingStatus: billingStatus,
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
      fromAmount = 0.0;
      toAmount = 0.0;
      _controller3 = CurrencyTextEditingController();
      _controller4 = CurrencyTextEditingController();
      // _controller4.clear();
      status = null;
      billingStatus = null;
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
        fromAmount != 0.0 ||
        toAmount != 0.0 ||
        billingStatus != null ||
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
    if (fromAmount == 0.0 || toAmount == 0.0) {
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
