import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/request_money/data/phone_contact.dart';
import 'package:union_bank_mobile/features/presentation/views/request_money/widgets/ub_req_money_history_compnent.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/model/bank_icons.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/text_editing_controllers.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../bloc/request_money/request_money_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/carousel_widget/app_carousel_widget.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/sliding_segmented_bar.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';
import '../fund_transfer/data/fund_transfer_args.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';
import 'data/request_money_history_values.dart';
import 'data/request_money_status.dart';

class RequestMoneyView extends BaseView {
  @override
  _RequestMoneyViewState createState() => _RequestMoneyViewState();
}

class _RequestMoneyViewState extends BaseViewState<RequestMoneyView> {
  var bloc = injection<AccountBloc>();
  var reqMoneybloc = injection<RequestMoneyBloc>();
  String? remarkText;
  String? mobileNumber;
  String? name;
  String? amount;
  bool toggleValue = false;
  bool isUserEdited = false;
  int current = 0;
  TextEditingController _remarksController = TextEditingController();
  final fundTransferEntity = FundTransferEntity();
  List<AccountEntity> accountList = [];
  List<AccountEntity> accountListPortfolio = [];
  List<AccountEntity> accountListInstrument = [];
  List<RequestMoneyHistoryValues> reqMoneyHistoryList = [];
  CarouselSliderController carouselController1 = CarouselSliderController();
  int currentIndex = 0;
  List<bool> carauselValue = List.generate(30, (index) => false);
  TextEditingController _phoneNumberController = TextEditingController();
  CurrencyTextEditingController amountController = CurrencyTextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _toolTipController = SuperTooltipController();
  final localDataSource = injection<LocalDataSource>();

  @override
  void initState() {
    super.initState();
    setState(() {
      bloc.add(GetPortfolioAccDetailsEvent());
      // bloc.add(GetTranLimitForFTEvent());
      reqMoneybloc.add(RequestMoneyHistoryRequestEvent(
        messageType: "requestMoney",
      ));
      carauselValue[0] = true;
    });
    // _scrollController.addListener(_onScrollPadding);
  }

  onBackAction() {
    isUserEdited == true
        ? showAppDialog(
            title: AppLocalizations.of(context).translate("cancel_req_money"),
            alertType: AlertType.MONEY1,
            message: AppLocalizations.of(context)
                .translate("do_want_cancel_req_money"),
            positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
            negativeButtonText: AppLocalizations.of(context).translate("no"),
            onPositiveCallback: () {
              Navigator.of(context).pop();
            })
        : Navigator.pop(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        onBackAction();
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: () {
            onBackAction();
          },
          title: AppLocalizations.of(context).translate("request_money"),
        ),
        body: BlocProvider<AccountBloc>(
          create: (_) => bloc,
          child: BlocProvider<RequestMoneyBloc>(
            create: (_) => reqMoneybloc,
            child: BlocListener<AccountBloc, BaseState<AccountState>>(
              listener: (_, state) {
                if (state is PortfolioAccountDetailsSuccessState) {
                  if (state.accDetails?.accountDetailsResponseDtos?.length !=
                          0 &&
                      state.accDetails?.accountDetailsResponseDtos != null) {
                    setState(() {
                      accountListPortfolio.clear();
                      accountListPortfolio
                          .addAll(state.accDetails!.accountDetailsResponseDtos!
                              .map((e) => AccountEntity(
                                    status: e.status,
                                    instrumentId: e.instrumentId,
                                    bankName: e.bankName,
                                    bankCode: e.bankCode ??
                                        AppConstants.ubBankCode.toString(),
                                    icon: bankIcons
                                        .firstWhere(
                                          (element) =>
                                              element.bankCode ==
                                              (e.bankCode ??
                                                  AppConstants.ubBankCode
                                                      .toString()),
                                          orElse: () => BankIcon(),
                                        )
                                        .icon,
                                    accountNumber: e.accountNumber,
                                    nickName: e.nickName ?? "",
                                    availableBalance: double.parse(
                                        e.availableBalance ?? "0.00"),
                                    accountType: e.accountType,
                                    isPrimary: true,
                                    cfprcd: e.cfprcd,
                                    currency: e.cfcurr.toString().trim(),
                                  ))
                              .toList());
                      accountListPortfolio.removeWhere((e)=>e.currency?.trim()!="LKR");
                      accountListPortfolio = accountListPortfolio
                          .where((element) =>
                              (element.accountType?.toUpperCase() == "S" &&
                                  element.status?.toUpperCase() == "ACTIVE") ||
                              (element.accountType?.toUpperCase() == "D" &&
                                  element.status?.toUpperCase() == "ACTIVE"))
                          .toList();

                      accountList.addAll(accountListPortfolio);
                      //  accountList = accountList.where((element) =>
                      //         (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                      accountList = accountList.unique((x) => x.accountNumber);
                    });
                  }
                  bloc.add(GetUserInstrumentEvent(
                    requestType: RequestTypes.ACTIVE.name,
                  ));
                }
                if (state is GetUserInstrumentSuccessState) {
                  if (state.getUserInstList?.length != 0 &&
                      state.getUserInstList != null) {
                    setState(() {
                      accountListInstrument.clear();
                      accountListInstrument.addAll(state.getUserInstList!
                          .map((e) => AccountEntity(
                                instrumentId: e.id,
                                bankName: e.bankName,
                                bankCode: e.bankCode,
                                accountNumber: e.accountNo,
                                nickName: e.nickName ?? "",
                                icon: bankIcons
                                    .firstWhere(
                                      (element) =>
                                          element.bankCode ==
                                          (e.bankCode ??
                                              AppConstants.ubBankCode
                                                  .toString()),
                                      orElse: () => BankIcon(),
                                    )
                                    .icon,
                                availableBalance:
                                    double.parse(e.accountBalance ?? "0.00"),
                                accountType: e.accType,
                                isPrimary: e.isPrimary,
                                currency: e.currency.toString().trim(),
                              ))
                          .toList());
                      accountListInstrument.removeWhere((e)=>e.currency?.trim()!="LKR");
                      accountListInstrument = accountListInstrument.where((element) =>
                              (element.bankCode?.toUpperCase() != "7302"))
                          .toList();
                      accountListInstrument = accountListInstrument
                          .where((element) =>
                              (element.accountType == "S") ||
                              (element.accountType == "D"))
                          .toList();
                      accountList.addAll(accountListInstrument);
                      accountList = accountList.unique((x) => x.accountNumber);
                      if (currentIndex == 0) {
                        fundTransferEntity.availableBalance =
                            accountList[0].availableBalance;
                        fundTransferEntity.payFromNum =
                            accountList[0].accountNumber;
                        fundTransferEntity.payFromName =
                            accountList[0].nickName;
                        fundTransferEntity.bankCodePayFrom =
                            int.parse(accountList[0].bankCode!);
                        fundTransferEntity.instrumentId =
                            accountList[0].instrumentId;
                      }
                    });
                  }
                  // accountListForPayTo.removeAt(currentIndex);
                }
                if (state is AccountDetailFailState) {
                  bloc.add(GetUserInstrumentEvent(
                    requestType: RequestTypes.ACTIVE.name,
                  ));
                }
                if (state is GetUserInstrumentFailedState) {
                  showAppDialog(
                      title: AppLocalizations.of(context).translate("there_was_some_error"),
                      alertType: AlertType.FAIL,
                      message: state.message,
                      positiveButtonText:
                          AppLocalizations.of(context).translate("Try_Again"),
                      onPositiveCallback: () {
                        accountList.clear();
                        bloc.add(GetPortfolioAccDetailsEvent());
                      },
                      negativeButtonText: AppLocalizations.of(context).translate("go_back"),
                      onNegativeCallback: () {
                        Navigator.of(context).pop();
                      });
                }
              },
              child:
                  BlocListener<RequestMoneyBloc, BaseState<RequestMoneyState>>(
                bloc: reqMoneybloc,
                listener: (context, state2) {
                  if (state2 is RequestMoneyHistorySuccessState) {
                    reqMoneyHistoryList.clear();
                    reqMoneyHistoryList.addAll(state2.list!
                        .map((e) => RequestMoneyHistoryValues(
                            status: e.status,
                            id: e.id,
                            cdbUserPayor: e.cdbUserPayor,
                            toAccountName: e.toAccountName,
                            toAccount: e.toAccount,
                            requestedAmount: e.requestedAmount,
                            remarks: e.remarks,
                            date: e.date))
                        .toList());
                    setState(() {});
                  }
                },
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: GestureDetector(
                    onTap: () {
                      if (_toolTipController.isVisible) {
                        _toolTipController.hideTooltip();
                      }
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,),
                      child: Stack(
                        children: [
                          (current == 1 && reqMoneyHistoryList.isEmpty)?   Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: colors(context).secondaryColor300,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: PhosphorIcon(
                                      PhosphorIcons.handCoins(PhosphorIconsStyle.bold),
                                      color: colors(context).whiteColor,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                Text(
                                  AppLocalizations.of(context).translate('no_request_money'),
                                  textAlign: TextAlign.center,
                                  style: size18weight700.copyWith(color: colors(context).blackColor),
                                ),
                                4.verticalSpace,
                                Text(
                                  AppLocalizations.of(context).translate('you_have_not_request_money'),
                                  textAlign: TextAlign.center,
                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                )
                              ],
                            ),
                          ):SizedBox.shrink(),
                          Column(
                            children: [
                               24.verticalSpace,
                              SizedBox(
                                height: 44,
                                child: SlidingSegmentedBar(
                                  selectedTextStyle: size14weight700.copyWith(
                                      color: colors(context).whiteColor),
                                  textStyle: size14weight700.copyWith(
                                      color: colors(context).blackColor),
                                  backgroundColor: colors(context).whiteColor,
                                  onChanged: (int value) {
                                    current = value;
                                    setState(() {});
                                      fundTransferEntity.availableBalance = accountList[0].availableBalance;
                                      fundTransferEntity.payFromNum = accountList[0].accountNumber;
                                      fundTransferEntity.payFromName = accountList[0].nickName;
                                      fundTransferEntity.bankCodePayFrom = int.parse(accountList[0].bankCode!);
                                      fundTransferEntity.instrumentId = accountList[0].instrumentId;

                                  },
                                  selectedIndex: current,
                                  children: [
                                    AppLocalizations.of(context).translate("new_request"),
                                    AppLocalizations.of(context).translate("history"),
                                  ],
                                ),
                              ),
                              24.verticalSpace,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (current == 0)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(context)
                                                              .translate("to_account"),
                                                          textAlign: TextAlign.start,
                                                          style: size14weight700.copyWith(
                                                              color:
                                                                  colors(context).blackColor)),
                                                      16.verticalSpace,
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8).r,
                                                          color: colors(context).whiteColor,
                                                        ),
                                                        child: AppCarouselWidget(
                                                          carouselController: carouselController1,
                                                            accountList: accountList,
                                                            onPageChanged: (index, reason) {
                                                              setState(() {
                                                                isUserEdited = true;
                                                                currentIndex = index;
                                                                fundTransferEntity
                                                                        .availableBalance =
                                                                    accountList[index]
                                                                        .availableBalance;
                                                                fundTransferEntity.payFromNum =
                                                                    accountList[index]
                                                                        .accountNumber;
                                                                fundTransferEntity.payFromName =
                                                                    accountList[index].nickName;
                                                                fundTransferEntity
                                                                        .instrumentId =
                                                                    accountList[index]
                                                                        .instrumentId;
                                                                fundTransferEntity.bankName =
                                                                    accountList[index].bankName;
                                                              });
                                                              if (currentIndex == index) {
                                                                carauselValue.fillRange(0, carauselValue.length, false); // Set all items to false.
                                                                if (index >= 0 && index < carauselValue.length) {
                                                                  carauselValue[index] = true; // Set the specified index to true.
                                                                }
                                                              }
                                                            }),
                                                      ),
                                                      16.verticalSpace,
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8).r,
                                                          color: colors(context).whiteColor,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16.0).w,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              AppTextField(
                                                                // isTitleDarker: true,
                                                                superToolTipController: _toolTipController,
                                                                hint: AppLocalizations.of(context).translate("enter_Mobile_number"),
                                                                title: AppLocalizations.of(context).translate("Mobile_Number"),
                                                                textCapitalization: TextCapitalization.none,
                                                                controller: _phoneNumberController,
                                                                inputFormatter: [FilteringTextInputFormatter.digitsOnly,],
                                                                inputType: TextInputType.number,
                                                                isShowingInTheField: true,
                                                                successfullyValidated: (_phoneNumberController.text.isEmpty) ? false : true,
                                                                infoIconText: [AppLocalizations.of(context).translate("request_des_1")],
                                                                toolTipTitle: "",
                                                                validator: (a) {
                                                                  if (_phoneNumberController.text.isEmpty) {
                                                                    return AppLocalizations.of(context).translate("mandatory_field_msg");
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                maxLength: 10,
                                                                onTextChanged: (value) {
                                                                  setState(() {
                                                                    fundTransferEntity.beneficiaryMobile = value;
                                                                    isUserEdited = true;
                                                                    fundTransferEntity.isFromContacts = false;
                                                                    setState(() {});
                                                                    // value = remarkText!;
                                                                  });
                                                                },
                                                              ),
                                                              12.verticalSpace,
                                                              InkWell(
                                                                onTap: () {
                                                                  AppPermissionManager.requestContactPermission(context, () async {
                                                                    final result = await Navigator.pushNamed(context,
                                                                      Routes.kRequestMoneyContactListView,);
                                                                    if (result != null) {
                                                                      final phone = result as PhoneContact;
                                                                      final phoneNumber = phone.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
                                                                      _phoneNumberController.text = phoneNumber;
                                                                      fundTransferEntity.beneficiaryMobile = phoneNumber;
                                                                      fundTransferEntity.name = phone.displayName;
                                                                      fundTransferEntity.isFromContacts = true;
                                                                    }
                                                                  });
                                                                },
                                                                child: Text(AppLocalizations.of(context).translate("add_from_contacts"),
                                                                  style: size14weight700.copyWith(
                                                                      color: colors(context).primaryColor),
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                              ),
                                                              24.verticalSpace,
                                                              AppTextField(
                                                               // isValueInFeild: true,
                                                                isInfoIconVisible: false,
                                                                isCurrency: true,
                                                                hint: AppLocalizations.of(context).translate("amount"),
                                                                title: AppLocalizations.of(context).translate("amount"),
                                                                controller: amountController,
                                                                validator: (a) {
                                                                  if (amountController.text.isEmpty || amountController.text == "0" || amountController.text == "0.00") {
                                                                    return AppLocalizations.of(context).translate("mandatory_field_msg");
                                                                  }
                                                                  // else if(int.parse(maxUserAmountPerTran ?? "0") < double.parse(amountController.text.replaceAll(',', ''))){
                                                                  //   return "${AppLocalizations.of(context).translate("you_can_only_request")} ${AppLocalizations.of(context).translate("lkr")} ${maxUserAmountPerTran?.withThousandSeparator()}";
                                                                  // }
                                                                  else {
                                                                    return null;
                                                                  }
                                                                },
                                                                inputType: const TextInputType.numberWithOptions(decimal: true),
                                                                textCapitalization: TextCapitalization.none,
                                                                onTextChanged: (value) {
                                                                  fundTransferEntity.amount = double.tryParse(value.replaceAll(",", ""));
                                                                  isUserEdited = true;
                                                                  setState(() {});
                                                                },
                                                              ),
                                                              24.verticalSpace,
                                                              AppTextField(
                                                                // isTitleDarker: true,
                                                                maxLength: 30,
                                                                controller: _remarksController,
                                                                isInfoIconVisible: false,
                                                                hint: AppLocalizations.of(context).translate("enter_remarks"),
                                                                title: AppLocalizations.of(context).translate("remarks_op"),
                                                                textCapitalization: TextCapitalization.sentences,
                                                                onTextChanged: (value) {
                                                                  fundTransferEntity.remark = value;
                                                                  isUserEdited = true;
                                                                  setState(() {});
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  20.verticalSpace,
                                                  AppButton(
                                                      buttonText: AppLocalizations.of(context)
                                                          .translate("request"),
                                                      onTapButton: () {
                                                        if (_formKey.currentState?.validate() == false) {
                                                          return;
                                                        }
                                                        if(_phoneNumberController.text == AppConstants.profileData.mobileNo){
                                                          showAppDialog(
                                                            title: AppLocalizations.of(context).translate("invalid_mobile_number"),
                                                            alertType: AlertType.MOBILE,
                                                            message:AppLocalizations.of(context).translate("invalid_mobile_number_des"),
                                                            positiveButtonText: AppLocalizations.of(context).translate("ok"),
                                                            onPositiveCallback: () {},
                                                          );
                                                        } else {
                                                          Navigator.pushNamed(
                                                            context,
                                                            Routes.kRequestMoneySummaryView,
                                                            arguments: FundTransferArgs(fundTransferEntity),
                                                          );
                                                        }
                                                        // Navigator.pushNamed(
                                                        //     context, Routes.kRequestMoneySummaryView);
                                                      }),
                                                  16.verticalSpace,
                                                  AppButton(
                                                    buttonType: ButtonType.OUTLINEENABLED,
                                                    buttonColor: Colors.transparent,
                                                    buttonText: AppLocalizations.of(context)
                                                        .translate("cancel"),
                                                    onTapButton: () {
                                                      showAppDialog(
                                                          title: AppLocalizations.of(context)
                                                              .translate("cancel_the_request"),
                                                          alertType: AlertType.MONEY1,
                                                          message: AppLocalizations.of(context)
                                                              .translate(
                                                                  "cancel_the_request_des"),
                                                          positiveButtonText:
                                                              AppLocalizations.of(context)
                                                                  .translate("yes,_cancel"),
                                                          negativeButtonText:
                                                              AppLocalizations.of(context)
                                                                  .translate("no"),
                                                          onPositiveCallback: () {
                                                            Navigator.pop(context);
                                                            Navigator.pop(context);
                                                          },
                                                          onNegativeCallback: () {});
                                                    },
                                                  ),
                                                ],
                                              ),
                                              AppSizer.verticalSpacing(20+AppSizer.getHomeIndicatorStatus(context))
                                            ],
                                          ),
                                        ),
                                      if (current == 1)
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:  EdgeInsets.only(bottom: 20+AppSizer.getHomeIndicatorStatus(context)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8).r,
                                                      color: colors(context).whiteColor,
                                                    ),
                                                    child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      itemCount: reqMoneyHistoryList.length,
                                                      itemBuilder: (context, int index) {
                                                        return Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                final result = showModalBottomSheet<
                                                                        bool>(
                                                                    isScrollControlled:
                                                                        true,
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
                                                                            title: AppLocalizations.of(context)
                                                                                .translate("request_money_summary"),
                                                                            buttons: [],
                                                                            children: [
                                                                              FTSummeryDataComponent(
                                                                                title: AppLocalizations.of(context)
                                                                                    .translate("to_account"),
                                                                                data: reqMoneyHistoryList[index].toAccount ?? "-",
                                                                              ),
                                                                              FTSummeryDataComponent(
                                                                                title: AppLocalizations.of(context)
                                                                                    .translate("request_form"),
                                                                                data: formatMobileNumber(reqMoneyHistoryList[index].cdbUserPayor ?? "-"),
                                                                              ),
                                                                              FTSummeryDataComponent(
                                                                                title: AppLocalizations.of(context)
                                                                                    .translate("amount"),
                                                                                isCurrency: true,
                                                                                amount: reqMoneyHistoryList[index].requestedAmount,
                                                                              ),
                                                                              FTSummeryDataComponent(
                                                                                title: AppLocalizations.of(context).translate("remarks"),
                                                                                data: reqMoneyHistoryList[index].remarks == null || reqMoneyHistoryList[index].remarks == ""? "-" :
                                                                                reqMoneyHistoryList[index].remarks ?? "-",
                                                                              ),
                                                                              FTSummeryDataComponent(
                                                                                title: AppLocalizations.of(context)
                                                                                    .translate("date_&_time"),
                                                                                data:"${DateFormat('dd-MMMM-yyyy HH:mm').format(DateTime.parse(reqMoneyHistoryList[index].date?.split("+")[0] ?? DateTime.now().toIso8601String()))}"
                                                                                    // "${DateFormat('dd-MMMM-yyyy HH:mm').format(reqMoneyHistoryList[index].date ?? DateTime.now())}"
                                                                                ,
                                                                                // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(transactionNotificationsList[index].date!)}",
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }));
                                                              },
                                                              child:
                                                                  RequestMoneyHistoryComponent(
                                                                amount: reqMoneyHistoryList[
                                                                        index]
                                                                    .requestedAmount
                                                                    .toString().withThousandSeparator(),
                                                                paytoNumber:
                                                                formatMobileNumber(reqMoneyHistoryList[index].cdbUserPayor ?? "-"),
                                                                date:
                                                                "${DateFormat('dd-MMM-yyyy HH:mm').format(DateTime.parse(reqMoneyHistoryList[index].date?.split("+")[0] ?? DateTime.now().toIso8601String()))}",
                                                                    // "${DateFormat('dd-MMM-yyyy HH:mm').format(reqMoneyHistoryList[index].date ?? DateTime.now())}",
                                                                status: reqMoneyHistoryList[
                                                                        index]
                                                                    .status,
                                                              ),
                                                            ),
                                                            if (reqMoneyHistoryList.length -
                                                                    1 !=
                                                                index)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                            left: 16,
                                                                            right: 16)
                                                                        .w,
                                                                child: Divider(
                                                                  thickness: 1,
                                                                  height: 0,
                                                                ),
                                                              )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  RequestMoneyStatus getStatus(String status) {
    switch (status) {
      case "SUCCESS":
        {
          return RequestMoneyStatus(status: AppLocalizations.of(context).translate("success"), color: colors(context).primaryColor300);
        }

      case "ACTIVE":
        {
          return RequestMoneyStatus(status: AppLocalizations.of(context).translate("active"), color: colors(context).secondaryColor200);
        }

      case "EXPIRED":
        {
          return RequestMoneyStatus(status: AppLocalizations.of(context).translate("expired"), color: colors(context).greyColor);
        }

      case "REJECTED":
        {
          return RequestMoneyStatus(status: AppLocalizations.of(context).translate("rejected"), color: colors(context).negativeColor);
        }

      default:
        {
          return RequestMoneyStatus(status: AppLocalizations.of(context).translate("accepted"), color: colors(context).positiveColor);
        }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanText = newValue.text.replaceAll(',', '');
    final regex = RegExp(
        r'^\d*\.?\d{0,2}$');
    if (!regex.hasMatch(cleanText)) {
      return oldValue;
    }
    final numericRegex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final match = numericRegex.allMatches(cleanText);
    String formattedText = cleanText;
    if (match.isNotEmpty) {
      formattedText = cleanText.replaceAllMapped(
        numericRegex,
        (Match match) => '${match[1]},',
      );
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
