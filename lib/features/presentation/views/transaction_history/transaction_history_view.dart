import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/account_statements_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/domain/entities/response/account_entity.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/data/transaction_filter.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/transaction_history_status_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/filtered_chip.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/widgets/transaction_history_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/network/network_config.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../../utils/text_editing_controllers.dart';
import '../../../data/models/responses/transcation_details_response.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class TransactionHistoryFlowView extends BaseView {
  final bool isFromHome;

  TransactionHistoryFlowView({this.isFromHome = false});

  @override
  _TransactionHistoryFlowViewState createState() =>
      _TransactionHistoryFlowViewState();
}

class _TransactionHistoryFlowViewState
    extends BaseViewState<TransactionHistoryFlowView> {
  var _bloc = injection<TransactionBloc>();

  DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
  int countL = 0;
  Download download = Download.NON;

  // String? transactionType;

  bool isFiltered = false;
  bool downloadButton = true;
  bool dateFilter = true;
  bool amountFilter = true;
  List<TxnDetailList> itemsList = [];
  List<AccountEntity> accountList = [];
  List<AccountEntity> searchAccountList = [];

  // List<Transactionr> filteredItemsList = [];
  int? size = 20;

  int pageNumberTran = 0;
  int pageNumberTranF = 0;

  final _scrollControllerTran = ScrollController();
  TransactionFilter filters = TransactionFilter();

  String? selectedAccount;
  String? selectedTempororyAccount;

  CommonDropDownResponse? selectedTransType;
  CommonDropDownResponse? selectedTransTypeTemporory;

  DateTime? fromDateV;
  String? fromDate;
  DateTime? toDateV;
  String? toDate;

  double? fromAmount = 0;
  double? toAmount = 0;
  String? channel;
  // EdgeInsetsGeomet
  //
  bool isShow = true;
  //ry padding = const EdgeInsets.fromLTRB(5, 6, 5, 0).w;

  DateTime? fromDateToRecipt;
  DateTime? toDateToRecipt;

  CurrencyTextEditingController _fromAccountController =
      CurrencyTextEditingController();
  CurrencyTextEditingController _toAccountController =
      CurrencyTextEditingController();

  final ThousandsSeparatorInputFormatter thousandFormatter =
      ThousandsSeparatorInputFormatter();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollControllerTran.addListener(_onScrollTran);
    // _scrollControllerTran.addListener(_onScrollPadding);
  }

  // _onScrollPadding() {
  //   final minScroll = _scrollControllerTran.position.minScrollExtent;
  //   final currentScroll = _scrollControllerTran.position.pixels;
  //   if (currentScroll <= 0) {
  //     padding = const EdgeInsets.fromLTRB(5, 6, 5, 2).w;
  //     setState(() {});
  //   } else {
  //     padding = const EdgeInsets.fromLTRB(5, 0, 5, 2).w;
  //     setState(() {});
  //   }
  // }

  void _loadInitialData() {
    _bloc.add(GetTransactionDetailsEventEvent(size: 20, page: 0));
    _bloc.add(GetInstrumentTransactionEvent());
  }

  void _onScrollTran() {
    final maxScroll = _scrollControllerTran.position.maxScrollExtent;
      final currentScroll = _scrollControllerTran.position.pixels;
    if (countL != itemsList.length) {
      
      if (maxScroll - currentScroll == 0) {
        if (filters.isFiltered == true) {
          _bloc.add(TransactionFilterEvent(
            account: filters.selectedAccount,
            fromDate: filters.fromDate,
            toDate: filters.toDate,
            fromAmount: filters.fromAmount,
            toAmount: filters.toAmount,
            tranType: filters.transactionType?.key ?? null,
            page: pageNumberTranF,
            channel: filters.channel,
            size: 20,
          ));
        } else {
          _bloc.add(GetTransactionDetailsEventEvent(
            size: 20,
            page: pageNumberTran,
          ));
        }
      }
      // setState(() {});
    }else{
       if (maxScroll - currentScroll == 0  && isShow) {
       if (itemsList.length >=100 && filters.isFiltered == true) {
        setState(() {
         isShow = false;
        });
                showAppDialog(
                  alertType: AlertType.DOCUMENT3,
                  negativeButtonText:AppLocalizations.of(context).translate("close"),
                  title: AppLocalizations.of(context).translate("exceed_record"),
                  message:AppLocalizations.of(context).translate("exceed_record_msg"),
                  positiveButtonText:AppLocalizations.of(context).translate("Try_Again"),
                  onBottomButtonCallback: () {
                  },
                );
           }
       }
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50!,
      appBar: UBAppBar(
        goBackEnabled: widget.isFromHome ? true : false,
        title: AppLocalizations.of(context).translate("activity_log"),
        actions: [
          // InkWell(
          //   onTap: () {

          //     Navigator.pushNamed(context, Routes.kFilterTransactionView)
          //         .then((filter) {
          //       if (filter != null) {
          //         setState(() {
          //           itemsList.clear();
          //           filters = filter as TransactionFilter;
          //         });

          //         _filterDaata();
          //       }
          //     });
          //   },
          //   child: Image.asset(
          //     AppAssets.icTransFilter,
          //     scale: 3,
          //   ),
          // ),
          itemsList.isNotEmpty ||
                  (itemsList.isEmpty && filters.isFiltered == true)
              ? IconButton(
                  onPressed: () async {
                    final result = await showModalBottomSheet<bool>(
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
                                isTwoButton: true,
                                title: AppLocalizations.of(context)
                                    .translate('filter_transactions'),
                                buttons: [
                                  Expanded(
                                    child: AppButton(
                                        buttonType: ButtonType.OUTLINEENABLED,
                                        buttonText: AppLocalizations.of(context)
                                            .translate("reset"),
                                        onTapButton: () {
                                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                          if (filters.isFiltered == true) {
                                            changeState(() {
                                              itemsList.clear();
                                              pageNumberTran = 0;
                                              pageNumberTranF = 0;
                                              filters = TransactionFilter();
                                            });
                                            _bloc.add(
                                                GetTransactionDetailsEventEvent(
                                              size: 20,
                                              page: 0,
                                            ));
                                          }
                                          changeState(() {
                                            selectedAccount = null;
                                            selectedTransType = null;
                                            fromDate = null;
                                            fromDateV = null;
                                            toDateV = null;
                                            toDate = null;
                                            fromAmount = 0;
                                            toAmount = 0;
                                            _fromAccountController = CurrencyTextEditingController();
                                            _toAccountController = CurrencyTextEditingController();
                                            channel = null;
                                            selectedTempororyAccount = null;
                                            selectedTransTypeTemporory = null;
                                          });
                                        }),
                                  ),
                                  16.horizontalSpace,
                                  Expanded(
                                    child: AppButton(
                                      buttonType: _isButtonEnable()
                                          ? ButtonType.PRIMARYENABLED
                                          : ButtonType.PRIMARYDISABLED,
                                      buttonText: AppLocalizations.of(context)
                                          .translate("apply"),
                                      onTapButton: () {
                                        changeState(() {
                                          itemsList.clear();

                                          filters = TransactionFilter(
                                            isFiltered: true,
                                            selectedAccount: selectedAccount,
                                            toAmount:
                                                toAmount == 0 ? null : toAmount,
                                            fromAmount: fromAmount == 0
                                                ? null
                                                : fromAmount,
                                            toDate: toDate,
                                            fromDate: fromDate,
                                            channel: channel,
                                            transactionType: selectedTransType,
                                          );
                                        });

                                        _filterDaata();

                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ),
                                ],
                                children: [
                                  AppDropDown(
                                    labelText: AppLocalizations.of(context)
                                        .translate("select_account"),
                                    label: AppLocalizations.of(context)
                                        .translate("account"),
                                    onTap: () async {
                                      final result =
                                          await showModalBottomSheet<bool>(
                                              isScrollControlled: true,
                                              useRootNavigator: true,
                                              useSafeArea: true,
                                              context: context,
                                              barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                backgroundColor: Colors.transparent,
                                              builder: (
                                                context,
                                              ) =>
                                                  StatefulBuilder(builder:
                                                      (context, changeState) {
                                                    return BottomSheetBuilder(
                                                      isSearch: true,
                                                      onSearch: (p0) {
                                                        changeState(() {
                                                          if (p0.isEmpty ||
                                                              p0 == '') {
                                                            searchAccountList =
                                                                accountList;
                                                          } else {
                                                            searchAccountList = accountList
                                                                .where((element) => element
                                                                    .nickName!
                                                                    .toLowerCase()
                                                                    .contains(p0
                                                                        .toLowerCase())).toSet()
                                                                .toList();
                                                          }
                                                        });
                                                      },
                                                      title: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              "select_account"),
                                                      buttons: [
                                                        Expanded(
                                                          child: AppButton(
                                                              buttonType: ButtonType
                                                                  .PRIMARYENABLED,
                                                              buttonText: AppLocalizations
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      "continue"),
                                                              onTapButton: () {
                                                                selectedAccount =
                                                                    selectedTempororyAccount;
                                                               WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                                changeState(
                                                                    () {});
                                                                setState(() {});
                                                              }),
                                                        ),
                                                      ],
                                                      children: [
                                                        ListView.builder(
                                                          itemCount:
                                                              searchAccountList
                                                                  .length,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                           padding: EdgeInsets.zero,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                selectedTempororyAccount =
                                                                    searchAccountList[
                                                                            index]
                                                                        .accountNumber;
                                                                changeState(
                                                                    () {});
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                     padding:  EdgeInsets.only(top:  index == 0 ?0:20,bottom:  20).h,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              searchAccountList[index].accountNumber!,
                                                                              style: size16weight700.copyWith(
                                                                                color: colors(context).blackColor,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 8).w,
                                                                              child: UBRadio<dynamic>(
                                                                                value: searchAccountList[index].accountNumber ?? "",
                                                                                groupValue: selectedTempororyAccount,
                                                                                onChanged: (value) {
                                                                                  selectedTempororyAccount = searchAccountList[index].accountNumber;
                                                                                  changeState(() {});
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          searchAccountList[index]
                                                                              .nickName!,
                                                                          style:
                                                                              size14weight400.copyWith(
                                                                            color:
                                                                                colors(context).greyColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if ((searchAccountList
                                                                              .length -
                                                                          1) !=
                                                                      index)
                                                                    Divider(
                                                                      height: 0,
                                                                      thickness:
                                                                          1.w,
                                                                      color: colors(
                                                                              context)
                                                                          .greyColor100,
                                                                    )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }));
                                      changeState(() {});
                                    },
                                    initialValue: selectedAccount,
                                  ),
                                  24.verticalSpace,
                                  AppDatePicker(
                                    initialValue: ValueNotifier(fromDate != null
                                        ? DateFormat('dd-MMM-yyyy')
                                            .format(DateTime.parse(fromDate!))
                                        : null),
                                    isFromDateSelected: true,
                                    firstDate:
                                    // DateTime.now().subtract(const Duration(days: 365)),
                                    Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 1).dateTime,
                                    lastDate: DateTime.now(),
                                    labelText: AppLocalizations.of(context)
                                        .translate("from_date"),
                                    onChange: (value) {
                                      changeState(() {
                                        fromDate = value;
                                        fromDateV = DateTime.parse(fromDate!);
                                      });
                                    },
                                    initialDate: DateTime.parse(
                                        fromDate ?? DateTime.now().toString()),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox.shrink(),
                                      fromDate != null &&
                                              toDate != null &&
                                              toDateV!.isBefore(fromDateV!)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 12)
                                                      .h,
                                              child: Text(
                                                "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: toDateV!.isBefore(
                                                            fromDateV!)
                                                        ? colors(context)
                                                            .negativeColor
                                                        : colors(context)
                                                            .blackColor),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  24.verticalSpace,
                                  AppDatePicker(
                                    initialValue: ValueNotifier(toDate != null
                                        ? DateFormat('dd-MMM-yyyy')
                                            .format(DateTime.parse(toDate!))
                                        : null),
                                    isFromDateSelected: true,
                                    firstDate: fromDateV,
                                    lastDate: DateTime.now(),
                                    labelText: AppLocalizations.of(context)
                                        .translate("to_date"),
                                    onChange: (value) {
                                      changeState(() {
                                        toDate = value;
                                        toDateV = DateTime.parse(toDate!);
                                      });
                                    },
                                    initialDate: DateTime.parse(
                                        toDate ?? DateTime.now().toString()),
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    controller: _fromAccountController,
                                    isCurrency: true,
                                    showCurrencySymbol: true,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    hint: AppLocalizations.of(context)
                                        .translate("from_amount_desc"),
                                    title: AppLocalizations.of(context)
                                        .translate("from_amount"),
                                    onTextChanged: (value) {
                                      changeState(() {
                                        fromAmount = double.parse(
                                            value.replaceAll(",", ""));
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    controller: _toAccountController,
                                    isCurrency: true,
                                    showCurrencySymbol: true,
                                    hint: AppLocalizations.of(context)
                                        .translate("to_amount_desc"),
                                    title: AppLocalizations.of(context)
                                        .translate("to_amount"),
                                    onTextChanged: (value) {
                                      changeState(() {
                                        toAmount = double.parse(
                                            value.replaceAll(",", ""));
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppDropDown(
                                    labelText: AppLocalizations.of(context)
                                        .translate("select_your_trans_type"),
                                    label: AppLocalizations.of(context)
                                        .translate("transaction_type"),
                                    onTap: () async {
                                      final result = await showModalBottomSheet<
                                              bool>(
                                          isScrollControlled: true,
                                          useRootNavigator: true,
                                          useSafeArea: true,
                                          context: context,
                                         barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                backgroundColor: Colors.transparent,
                                          builder: (
                                            context,
                                          ) =>
                                              StatefulBuilder(builder:
                                                  (context, changeState) {
                                                return BottomSheetBuilder(
                                                  title: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "select_your_trans_type"),
                                                  buttons: [
                                                    Expanded(
                                                      child: AppButton(
                                                          buttonType: ButtonType
                                                              .PRIMARYENABLED,
                                                          buttonText:
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      "continue"),
                                                          onTapButton: () {
                                                            selectedTransType =
                                                                selectedTransTypeTemporory;
                                                           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            changeState(() {});
                                                            setState(() {});
                                                          }),
                                                    ),
                                                  ],
                                                  children: [
                                                    ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: AppConstants
                                                          .kGetTransTypeList
                                                          .length,
                                                      shrinkWrap: true,
                                                       padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            selectedTransTypeTemporory =
                                                                AppConstants
                                                                        .kGetTransTypeList[
                                                                    index];
                                                            changeState(() {});
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                 padding:  EdgeInsets.only(top:  index == 0 ?0:24,bottom:  24).h,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      AppConstants
                                                                          .kGetTransTypeList[
                                                                              index]
                                                                          .description!,
                                                                      style: size16weight700
                                                                          .copyWith(
                                                                        color: colors(context)
                                                                            .blackColor,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(right: 8).w,
                                                                      child: UBRadio<
                                                                          dynamic>(
                                                                        value: AppConstants
                                                                                .kGetTransTypeList[index]
                                                                                .key ??
                                                                            "",
                                                                        groupValue:
                                                                            selectedTransTypeTemporory
                                                                                ?.key,
                                                                        onChanged:
                                                                            (value) {
                                                                          selectedTransTypeTemporory =
                                                                              AppConstants.kGetTransTypeList[index];
                                                                          changeState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (AppConstants
                                                                          .kGetTransTypeList
                                                                          .length -
                                                                      1 !=
                                                                  index)
                                                                Divider(
                                                                  height: 0,
                                                                  thickness: 1.w,
                                                                  color: colors(
                                                                          context)
                                                                      .greyColor100,
                                                                )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                );
                                              }));
                                      changeState(() {});
                                    },
                                    initialValue:
                                        selectedTransType?.description,
                                  ),
                                  24.verticalSpace,
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate("channel"),
                                          style: size14weight700.copyWith(
                                            color: colors(context).blackColor!,
                                          ),
                                        ),
                                        18.verticalSpace,
                                        Column(
                                          children: [
                                            InkWell(
                                            onTap: () {
                                              changeState(() {
                                                  channel = 'MB';
                                                });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context).translate("mobile_banking"),
                                                  style: size16weight400.copyWith(
                                                      color: colors(context)
                                                          .blackColor),
                                                ),
                                                Spacer(),
                                                UBRadio<dynamic>(
                                                  value: 'MB',
                                                  groupValue: channel,
                                                  onChanged: (value) {
                                                    changeState(() {
                                                  channel = value;
                                                    });
                                                  },
                                                ),
                                                8.horizontalSpace
                                              ],
                                            ),
                                          ),
                                            20.verticalSpace,
                                            InkWell(
                                            onTap: () {
                                              changeState(() {
                                                  channel = 'IB';
                                                });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context).translate("internet_banking"),
                                                  style: size16weight400.copyWith(
                                                      color: colors(context)
                                                          .blackColor),
                                                ),
                                                Spacer(),
                                                UBRadio<dynamic>(
                                                  value: 'IB',
                                                  groupValue: channel,
                                                  onChanged: (value) {
                                                    changeState(() {
                                                  channel = value;
                                                    });
                                                  },
                                                ),
                                                8.horizontalSpace
                                              ],
                                            ),
                                          )
                                          ],
                                        ),
                                       
                                      ]),
                                       20.verticalSpace
                                ],
                              );
                            }));
                  },
                  icon: PhosphorIcon(
                    PhosphorIcons.funnel(PhosphorIconsStyle.bold),size: 24.w,
                  ))
              : SizedBox.shrink()
        ],
      ),
      body: BlocProvider<TransactionBloc>(
        create: (_) => _bloc,
        child: BlocListener<TransactionBloc, BaseState<TransactionState>>(
          listener: (_, state) async {
            if (state is TransactionDetailsSuccessState) {
              filters.isFiltered = false;
              if (pageNumberTran == 0) {
                itemsList.clear();
                itemsList = state.txnDetailList!;
              } else {
                itemsList.addAll(state.txnDetailList!);
              }
              countL = state.count ?? 0;
              pageNumberTran = pageNumberTran + 1;
              pageNumberTranF = 0;
              setState(() {});
            }
            else if (state is TransactionDetailsFailedState) {
              if (state.code == APIResponse.SERVER_ERROR) {
                showAppDialog(
                    alertType: AlertType.CONNECTION,
                    title: AppLocalizations.of(context).translate("unable_connect_server"),
                    message: AppLocalizations.of(context).translate("connection_could_not_be_made"),
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    onPositiveCallback: () {
                      Navigator.pushNamed(context, Routes.kHomeBaseView);
                    });
              } else {
                ToastUtils.showCustomToast(
                    context, state.message.toString(), ToastStatus.FAIL);
              }
            }
            if (state is TransactionFilterPdfDownloadSuccessState) {
              if(filters.fromDate != null){
                fromDateToRecipt = DateTime.parse(filters.fromDate!);
              } else {
                fromDateToRecipt = itemsList.first.modifiedDate;
              }
              if(filters.toDate != null){
                toDateToRecipt = DateTime.parse(filters.toDate!);
              } else {
                toDateToRecipt = itemsList.last.modifiedDate;
              }
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo Activity ${DateFormat('dd.MM.yyyy').format(fromDateToRecipt!)} - ${DateFormat('dd.MM.yyyy').format(toDateToRecipt!)}",
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
            if (state is TransactionFilterExcelDownloadSuccessState) {
              if(filters.fromDate != null){
                fromDateToRecipt = DateTime.parse(filters.fromDate!);
              } else {
                fromDateToRecipt = itemsList.first.modifiedDate;
              }
              if(filters.toDate != null){
                toDateToRecipt = DateTime.parse(filters.toDate!);
              } else {
                toDateToRecipt = itemsList.last.modifiedDate;
              }
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: "UBgo Activity ${DateFormat('dd.MM.yyyy').format(fromDateToRecipt!)} - ${DateFormat('dd.MM.yyyy').format(toDateToRecipt!)}",
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
            if (state is TransactionFilterSuccessState) {
              filters.isFiltered = true;
                if (pageNumberTranF == 0) {
                  itemsList.clear();
                  itemsList = state.txnDetailListFiltered ?? [];
                } else {
                  itemsList.addAll(state.txnDetailListFiltered ?? []);
                }
                countL = state.count ?? 0;
                pageNumberTranF = pageNumberTranF + 1;
                pageNumberTran = 0;
              setState(() {});
              // pageNumberTran = 0;
            }
            if (state is GetInstrumentTransactionSuccessState) {
              if (state.getUserInstList?.length != 0 &&
                  state.getUserInstList != null) {
                setState(() {
                  accountList.clear();
                  accountList.addAll(state.getUserInstList!
                      .map((e) => AccountEntity(
                            status: e.status,
                            instrumentId: e.id,
                            bankName: e.bankName,
                            bankCode: e.bankCode,
                            accountNumber: e.accountNo,
                            nickName: e.nickName ?? "",
                            availableBalance:
                                double.parse(e.accountBalance ?? "0.00"),
                            accountType: e.accType,
                            isPrimary: e.isPrimary,
                          ))
                      .toList());
                  accountList = accountList
                      .where((element) =>
                          (element.accountType?.toUpperCase() == "S" &&
                              element.status?.toUpperCase() == "ACTIVE") ||
                          (element.accountType?.toUpperCase() == "D" &&
                              element.status?.toUpperCase() == "ACTIVE"))
                      .toList();
                  searchAccountList = accountList;
                });
              }
              if (state is GetInstrumentTransactionFailedState) {}
            }
          },
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ).w,
              child: Stack(
                children: [
                  filters.isFiltered == true && itemsList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: colors(context).secondaryColor300,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(14).w,
                                  child: PhosphorIcon(
                                    PhosphorIcons.article(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).whiteColor,
                                    size: 28.w,
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate('no_result_found'),
                                style: size18weight700.copyWith(
                                    color: colors(context).blackColor),
                              ),
                              4.verticalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate('adjust_your_filters'),
                                style: size14weight400.copyWith(
                                    color: colors(context).greyColor),
                              )
                            ],
                          ),
                        )
                      : itemsList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            colors(context).secondaryColor300,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14).w,
                                      child: PhosphorIcon(
                                        PhosphorIcons.article(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).whiteColor,
                                        size: 28.w,
                                      ),
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    AppLocalizations.of(context).translate(
                                        'no_recent_activities_title'),
                                    style: size18weight700.copyWith(
                                        color: colors(context).blackColor),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    AppLocalizations.of(context).translate(
                                        'no_recent_activities_description'),
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  )
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                  //  filters.isFiltered==true ?Column(
                  //    children: [
                  //      Align(
                  //            alignment: Alignment.topLeft,
                  //        child: Padding(
                  //          padding:  EdgeInsets.only(top: filters.isFiltered ==true? 12:0).h,
                  //          child: Column(
                  //            mainAxisSize: MainAxisSize.min,
                  //            children: [
                  //              Wrap(
                  //                children: [
                  //                  if (filters.selectedAccount != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.selectedAccount = null;
                  //                          selectedAccount = null;
                  //                          selectedTempororyAccount = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          filters.selectedAccount.toString(),
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromDate == null && filters.toDate != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.toDate = null;
                  //                          toDateV = null;
                  //                          toDate = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "To date - ${filters.toDate}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromDate != null && filters.toDate == null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.fromDate = null;
                  //                          fromDate = null;
                  //                          fromDateV = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "From date - ${filters.fromDate}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromDate != null && filters.toDate != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.fromDate = null;
                  //                          fromDate = null;
                  //                          fromDateV = null;
                  //                          filters.toDate = null;
                  //                          toDateV = null;
                  //                          toDate = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "${DateFormat('dd-MMM-yyyy').format(DateTime.parse(filters.fromDate ?? DateTime.now().toString()))} to ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(filters.toDate ?? DateTime.now().toString()))}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromAmount == null &&
                  //                      filters.toAmount != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.toAmount = null;
                  //                          toAmount = 0;
                  //                          _toAccountController= CurrencyTextEditingController();
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "To Amount - LKR ${filters.toAmount}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromAmount != null &&
                  //                      filters.toAmount == null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.fromAmount = null;
                  //                          fromAmount = 0;
                  //                          _fromAccountController= CurrencyTextEditingController();
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "From Amount - LKR ${filters.fromAmount}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.fromAmount != null &&
                  //                      filters.toAmount != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.fromAmount = null;
                  //                          fromAmount = 0;
                  //                          _fromAccountController= CurrencyTextEditingController();
                  //                          filters.toAmount = null;
                  //                          toAmount = 0;
                  //                          _toAccountController= CurrencyTextEditingController();
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          "LKR ${filters.fromAmount} to LKR ${filters.toAmount}",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.channel != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.channel = null;
                  //                          channel = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          filters.channel == "MB"
                  //                              ? "Mobile Banking"
                  //                              : "Internet Banking",
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                  if (filters.transactionType != null)
                  //                    FilteredChip(
                  //                      onTap: () {
                  //                        setState(() {
                  //                          filters.transactionType = null;
                  //                          selectedTransType = null;
                  //                          selectedTransTypeTemporory = null;
                  //                          itemsList.clear();
                  //                        });
                  //                        if (filters.selectedAccount == null &&
                  //                            filters.fromDate == null &&
                  //                            filters.toDate == null &&
                  //                            filters.fromAmount == null &&
                  //                            filters.toAmount == null &&
                  //                            filters.transactionType == null &&
                  //                            filters.channel == null) {
                  //                          filters.isFiltered = null;
                  //                          pageNumberTran = 0;
                  //                          _loadInitialData();
                  //                        } else {
                  //                          _filterDaata();
                  //                        }
                  //                      },
                  //                      children: [
                  //                        Text(
                  //                          filters.transactionType!.description!,
                  //                          style: size14weight400.copyWith(
                  //                              color: colors(context).greyColor),
                  //                        ),
                  //                      ],
                  //                    ),
                  //                ],
                  //              ),
                  //            ],
                  //          ),
                  //        ),
                  //      ),
                  //    ],
                  //  ):SizedBox.shrink(),
                   
                    
                      Column(
                        children: [
                           filters.isFiltered==true ?Column(
                     children: [
                       Align(
                             alignment: Alignment.topLeft,
                         child: Padding(
                           padding:  EdgeInsets.only(top: filters.isFiltered ==true? 12:0).h,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Wrap(
                                 children: [
                                   if (filters.selectedAccount != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.selectedAccount = null;
                                           selectedAccount = null;
                                           selectedTempororyAccount = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           filters.selectedAccount.toString(),
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromDate == null && filters.toDate != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.toDate = null;
                                           toDateV = null;
                                           toDate = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${AppLocalizations.of(context).translate("to_date")} - ${filters.toDate}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromDate != null && filters.toDate == null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.fromDate = null;
                                           fromDate = null;
                                           fromDateV = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${AppLocalizations.of(context).translate("from_date")} - ${filters.fromDate}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromDate != null && filters.toDate != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.fromDate = null;
                                           fromDate = null;
                                           fromDateV = null;
                                           filters.toDate = null;
                                           toDateV = null;
                                           toDate = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${DateFormat('dd-MMM-yyyy').format(DateTime.parse(filters.fromDate ?? DateTime.now().toString()))} to ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(filters.toDate ?? DateTime.now().toString()))}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromAmount == null &&
                                       filters.toAmount != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.toAmount = null;
                                           toAmount = 0;
                                           _toAccountController= CurrencyTextEditingController();
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${AppLocalizations.of(context).translate("to_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${filters.toAmount.toString().withThousandSeparator()}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromAmount != null &&
                                       filters.toAmount == null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.fromAmount = null;
                                           fromAmount = 0;
                                           _fromAccountController= CurrencyTextEditingController();
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${AppLocalizations.of(context).translate("from_amount")} - ${AppLocalizations.of(context).translate("lkr")} ${filters.fromAmount.toString().withThousandSeparator()}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.fromAmount != null &&
                                       filters.toAmount != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.fromAmount = null;
                                           fromAmount = 0;
                                           _fromAccountController= CurrencyTextEditingController();
                                           filters.toAmount = null;
                                           toAmount = 0;
                                           _toAccountController= CurrencyTextEditingController();
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           "${AppLocalizations.of(context).translate("lkr")} ${filters.fromAmount.toString().withThousandSeparator()} - ${filters.toAmount.toString().withThousandSeparator()}",
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.channel != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.channel = null;
                                           channel = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           filters.channel == "MB"
                                               ? AppLocalizations.of(context).translate("mobile_banking")
                                               : AppLocalizations.of(context).translate("internet_banking"),
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                   if (filters.transactionType != null)
                                     FilteredChip(
                                       onTap: () {
                                         setState(() {
                                           filters.transactionType = null;
                                           selectedTransType = null;
                                           selectedTransTypeTemporory = null;
                                           itemsList.clear();
                                         });
                                         if (filters.selectedAccount == null &&
                                             filters.fromDate == null &&
                                             filters.toDate == null &&
                                             filters.fromAmount == null &&
                                             filters.toAmount == null &&
                                             filters.transactionType == null &&
                                             filters.channel == null) {
                                           filters.isFiltered = null;
                                           pageNumberTran = 0;
                                           _loadInitialData();
                                         } else {
                                           _filterDaata();
                                         }
                                       },
                                       children: [
                                         Text(
                                           filters.transactionType!.description!,
                                           style: size14weight400.copyWith(
                                               color: colors(context).greyColor),
                                         ),
                                       ],
                                     ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ):SizedBox.shrink(),
              filters.isFiltered == true
                ? 24.verticalSpace
                : 0.verticalSpace,
                  itemsList.isNotEmpty? Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollControllerTran,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top:filters.isFiltered==true? 0:24,bottom: filters.isFiltered==true?0:20).h,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 16).w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: filters.isFiltered == true,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 16).h,
                                                child: Text("$countL ${AppLocalizations.of(context).translate("results")}",
                                                    style: size16weight700.copyWith(
                                                        color: colors(context)
                                                            .blackColor)),
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: itemsList.length,
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes
                                                            .kTransactionHistoryStatusView,
                                                        arguments: TranArgs(
                                                            tranItem: itemsList[index],
                                                            txnType: itemsList[index]
                                                                .txnType!));
                                                  },
                                                  child: TransactionHistoryComponent(
                                                    isLastItem:
                                                        (itemsList.length - 1) == index,
                                                    txnType: itemsList[index].txnType,
                                                    title:
                                                        itemsList[index].txnType ?? "",
                                                    data: itemsList[index]
                                                        .amount
                                                        .toString(),
                                                    subData:
                                                        itemsList[index].modifiedDate!,
                                                    isCR: itemsList[index].crDr!,
                                                    logo: itemsList[index]
                                                        .billProviderLogo,
                                                    txnDescription:
                                                        itemsList[index].txnDescription,
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Visibility(
                        visible: filters.isFiltered == true && itemsList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16,bottom: 16).h,
                          child: Container(
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
                                          _showBottomSheet(context);
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
                                ),
                               ),
                              ],
                            ),
                          ):SizedBox.shrink(),
                        ],
                      )
                  ],
                )
            ),
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

  _downloadEReceipt(bool shouldStore) {
    _bloc.add(
      TransactionFilterPdfDownloadEvent(
        fromDate: filters.fromDate,
        toDate: filters.toDate,
        fromAmount: filters.fromAmount,
        toAmount: filters.toAmount,
        tranType: filters.transactionType?.description == "Fund Transfer"
            ? "FT"
            : filters.transactionType?.description == "Bill Payment"
                ? "BILLPAY"
                : null,
        accountNo: filters.selectedAccount,
        channel: filters.channel,
        messageType: "txnDetailsReq",
        shouldOpen: shouldStore,
      ),
    );

    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  _downloadExcelReceipt(bool shouldStore) {
    _bloc.add(
      TransactionFilterExcelDownloadEvent(
        fromDate: filters.fromDate,
        toDate: filters.toDate,
        fromAmount: filters.fromAmount,
        toAmount: filters.toAmount,
        tranType: filters.transactionType?.description == "Fund Transfer"
            ? "FT"
            : filters.transactionType?.description == "Bill Payment"
                ? "BILLPAY"
                : null,
        accountNo: filters.selectedAccount,
        channel: filters.channel,
        messageType: "txnDetailsReq",
        shouldOpen: shouldStore,
      ),
    );

    AppPermissionManager.requestExternalStoragePermission(context, () {});
  }

  // _downloadEReceipt(bool shouldStore) {
  //   AppPermissionManager.requestExternalStoragePermission(context, () {
  //     _bloc.add(
  //       TransactionFilterPdfDownloadEvent(
  //         fromDate: filters.fromDate ,
  //         toDate: filters.toDate,
  //         fromAmount: filters.fromAmount,
  //         toAmount: filters.toAmount,
  //         tranType: filters.transactionType == "Fund Transfer"
  //             ? "FT"
  //             : filters.transactionType == "Bill Payment"
  //             ? "BILLPAY"
  //             : null,
  //         accountNo: filters.selectedAccount,
  //         channel: filters.channel,
  //         messageType: "txnDetailsReq",
  //         shouldOpen: shouldStore,
  //       ),
  //     );
  //   });
  // }
  //
  void _filterDaata() {
    _bloc.add(TransactionFilterEvent(
        account: filters.selectedAccount,
        fromDate: filters.fromDate,
        toDate: filters.toDate,
        fromAmount: filters.fromAmount,
        toAmount: filters.toAmount,
        tranType: filters.transactionType?.key ?? null,
        page: 0,
        channel: filters.channel,
        size: 20));
  }

  bool _isDateRangeValid() {
    if (fromDateV != null && toDateV != null) {
      return !toDateV!.isBefore(
          fromDateV!); // Return true if toDateV is not before fromDateV
    }
    return true; // Return true if either fromDateV or toDateV is null.
  }

  bool _isAmountRangeValid() {
    if (fromAmount == 0 || toAmount == 0) {
      return true;
    } else if (fromAmount! >= toAmount!) {
      return false;
    }
    return true; // Return true if either fromDateV or toDateV is null.
  }

  bool _isAFieldFilled() {
    if (selectedAccount != null ||
        fromDate != null ||
        toDate != null ||
        fromAmount != 0 ||
        toAmount != 0 ||
        selectedTransType != null ||
        channel != null) {
      return true;
    }
    return false; // Return true if either fromDateV or toDateV is null.
  }

  bool _isButtonEnable() {
    if (_isAFieldFilled()  && _isDateRangeValid()) {
      return true;
    }
    return false;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    final formattedValue =
        NumberFormat('#,###.##').format(double.tryParse(numericValue) ?? 0);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
