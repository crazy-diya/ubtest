import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/data/saved_payee_list.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/ft_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';
import '../../../../../utils/app_extensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/app_validator.dart';
import '../../../../utils/biometric_helper.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/text_editing_controllers.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../data/models/responses/settings_tran_limit_response.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';

import '../../widgets/app_switch/app_switch.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/carousel_widget/app_carousel_widget.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/sliding_segmented_bar.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../notifications/notifications_view.dart';
import '../payee_manegement/payee_management_save_payee_view.dart';
import 'data/fund_transfer_args.dart';

class ScheduleType {
   String description;
   int scheduleIndex;

  ScheduleType({required this.description, required this.scheduleIndex});
}

class FundTransferNewView extends BaseView {
  final RequestMoneyValues? requestMoneyValues;

  FundTransferNewView({this.requestMoneyValues});

  @override
  _FundTransferNewViewState createState() => _FundTransferNewViewState();
}

class _FundTransferNewViewState extends BaseViewState<FundTransferNewView> {
  // var bloc = injection<SplashBloc>();
  final bloc = injection<AccountBloc>();
  final localDataSource = injection<LocalDataSource>();
  bool notifyBeneficiary = false;
  bool isBenifitiaryEdited = false;
  final fundTransferEntity = FundTransferEntity();
  final AppValidator appValidator = AppValidator();
  List<AccountEntity> accountList = [];
  List<AccountEntity> allaccountList = [];
  List<AccountEntity> accountListPortfolio = [];
  List<AccountEntity> accountListInstrument = [];
  List<AccountEntity> accountListForPayTo = [];
  List<bool> carauselValue = List.generate(30, (index) => false);
  List<bool> carauselValueForPayTo = List.generate(30, (index) => false);
  CarouselSliderController carouselController1 = CarouselSliderController();
  CarouselSliderController carouselController2 = CarouselSliderController();
  CurrencyTextEditingController ownAmountController = CurrencyTextEditingController();
  CurrencyTextEditingController savedAmountController = CurrencyTextEditingController();
  CurrencyTextEditingController newAmountController = CurrencyTextEditingController();

///////my values
  final FocusNode _focusNodeAmount = FocusNode();
  final FocusNode _focusNoderemarks = FocusNode();
  final FocusNode _focusNodeBenificiary = FocusNode();
  final FocusNode _focusNodeNewToAcct = FocusNode();
  final FocusNode _focusNodeNewName = FocusNode();
  final TextEditingController _controllerNewToAcct = TextEditingController();
  final TextEditingController _controllerNewToAcctName = TextEditingController();
  CurrencyTextEditingController _amountController = CurrencyTextEditingController();
  List<CommonDropDownResponse>? categoryList;
  List<CommonDropDownResponse>? branchList;
  List<CommonDropDownResponse>? searchBranchList;
  String? tranCatory;
  String? tranCatoryTemp;
  String? schedule = "now";
  int? scheduleIndex = 0;
  String? scheduleTemp = "now";
  int? scheduleIndexTemp = 0;
  String? scheduleFrequency = "daily";
  String? scheduleFrequencyTemp ="daily";
  String? bankName;
  String? bankCode;
  String? bankNameTemp;
  String? bankCodeTemp;
  String? branchName;
  String? branchCode;
  String? branchNameTemp;
  String? branchCodeTemp;

  List<ScheduleType> scheduleType = [
    ScheduleType(
        description: "now",
        scheduleIndex: 0
    ),
    ScheduleType(
        description: "later",
        scheduleIndex: 1
    ),
    ScheduleType(
        description: "recurring",
        scheduleIndex: 2
    ),
  ];

  List<SavedPayeeEntity> savedPayees = [];
  List<CommonDropDownResponse> searchBankList = [];

///////////////////////////////////////


  final FocusNode _focusNodeOwnAmount = FocusNode();
  final FocusNode _focusNodeSavedAmount = FocusNode();
  final FocusNode _focusNodeSavedNotifyBen = FocusNode();
  final FocusNode _focusNodeNewAmount = FocusNode();
  final FocusNode _focusNodeNewNotifyBen = FocusNode();
  CommonDropDownResponse? selectedBrnch;

  String? cif = "123587";
  bool? selectPayFrom = false;
  bool accountAvailability = true;
  bool savedNameselectedPayee = false;

  bool isOwnValidated = false;
  bool isSavedValidated = false;
  bool isNewValidated = false;
  bool isNewLaterValidated = false;
  bool isNewReccurValidated = false;
  bool isSavedLaterValidated = false;
  bool isMobileValidated = false;
  bool isOwnLaterValidated = false;
  bool isOwnRecuringValidated = false;
  bool isSavedRecurValidated = false;
  bool toggleValue = true;
  bool isAmountAvailable = true;
  bool isUserEdited = false;
  bool isUserSelectedBankDropdown = false;

  String? maxUserAmountPerTran;
  String? maxGlobalLimitPerTran;
  String? minUserAmoubtPerTran;
  String? twoFactorLimit;
  String? accountName;
  bool? isTwoFactorEnabled = false;

  int currentIndex = 0;
  int currentIndexSavedPayee = 0;
  int currentIndexforPayto = 0;

  LoginMethods _loginMethod = LoginMethods.NONE;

  //tab list
  List<String> tabs = [
    "own",
    "saved",
    "new",
  ];
  int current = 0;



  int currentNewPayee = 0;

  //tabs when only one acct available

  //own acct Now variables
  int? ownNowAcctAmount;
  String? ownNowRemarks;
  String? ownNowCategory;

  //own Acct Later variable
  String? ownLaterRemarks;
  String? ownLaterCategory;

  //own acct frec variable
  String? ownRecFrequency;
  String? ownRecRemarks;
  String? ownRecCategory;
  int ownRecDays = 0;

  //Saved payee variable (when select a payee from saved list)
  String? savedName;
  String? savedAcctNum;
  bool? selectedPayee = false;
  bool? isPayeeNotSelected = false;
  bool? isCategorySuccess = false;

  //Saved payee now variable
  int? savedNowAcctAmount;
  String? savedNowRemarks;
  String? savedNowCategory;
  String? savedNowBenMobile;

  //pay from details
  String? selectedFromAcctNmbr;
  String? selectedFromAcctName;

  //new payee variables
  String? newPayeeBank;
  String? newPayeeToAcct;
  String? newPayeeToName;
  String? newPayeeBranch;
  int? newPayeeAmount;
  String? newPayeeNowRemarks;
  String? newPayeeNowCategory;
  String? newPayeeNowBenMobile;

  //saved payee later variables
  String? savedLaterRemarks;
  String? savedLaterCategory;

  //me cdb eken gaththu ewa
  SavedPayeeEntity? savedPayeeDetails;

  //biometric for 2FA
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  final biometricHelper = injection<BiometricHelper>();

  final _formKey = GlobalKey<FormState>();
  String? iconForRequest;

  CarouselSliderController _savedPayeeCarouselController =CarouselSliderController() ;

  @override
  void initState() {
    super.initState();
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    searchBankList = kBankList;
    bloc.add(GetTranLimitForFTEvent());
        if(widget.requestMoneyValues!.route == Routes.kNotificationsView) {
          if(int.parse(widget.requestMoneyValues!.toBankCode!) == AppConstants.ubBankCode){
            bloc.add(GetAccountNameFTEvent(
                accountNo: widget.requestMoneyValues!.toAccount!
            ));
          }
        }
      // });
      _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>initialBiometric());
      carauselValue[0] = true;
      carauselValueForPayTo[0] = true;
      _controllerNewToAcct.text = "";
      if(widget.requestMoneyValues!.route == Routes.kNotificationsView){
        current = 2;
        fundTransferEntity.payToacctnmbr = widget.requestMoneyValues!.toAccount;
        fundTransferEntity.payToacctname = widget.requestMoneyValues!.toAccountName;
        fundTransferEntity.amount = double.parse(widget.requestMoneyValues!.requestedAmount.toString());
        fundTransferEntity.bankName = kBankList.where((element) => element.key == widget.requestMoneyValues!.toBankCode).first.description;
        _amountController.text = ((double.parse((widget.requestMoneyValues!.requestedAmount.toString())))*10).toString();
        _controllerNewToAcct.text = widget.requestMoneyValues!.toAccount!;
        fundTransferEntity.bankCode = int.parse(widget.requestMoneyValues!.toBankCode!);
        bankName = kBankList.where((element) => element.key == widget.requestMoneyValues!.toBankCode).first.description;
        bankNameTemp = kBankList.where((element) => element.key == widget.requestMoneyValues!.toBankCode).first.description;
        bankCode = widget.requestMoneyValues?.toBankCode;
        bankCodeTemp = widget.requestMoneyValues?.toBankCode;
        iconForRequest = bankIcons.firstWhere((element) => element.bankCode == (widget.requestMoneyValues!.toBankCode!),orElse: () => BankIcon(),).icon;
        // fundTransferEntity.route = widget.requestMoneyValues?.route;
        setState(() {});
      }
      schedule = scheduleType[0].description;
      scheduleTemp = scheduleType[0].description;
    scheduleIndex = scheduleType[0].scheduleIndex;
    scheduleIndexTemp = scheduleType[0].scheduleIndex;
      setState(() {});
  }

  void initialBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      if (_isBiometricAvailable) {
        if (_isAppBiometricAvailable && _isBiometricAvailable) {
          _loginMethod = await biometricHelper.getBiometricType();
        } else {
          _loginMethod = LoginMethods.NONE;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        if (isUserEdited == true) {
          showAppDialog(
              title: AppLocalizations.of(context)
                  .translate("cancel_fund_transfer"),
              alertType: AlertType.TRANSFER,
              message: AppLocalizations.of(context)
                  .translate("cancel_fund_transfer_des"),
              positiveButtonText:
                  AppLocalizations.of(context).translate("yes_cancel"),
              onPositiveCallback: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  widget.requestMoneyValues?.route == Routes.kNotificationsView
                      ? Routes.kNotificationsView
                      : Routes.kHomeBaseView,
                  arguments: RequestMoneyValues(),
                  (Route<dynamic> route) =>
                      route.settings.name == widget.requestMoneyValues?.route,
                );
              },
              negativeButtonText:
              AppLocalizations.of(context).translate("no"),
              onNegativeCallback: () {
              });
        }
        else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            widget.requestMoneyValues?.route == Routes.kNotificationsView ?
            Routes.kNotificationsView :
            Routes.kHomeBaseView,
            arguments: RequestMoneyValues(),
                (Route<dynamic> route) => route.settings.name == widget.requestMoneyValues?.route,
          );
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
          appBar: UBAppBar(
              onBackPressed: () {
                if(isUserEdited == true){
                  showAppDialog(
                      title: AppLocalizations.of(context)
                          .translate("cancel_fund_transfer"),
                      alertType: AlertType.TRANSFER,
                      message: AppLocalizations.of(context)
                          .translate("cancel_fund_transfer_des"),
                      positiveButtonText:
                          AppLocalizations.of(context).translate("yes_cancel"),
                      onPositiveCallback: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          widget.requestMoneyValues?.route ==
                                  Routes.kNotificationsView
                              ? Routes.kNotificationsView
                              : Routes.kHomeBaseView,
                          arguments: RequestMoneyValues(),
                              (Route<dynamic> route) => route.settings.name == widget.requestMoneyValues?.route,
                        );
                        // Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                       // Navigator.pop(context);
                      },
                      negativeButtonText:
                          AppLocalizations.of(context).translate("no"),
                      onNegativeCallback: () {});
                } else {
                    // Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    widget.requestMoneyValues?.route ==
                            Routes.kNotificationsView
                        ? Routes.kNotificationsView
                        : Routes.kHomeBaseView,
                    arguments: RequestMoneyValues(),
                    (Route<dynamic> route) =>
                        route.settings.name == widget.requestMoneyValues?.route,
                  );
                }
              },
              title:
              widget.requestMoneyValues!.route == Routes.kNotificationsView ?
              AppLocalizations.of(context)
                  .translate("fund_transfer") :
                  current == 0
                  ? AppLocalizations.of(context)
                      .translate("own_union_bank_account")
                  : current == 1
                      ? AppLocalizations.of(context)
                          .translate("saved_payee_transfer")
                      : AppLocalizations.of(context)
                          .translate("new_payee_transfer")),
          body: BlocProvider<AccountBloc>(
            create: (_) => bloc,
            child: BlocListener<AccountBloc, BaseState<AccountState>>(
                listener: (_, state) {
                  if (state is PortfolioAccountDetailsSuccessState) {
                    if (state.accDetails?.accountDetailsResponseDtos?.length !=
                            0 &&
                        state.accDetails?.accountDetailsResponseDtos != null) {
                      accountListPortfolio.clear();
                      accountListPortfolio
                          .addAll(state.accDetails!.accountDetailsResponseDtos!
                              .map((e) => AccountEntity(
                                    status: e.status,
                                    instrumentId: e.instrumentId,
                                    bankName: e.bankName,
                                    bankCode: e.bankCode ??
                                        AppConstants.ubBankCode.toString(),
                                    accountNumber: e.accountNumber,
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
                      accountListForPayTo.addAll(accountListPortfolio);
                      accountListForPayTo =
                          accountListForPayTo.unique((x) => x.accountNumber);
                      accountList = accountList.unique((x) => x.accountNumber);
                      allaccountList = accountList;
                      accountList = accountList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                      if (widget.requestMoneyValues!.route ==
                          Routes.kNotificationsView) {
                        current = 2;
                      } else {
                        if(accountListForPayTo.any((element) =>
                              (element.cfprcd?.toUpperCase().trim() == "SSHADOW"))){
                          current = 0;

                       }
                        else if (accountList.length == 1) {
                          current = 1;
                          if(savedPayees.isNotEmpty){
                            fundTransferEntity.payToacctname = savedPayees[0].nickName;
                            fundTransferEntity.payToacctnmbr = savedPayees[0].accountNumber;
                            fundTransferEntity.name = savedPayees[0].accountHolderName;
                            fundTransferEntity.bankName = savedPayees[0].bankName;
                            fundTransferEntity.bankCode = int.parse(savedPayees[0].bankCode ?? "0");
                            } 
                        } else {
                          current = 0;
                        }
                      }
                    }
                    bloc.add(GetUserInstrumentEvent(
                      requestType: RequestTypes.ACTIVE.name,
                    ));
                    setState(() {});
                  }
                  if (state is AccountDetailFailState) {
                    bloc.add(GetUserInstrumentEvent(
                      requestType: RequestTypes.ACTIVE.name,
                    ));
                  }
                  if (state is GetUserInstrumentSuccessState) {
                    if(state.getUserInstList?.length!=0 && state.getUserInstList!=null){
                       setState(() {
                      accountListInstrument.clear();
                      accountListInstrument.addAll(state.getUserInstList!
                          .map((e) => AccountEntity(
                                instrumentId: e.id,
                                bankName: e.bankName,
                                bankCode: e.bankCode,
                                accountNumber: e.accountNo,
                                nickName: e.nickName ?? "",
                                icon: bankIcons.firstWhere((element) => element.bankCode == (e.bankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
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
                              (element.accountType?.toUpperCase() == "S") ||
                              (element.accountType?.toUpperCase() == "D"))
                          .toList();

                        accountList.addAll(accountListInstrument);
                        accountListForPayTo.addAll(accountListInstrument);
                        accountListForPayTo =
                            accountListForPayTo.unique((x) => x.accountNumber);
                        accountList =
                            accountList.unique((x) => x.accountNumber);

                      allaccountList.addAll(accountList);

                        if (widget.requestMoneyValues!.route ==
                            Routes.kNotificationsView) {
                          current = 2;
                        } else {
                           if(accountListForPayTo.any((element) =>
                              (element.cfprcd?.toUpperCase().trim() == "SSHADOW" ))){
                          current = 0;

                       }
                        else if (accountList.length == 1 ) {
                            current = 1;
                            if(savedPayees.isNotEmpty){
                            fundTransferEntity.payToacctname = savedPayees[0].nickName;
                            fundTransferEntity.payToacctnmbr = savedPayees[0].accountNumber;
                            fundTransferEntity.name = savedPayees[0].accountHolderName;
                            fundTransferEntity.bankName = savedPayees[0].bankName;
                            fundTransferEntity.bankCode = int.parse(savedPayees[0].bankCode ?? "0");
                            } 
                          } else {
                            current = 0;
                          }
                        }

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

                        if (accountListForPayTo.length > 1) {
                         if(accountListForPayTo.any((element) => (element.cfprcd?.toUpperCase().trim() == "SSHADOW" ))){
                            //  accountListForPayTo =   accountListForPayTo.where((element) =>
                            //   (element.cfprcd?.toUpperCase().trim() == "SSHADOW")).toList();
                         accountListForPayTo=   accountListForPayTo.where((e)=>e.accountNumber != accountList[0].accountNumber).toList();

                              }else{
                                accountListForPayTo.removeAt(currentIndex);

                              }
                          
                          if (currentIndexforPayto == 0 && current == 0) {
                            fundTransferEntity.payToacctnmbr =
                                accountListForPayTo[0].accountNumber;
                            fundTransferEntity.payToacctname =
                                accountListForPayTo[0].nickName;
                            fundTransferEntity.bankName =
                                accountListForPayTo[0].bankName;
                            fundTransferEntity.bankCode =
                                int.parse(accountListForPayTo[0].bankCode!);
                            // fundTransferEntity.instrumentId = accountListForPayTo[0].instrumentId;
                          }
                        }
                      });
                    }
                    bloc.add(GetTxnCategoryFTEvent());
                    //  hideProgressBar();
                    // accountListForPayTo.removeAt(currentIndex);
                  }
                  if (state is GetUserInstrumentFailedState) {
                    //  hideProgressBar();
                    showAppDialog(
                        title: AppLocalizations.of(context).translate("there_was_some_error"),
                        alertType: AlertType.FAIL,
                        message: state.message,
                        positiveButtonText:
                            AppLocalizations.of(context).translate("Try_Again"),
                        onPositiveCallback: () {
                          accountList.clear();
                          accountListForPayTo.clear();
                        },
                        negativeButtonText: AppLocalizations.of(context).translate("go_back"),
                        onNegativeCallback: () {
                          Navigator.of(context).pop();
                        });
                  }
                  if (state is AccountInquiryFailState) {
                    bloc.add(GetAccountInquiryEvent(cif: cif));
                  }
                  if (state is BiometricPromptFor2FASuccessState) {
                    onTapConfirm();
                  }
                  if (state is GetTransLimitForFTSuccessState) {
                    bloc.add(GetSavedPayeesForFTEvent());
                    setState(() {});
                  }
                  if (state is GetTransLimitForFTFailedState) {
                    //  hideProgressBar();
                    showAppDialog(
                        alertType: AlertType.WARNING,
                        title: AppLocalizations.of(context).translate("something_went_wrong"),
                        message:
                            AppLocalizations.of(context).translate("txn_limit_not_ft"),
                        positiveButtonText: AppLocalizations.of(context).translate("ok"),
                        onPositiveCallback: () {
                          Navigator.pop(context);
                          setState(() {});
                        });
                  }
                  if (state is FtGetNameSuccessState) {
                    if(widget.requestMoneyValues!.route == Routes.kNotificationsView){
                      showProgressBar();
                    }
                    accountName = state.acctName;
                    fundTransferEntity.payToacctname = state.acctName;
                    _controllerNewToAcctName.text = maskName(accountName ?? "");
                    isUserEdited = true;
                    _formKey.currentState?.validate();
                    if(isCategorySuccess == true){
                      hideProgressBar();
                    }
                    setState(() {});
                  }
                  if (state is FtGetNameFailState) {
                    showAppDialog(
                      title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                      alertType: AlertType.WARNING,
                      message: state.errorMessage ?? '',
                      positiveButtonText:
                          AppLocalizations.of(context).translate("ok"),
                      onPositiveCallback: () {
                        fundTransferEntity.payToacctname = null;
                        accountName = null;
                        _controllerNewToAcctName.clear();
                        setState(() {});
                      },
                    );
                    ;
                  }
                  if (state is GetTxnCategoryFTSuccessState) {
                    categoryList = state.data;
                    isCategorySuccess = true;
                    setState(() {

                    });
                  }
                  if (state is GetTxnCategoryFTFailState) {
                    ToastUtils.showCustomToast(
                        context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
                  }
                  if (state is GetSavedPayeesForFTSuccessState) {
                    savedPayees.clear();
                    state.savedPayees!
                        .sort((a, b) => a.nickName!.compareTo(b.nickName!));
                    List<SavedPayeeEntity> favoriteItems = state.savedPayees!
                        .where((element) => element.favourite == true)
                        .map(
                          (e) => SavedPayeeEntity(
                            bankCode: e.bankCode,
                            branchCode: e.branchCode,
                            branchName: e.branchName,
                            accountNumber: e.accountNumber,
                            nickName: e.nickName,
                            bankName: e.bank,
                            isFavorite: e.favourite!,
                            payeeImageUrl: bankIcons
                                .firstWhere(
                                  (element) =>
                                      element.bankCode ==
                                      (e.bankCode ??
                                          AppConstants.ubBankCode.toString()),
                                  orElse: () => BankIcon(),
                                )
                                .icon,
                            accountHolderName: e.name,
                            id: e.id,
                          ),
                        )
                        .toList();

                    List<SavedPayeeEntity> nonFavoriteItems = state.savedPayees!
                        .where((element) => element.favourite != true)
                        .map(
                          (e) => SavedPayeeEntity(
                            bankCode: e.bankCode,
                            branchCode: e.branchCode,
                            branchName: e.branchName,
                            accountNumber: e.accountNumber,
                            nickName: e.nickName,
                            bankName: e.bank,
                            isFavorite: e.favourite!,
                            payeeImageUrl: bankIcons
                                .firstWhere(
                                  (element) =>
                                      element.bankCode ==
                                      (e.bankCode ??
                                          AppConstants.ubBankCode.toString()),
                                  orElse: () => BankIcon(),
                                )
                                .icon,
                            accountHolderName: e.name,
                            id: e.id,
                          ),
                        )
                        .toList();

                    favoriteItems
                        .sort((a, b) => a.nickName!.compareTo(b.nickName!));
                    nonFavoriteItems
                        .sort((a, b) => a.nickName!.compareTo(b.nickName!));
                    savedPayees.addAll(favoriteItems);
                    savedPayees.addAll(nonFavoriteItems);
                    if(savedPayees.length == 0){
                      isPayeeNotSelected = true;
                    }
                    bloc.add(GetPortfolioAccDetailsEvent());
                    setState(() {});
                  }
                  if(state is GetSavedPayeeForFTFailedState){
                    bloc.add(GetPortfolioAccDetailsEvent());
                  }
                  if (state is GetbranchSuccessState) {
                    branchList = state.data;
                    searchBranchList = branchList;
                  }
                },
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context),),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: Column(
                                children: [
                                  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                    Text(AppLocalizations.of(context).translate("Pay_From"),
                                    style: size14weight700.copyWith(color: colors(context).blackColor)
                                      ),
                                     16.verticalSpace,
                                     AppCarouselWidget(
                                       accountList: accountList,
                                         onPageChanged: (index, reason) {
                                           setState(() {
                                             isUserEdited = true;
                                             currentIndex = index;
                                             fundTransferEntity.availableBalance = accountList[index].availableBalance;
                                             fundTransferEntity.payFromNum = accountList[index].accountNumber;
                                             fundTransferEntity.payFromName = accountList[index].nickName;
                                             fundTransferEntity.instrumentId = accountList[index].instrumentId;
                                             fundTransferEntity.bankCodePayFrom = int.parse(accountList[index].bankCode!);
                                             if(fundTransferEntity.amount!=null){
                                               if ((fundTransferEntity.amount! > fundTransferEntity.availableBalance!)&&(fundTransferEntity.bankCodePayFrom==AppConstants.ubBankCode)) {
                                                 setState(() {
                                                   isAmountAvailable =
                                                   false;
                                                 });
                                               } else {
                                                 setState(() {
                                                   isAmountAvailable =
                                                   true;
                                                 });
                                               }
                                             }
                                           });
                                           if(currentIndex == index){
                                             carauselValue.fillRange(0, carauselValue.length, false); // Set all items to false.
                                             if (index >= 0 && index < carauselValueForPayTo.length) {
                                               carauselValue[index] = true; // Set the specified index to true.
                                             }
                                           }
                                           List<AccountEntity> rs = [];
                                           rs.clear();
                                           rs =[...allaccountList];
                                           rs.removeWhere((element) =>element.instrumentId== accountList[index].instrumentId);
                                           accountListForPayTo=[...rs];
                                          accountListForPayTo = accountListForPayTo.unique((x) => x.accountNumber);
                                           setState(() { });
                                           if(widget.requestMoneyValues!.route != Routes.kNotificationsView && current == 0){
                                             fundTransferEntity.payToacctnmbr = accountListForPayTo[currentIndexforPayto].accountNumber;
                                             fundTransferEntity.payToacctname = accountListForPayTo[currentIndexforPayto].nickName;
                                             fundTransferEntity.bankName = accountListForPayTo[currentIndexforPayto].bankName;
                                             fundTransferEntity.bankCode = int.parse(accountListForPayTo[currentIndexforPayto].bankCode!);
                                             setState(() { });
                                           }
                                           if(_amountController.text!=null&&_amountController.text!="0.00"){
                                             _formKey.currentState?.validate();
                                           }
                                         }),
                                     16.verticalSpace,
                                      Column(
                                          children: [
                                            if(widget.requestMoneyValues!.route == Routes.kNotificationsView)
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)).r,
                                                  color: colors(context).whiteColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0).w,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(AppLocalizations.of(context).translate("Pay_To"),
                                                          style: size14weight700.copyWith(color: colors(context).blackColor)
                                                      ),
                                                      16.verticalSpace,
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 64,
                                                            height: 64,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8).r,
                                                                border: Border.all(color: colors(context).greyColor300!)),
                                                            child: (iconForRequest == null)
                                                                ? Center(child: Text(
                                                              fundTransferEntity.payToacctname?.toString().getNameInitial() ?? "",
                                                                style: size20weight700.copyWith(color: colors(context).primaryColor),
                                                              ),
                                                            )
                                                                : Center(child: ClipRRect(
                                                                   borderRadius: BorderRadius.circular(8).r,
                                                                  child: Image.asset(
                                                                    iconForRequest ?? "",
                                                                  ),
                                                                ),
                                                            ),
                                                          ),
                                                          24.horizontalSpace,
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: (MediaQuery.of(context).size.width/2),
                                                                child: Text(fundTransferEntity.payToacctname ?? "",
                                                                overflow: TextOverflow.ellipsis,
                                                                    style: size16weight700.copyWith(color: colors(context).blackColor)
                                                                ),
                                                              ),
                                                              8.verticalSpace,
                                                              Text(fundTransferEntity.payToacctnmbr ?? "",
                                                                  style: size14weight400.copyWith(color: colors(context).blackColor)
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            if(widget.requestMoneyValues!.route != Routes.kNotificationsView)
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(AppLocalizations.of(context).translate("Pay_To"),
                                                      style: size14weight700.copyWith(color: colors(context).blackColor)
                                                  ),
                                                  16.verticalSpace,
                                                  Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)).r,
                                                    color: colors(context).whiteColor,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(16,16,16,8).w,
                                                    child: SizedBox(
                                                      height: 40.h,
                                                      child: SlidingSegmentedBar(
                                                        isBorder: true,
                                                        selectedTextStyle: size14weight700.copyWith(color: colors(context).whiteColor),
                                                        textStyle: size14weight700.copyWith(color: colors(context).blackColor),
                                                        backgroundColor: colors(context).whiteColor,
                                                        onChanged: (int value) {
                                                          setState(() {
                                                            if(accountListForPayTo.any((element) => (element.cfprcd?.toUpperCase().trim() == "SSHADOW"))){
                                                              current = value;

                                                            }
                                                            else if (accountList.length == 1) {
                                                              if (value != 0) {
                                                                current = value;
                                                              }
                                                            } else {
                                                              current = value;
                                                            }

                                                            if(current == 2){
                                                              fundTransferEntity.payToacctname = null;
                                                              fundTransferEntity.payToacctnmbr = null;
                                                              tabChangeNull();
                                                              if(isUserSelectedBankDropdown == false){
                                                                fundTransferEntity.bankCode = AppConstants.ubBankCode;
                                                              }
                                                              _amountController = CurrencyTextEditingController();
                                                              setState(() {});
                                                            }
                                                            if(current == 1){
                                                              fundTransferEntity.payToacctname = null;
                                                              fundTransferEntity.payToacctnmbr = null;
                                                              _controllerNewToAcct.clear();
                                                              isUserSelectedBankDropdown = false;
                                                              accountName = "";
                                                              _controllerNewToAcctName.clear();
                                                              _amountController = CurrencyTextEditingController();
                                                              tabChangeNull();
                                                              // if(currentIndexSavedPayee == 0){
                                                              if(savedPayees.isNotEmpty){
                                                                fundTransferEntity.payToacctname = savedPayees[0].nickName;
                                                                fundTransferEntity.payToacctnmbr = savedPayees[0].accountNumber;
                                                                fundTransferEntity.name = savedPayees[0].accountHolderName;
                                                                fundTransferEntity.bankName = savedPayees[0].bankName;
                                                                fundTransferEntity.bankCode = int.parse(savedPayees[0].bankCode ?? "0");

                                                              }
                                                                
                                                              // }
                                                              setState(() {});
                                                            }
                                                            if(current == 0){
                                                               
                                                              _controllerNewToAcct.clear();
                                                              accountName = "";
                                                              isUserSelectedBankDropdown = false;
                                                              _controllerNewToAcctName.clear();
                                                               tabChangeNull();
                                                              _amountController = CurrencyTextEditingController();
                                                              fundTransferEntity.bankCode =int.parse(accountListForPayTo[0].bankCode!) ;
                                                              fundTransferEntity.payToacctname = accountListForPayTo[0].nickName;
                                                              fundTransferEntity.payToacctnmbr = accountListForPayTo[0].accountNumber;
                                                              setState(() {});
                                                            }

                                                          });
                                                        },
                                                        selectedIndex: current,
                                                        children: [
                                                         AppLocalizations.of(context).translate("own"),
                                                         AppLocalizations.of(context).translate("saved"),
                                                         AppLocalizations.of(context).translate("new"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),),
                                                ],
                                              ),
                                            if (current == 0) Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      AppCarouselWidget(
                                                        isCornerNotRound: true,
                                                        accountList: accountListForPayTo,
                                                        onPageChanged: (index, reason) {  setState(() {
                                                          isUserEdited = true;
                                                          fundTransferEntity .payToacctnmbr = accountListForPayTo[index].accountNumber;
                                                          fundTransferEntity.payToacctname = accountListForPayTo[index].nickName;
                                                          fundTransferEntity.bankName = accountListForPayTo[index].bankName;
                                                          fundTransferEntity.bankCode = int.parse(accountListForPayTo[index].bankCode!);
                                                          // fundTransferEntity.instrumentId = accountListForPayTo[index].instrumentId!;
                                                          currentIndexforPayto = index;
                                                          if(currentIndexforPayto == index){
                                                            carauselValueForPayTo.fillRange(0, carauselValueForPayTo.length, false); // Set all items to false.
                                                            if (index >= 0 && index < carauselValueForPayTo.length) {
                                                              carauselValueForPayTo[index] = true; // Set the specified index to true.
                                                            }
                                                          }}); },
                                                      ),
                                                    ],
                                                  ) else const SizedBox.shrink(),
                                            if (current == 1) Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AppCarouselWidget(
                                                  onTap: (){
                                                    isUserEdited = true;
                                                    Navigator.pushNamed(context, Routes.kPayeeManagementSavedPayeeView,
                                                        arguments: PayeeManagementSavedPayeeViewArgs(isFromFundTransfer: true))
                                                        .then((val) {
                                                      if (val != null && val is SavedPayeeWithList) {
                                                        final savedP= val.savedPayeeEntity;
                                                         final savedPList= val.savedPayeeEntities;

                                                         if(savedPayeeDetails==null){
                                                         savedPayees = savedPList??[];
                                                         }

                                                         if(savedP!=null){
                                                           savedPayeeDetails = savedP ?? savedPayeeDetails;
                                                          fundTransferEntity.payToacctnmbr = savedPayeeDetails?.accountNumber;
                                                          fundTransferEntity.payToacctname = savedPayeeDetails?.nickName;
                                                          fundTransferEntity.bankName = savedPayeeDetails?.bankName;
                                                          fundTransferEntity.name = savedPayeeDetails?.accountHolderName;
                                                          fundTransferEntity.bankCode = int.parse(savedPayeeDetails?.bankCode ?? "");
                                                          selectedPayee = true;
                                                          savedPayees.clear();
                                                          savedPayees.add(savedPayeeDetails!);
                                                          _savedPayeeCarouselController.jumpToPage(0);
                                                          isPayeeNotSelected = false;

                                                         }
                                                          
                                                         
                                                         setState(() { });

                                                        
                                                      }
                                                    });
                                                  },
                                                  isSavedPayeeSelected: ValueNotifier(selectedPayee ?? true),
                                                  carouselController: _savedPayeeCarouselController,
                                                  isSavedPayee: true,
                                                  savedPayeLength: (savedPayees.length) <= 3 ? (savedPayees.length) + 1 : 4,
                                                  isCornerNotRound: true,
                                                  savedPayees: savedPayees,
                                                  onPageInSaved: (value){
                                                    isPayeeNotSelected = value;
                                                    setState(() {});
                                                  },
                                                  onPageChanged: (index, reason) {
                                                    currentIndexSavedPayee = index;
                                                    fundTransferEntity .payToacctnmbr = savedPayees[index].accountNumber;
                                                    fundTransferEntity.payToacctname = savedPayees[index].nickName;
                                                    fundTransferEntity.bankName = savedPayees[index].bankName;
                                                    fundTransferEntity.name = savedPayees[index].accountHolderName;
                                                    fundTransferEntity.bankCode = int.parse(savedPayees[index].bankCode!);

                                                    setState(() {});
                                                    },
                                                ),
                                              ],
                                            ) else const SizedBox.shrink(),
                                            if (current == 2)
                                              if(widget.requestMoneyValues!.route != Routes.kNotificationsView)
                                                Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8) , bottomRight: Radius.circular(8)).r,
                                                color: colors(context).whiteColor,
                                              ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0).w,
                                                    child: Column(
                                                      children: [
                                                        AppDropDown(
                                                      validator: (value){
                                                        if(bankName ==null || bankName == ""){
                                                          return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                        }else{
                                                          return null;
                                                        }
                                                      },
                                                      label: AppLocalizations.of(context).translate("bank"),
                                                      labelText: AppLocalizations.of(context).translate("select_a_bank"),
                                                      onTap:
                                                          () async {
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
                                                                    isSearch: true,
                                                                    onSearch: (p0) {
                                                                      changeState(() {
                                                                        if (p0.isEmpty || p0=='') {
                                                                          searchBankList = kBankList;
                                                                        } else {
                                                                          searchBankList = kBankList
                                                                              .where((element) => element
                                                                              .description!
                                                                              .toLowerCase()
                                                                              .contains(p0.toLowerCase())).toSet().toList();
                                                                        }
                                                                      });
                                                                    },
                                                                    title: AppLocalizations.of(context).translate('Select_Bank'),
                                                                    buttons: [
                                                                      Expanded(
                                                                        child: AppButton(
                                                                            buttonType: ButtonType.PRIMARYENABLED,
                                                                            buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                            onTapButton: () {
                                                                              bankCode = bankCodeTemp;
                                                                              bankName = bankNameTemp;
                                                                              fundTransferEntity.bankName = bankName;
                                                                              fundTransferEntity.bankCode = int.parse(bankCode ?? "0");
                                                                              bloc.add(GetBankBranchEvent(bankCode:fundTransferEntity.bankCode.toString()));
                                                                              isUserEdited = true;
                                                                              fundTransferEntity.payToacctname = null;
                                                                              _controllerNewToAcctName.clear();
                                                                              _controllerNewToAcct.clear();
                                                                              fundTransferEntity.payToacctnmbr = null;
                                                                              _formKey.currentState?.validate();
                                                                              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                              Navigator.of(context).pop(true);
                                                                              changeState(() {});
                                                                              setState(() {});
                                                                            }),
                                                                      ),
                                                                    ],
                                                                    children: [
                                                                      ListView.builder(
                                                                        itemCount: searchBankList.length,
                                                                        shrinkWrap: true,
                                                                         padding: EdgeInsets.zero,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        itemBuilder: (context, index) {
                                                                          return InkWell(
                                                                            onTap: (){
                                                                              bankCodeTemp = searchBankList[index].key;
                                                                              bankNameTemp = searchBankList[index].description;
                                                                              changeState(() {});
                                                                            },
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:12,0,12).h,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 48.w,
                                                                                        height: 48.w,
                                                                                        decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(8).r,
                                                                                            border: Border.all(color: colors(context).greyColor300!)
                                                                                        ),
                                                                                        child: (searchBankList[ index] .icon==null)
                                                                                            ? Center(
                                                                                          child: Text(
                                                                                            searchBankList[index].description
                                                                                                ?.toString()
                                                                                                .getNameInitial() ?? "",
                                                                                            style: size20weight700.copyWith(
                                                                                                color: colors(context).primaryColor),
                                                                                          ),
                                                                                        )
                                                                                            : Center(
                                                                                          child:ClipRRect(
                                                                                             borderRadius: BorderRadius.circular(8).r,
                                                                                            child: Image.asset(
                                                                                              searchBankList[ index] .icon ?? "",
                                                                                            ),
                                                                                          ) ,
                                                                                        ),
                                                                                      ),
                                                                                      12.horizontalSpace,
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          searchBankList[index].description ?? "",
                                                                                          style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(right: 8).w,
                                                                                        child: UBRadio<dynamic>(
                                                                                          value: searchBankList[index].key ?? "",
                                                                                          groupValue: bankCodeTemp,
                                                                                          onChanged: ( value) {
                                                                                             bankCodeTemp = searchBankList[index].key;
                                                                                              bankNameTemp = searchBankList[index].description;
                                                                                            changeState(() {});
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if(searchBankList.length-1 != index)
                                                                                  Divider(
                                                                                  height: 0 ,
                                                                                  thickness: 1,
                                                                                    color: colors(context).greyColor100
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
                                                        searchBankList = kBankList;
                                                        setState(() {});
                                                      },
                                                      initialValue: bankName,
                                                    ),
                                                        16.verticalSpace,
                                                        AppTextField(
                                                          validator: (a){
                                                            if(_controllerNewToAcct.text==""||_controllerNewToAcct.text==null){
                                                              return AppLocalizations.of(context)
                                                                  .translate("mandatory_field_msg");
                                                            }else{
                                                              return null;
                                                            }
                                                          },
                                                          maxLength: fundTransferEntity.bankCode == AppConstants.ubBankCode?16:null,
                                                          controller: _controllerNewToAcct,
                                                          isInfoIconVisible: false,
                                                          title: AppLocalizations.of(context).translate("Account_Number"),
                                                          hint: AppLocalizations.of(context).translate("enter_account_no"),
                                                          isCurrency: false,
                                                          focusNode: _focusNodeNewToAcct,
                                                          inputType:
                                                          TextInputType.number,
                                                          inputFormatter: [
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          onTextChanged: (value) {
                                                            isUserEdited = true;
                                                            fundTransferEntity.payToacctnmbr = value;
                                                            if(fundTransferEntity.bankCode == AppConstants.ubBankCode){
                                                              if(_controllerNewToAcct.text.length == 16){
                                                                bloc.add(GetAccountNameFTEvent(
                                                                    accountNo: fundTransferEntity.payToacctnmbr
                                                                ));
                                                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                              }
                                                              if(_controllerNewToAcct.text.length < 16){
                                                                accountName=null;
                                                                _controllerNewToAcctName.clear();
                                                                fundTransferEntity.payToacctname=null;
                                                              }
                                                            }
                                                            setState(() {});
                                                            _formKey.currentState?.validate();
                                                          },
                                                        ),
                                                        16.verticalSpace,
                                                        AppTextField(
                                                          validator: (a){
                                                            if(_controllerNewToAcctName.text.isEmpty){
                                                              return AppLocalizations.of(context)
                                                                  .translate("mandatory_field_msg");
                                                            }else{
                                                              return null;
                                                            }
                                                          },
                                                          controller: _controllerNewToAcctName,
                                                          isInfoIconVisible: false,
                                                          title: AppLocalizations.of(context).translate("name"),
                                                          inputType: TextInputType.text,
                                                          inputFormatter: [
                                                            FilteringTextInputFormatter.allow(
                                                                RegExp("[A-Z a-z ]")),
                                                          ],
                                                          initialValue: _controllerNewToAcctName.text,
                                                          isEnable: fundTransferEntity.bankCode != AppConstants.ubBankCode,
                                                          hint: AppLocalizations.of(context).translate("enter_account_name"),
                                                          focusNode: _focusNodeNewName,
                                                          isCurrency: false,
                                                          onTextChanged: (value) {
                                                            setState(() {
                                                              isUserEdited = true;
                                                              fundTransferEntity.payToacctname = value;
                                                            });
                                                            _formKey.currentState?.validate();
                                                          },
                                                        ),
                                                        if(fundTransferEntity.bankCode != AppConstants.ubBankCode)
                                                          Column(
                                                            children: [
                                                              16.verticalSpace,
                                                              AppDropDown(
                                                              label: AppLocalizations.of(context).translate("branch_(Optional)"),
                                                              labelText: AppLocalizations.of(context).translate("select_branch"),
                                                              onTap: () async {
                                                                if(fundTransferEntity.bankCode == null || fundTransferEntity.bankCode == ""){
                                                                  return;
                                                                }
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
                                                                            isSearch: true,
                                                                            onSearch: (p0) {
                                                                              changeState(() {
                                                                                if (p0.isEmpty || p0=='') {
                                                                                  searchBranchList = branchList;
                                                                                } else {
                                                                                  searchBranchList = branchList
                                                                                      ?.where((element) => element
                                                                                      .description!
                                                                                      .toLowerCase()
                                                                                      .contains(p0.toLowerCase())).toSet().toList();
                                                                                }
                                                                              });
                                                                            },
                                                                            title: AppLocalizations.of(context).translate('select_branch'),
                                                                            buttons: [
                                                                              Expanded(
                                                                                child: AppButton(
                                                                                    buttonType: ButtonType.PRIMARYENABLED,
                                                                                    buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                                    onTapButton: () {
                                                                                      branchCode = branchCodeTemp;
                                                                                      branchName = branchNameTemp;
                                                                                      fundTransferEntity.branch = branchCode;
                                                                                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                                      Navigator.of(context).pop(true);
                                                                                      changeState(() {});
                                                                                      setState(() {});
                                                                                    }),
                                                                              ),
                                                                            ],
                                                                            children: [
                                                                              ListView.builder(
                                                                                itemCount: searchBranchList?.length,
                                                                                shrinkWrap: true,
                                                                                 padding: EdgeInsets.zero,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (context, index) {
                                                                                  return InkWell(
                                                                                    onTap: (){
                                                                                      branchCodeTemp = searchBranchList![index].code;
                                                                                      branchNameTemp = searchBranchList![index].description;
                                                                                      changeState(() {});
                                                                                    },
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).w,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Text(
                                                                                                  searchBranchList![index].description ?? "",
                                                                                                  style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(right: 8).w,
                                                                                                child: UBRadio<dynamic>(
                                                                                                  value: searchBranchList![index].code ?? "",
                                                                                                  groupValue: branchCodeTemp,
                                                                                                  onChanged: (value) {
                                                                                                    branchCodeTemp = value;
                                                                                                    branchCodeTemp = searchBranchList![index].code;
                                                                                                    changeState(() {});
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),

                                                                                        if(searchBranchList!.length-1 != index)
                                                                                          Divider(
                                                                                              height: 0 ,
                                                                                              thickness: 1,
                                                                                              color: colors(context).greyColor100
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
                                                                searchBranchList = branchList;
                                                                setState(() {});
                                                              },
                                                              initialValue: branchName,
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ) else const SizedBox.shrink(),
                                            16.verticalSpace,
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8).r,
                                                color: colors(context).whiteColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0).w,
                                                child: Column(
                                                  children: [
                                                   AppTextField(
                                                    key: Key(current.toString()),
                                                      controller: _amountController,
                                                      validator: (a){
                                                        if(_amountController.text==""||_amountController.text==null||_amountController.text=="0"||_amountController.text=="0.00"){
                                                          return AppLocalizations.of(context).translate("mandatory_field_msg");
                                                        }else if(isAmountAvailable == false){
                                                          return AppLocalizations.of(context).translate("this_amount_not_available");
                                                        } else{
                                                          return null;
                                                        }
                                                      },
                                                      focusNode: _focusNodeAmount,
                                                      isInfoIconVisible: false,
                                                      title: AppLocalizations.of(context).translate("amount"),
                                                      hint: AppLocalizations.of(context).translate("amount"),
                                                      maxLength: 15,
                                                      inputFormatter: [FilteringTextInputFormatter.allow(RegExp("[0-9.,]")),],
                                                      isCurrency: true,
                                                      inputType: TextInputType.number,
                                                      onTextChanged: (value) {
                                                          isUserEdited = true;
                                                          // ownAmountController.text = value;
                                                          double parsedValue = double.parse(value.replaceAll(',', ''));
                                                          fundTransferEntity.amount = parsedValue;
                                                          if ((fundTransferEntity.amount! > fundTransferEntity.availableBalance!)&&(fundTransferEntity.bankCodePayFrom==AppConstants.ubBankCode)) {

                                                              isAmountAvailable = false;
                                                          } else {
                                                              isAmountAvailable = true;
                                                          }
                                                        setState(() {});

                                                        _formKey.currentState?.validate();
                                                      },
                                                    ),
                                                    24.verticalSpace,
                                                    AppTextField(
                                                      isInfoIconVisible: false,
                                                      hint: AppLocalizations.of(context).translate("enter_remarks"),
                                                      title: AppLocalizations.of(context).translate("remark_optional"),
                                                      maxLength: 30,
                                                      focusNode: _focusNoderemarks,
                                                      isCurrency: false,
                                                      inputType: TextInputType.text,
                                                      onTextChanged: (value) {
                                                        setState(() {
                                                          isUserEdited = true;
                                                          fundTransferEntity.remark = value;
                                                        });
                                                      },
                                                    ),
                                                    24.verticalSpace,
                                                    AppDropDown(
                                                      labelText: AppLocalizations.of(context).translate("select_category"),
                                                      label: AppLocalizations.of(context).translate("transaction_category_(Optional)"),
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
                                                                    title: AppLocalizations.of(context).translate('transaction_category'),
                                                                    buttons: [
                                                                      Expanded(
                                                                        child: AppButton(
                                                                            buttonType: ButtonType.PRIMARYENABLED,
                                                                            buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                            onTapButton: () {
                                                                              fundTransferEntity.transactionCategory = tranCatoryTemp;
                                                                              unfocus();
                                                                             WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                              Navigator.of(context).pop(true);
                                                                              changeState(() {});
                                                                              setState(() {});

                                                                            }),
                                                                      ),
                                                                    ],
                                                                    children: [
                                                                    if(categoryList!=null)  ListView.builder(
                                                                        itemCount: categoryList?.length,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                         padding: EdgeInsets.zero,
                                                                        itemBuilder: (context, index) {
                                                                          return InkWell(
                                                                            onTap: (){
                                                                              tranCatoryTemp = categoryList![index].description!;
                                                                              changeState(() {});
                                                                            },
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                 padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24,0,24).h,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        categoryList![index].description!,
                                                                                        style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                      ),
                                                                                     Padding(
                                                                                       padding: const EdgeInsets.only(right:  8).w,
                                                                                       child: UBRadio<dynamic>(
                                                                                          value: categoryList![index].description!,
                                                                                          groupValue: tranCatoryTemp,
                                                                                          onChanged: (value) {
                                                                                            tranCatoryTemp = categoryList![index].description!;
                                                                                            changeState(() {});
                                                                                          },
                                                                                        ),
                                                                                     ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if(categoryList!.length-1 != index)
                                                                                  Divider(
                                                                                      height: 0 ,
                                                                                      thickness: 1,
                                                                                      color: colors(context).greyColor100
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
                                                      initialValue: fundTransferEntity.transactionCategory,
                                                    ),
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
                                                padding: const EdgeInsets.all(16.0).w,
                                                child: Column(
                                                  children: [
                                                    AppDropDown(
                                                      label: AppLocalizations.of(context).translate("when"),
                                                      labelText: AppLocalizations.of(context).translate("schedule_type"),
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
                                                                    title: AppLocalizations.of(context).translate("when"),
                                                                    buttons: [
                                                                      Expanded(
                                                                        child: AppButton(
                                                                            buttonType: ButtonType.PRIMARYENABLED,
                                                                            buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                            onTapButton: () {
                                                                              schedule = scheduleTemp;
                                                                              scheduleIndex = scheduleIndexTemp;
                                                                              _formKey.currentState?.validate();
                                                                              unfocus();
                                                                              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                              Navigator.of(context).pop(true);
                                                                              changeState(() {});
                                                                              setState(() {});

                                                                            }),
                                                                      ),
                                                                    ],
                                                                    children: [
                                                                      ListView.builder(
                                                                        itemCount: scheduleType.length,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                         padding: EdgeInsets.zero,
                                                                        itemBuilder: (context, index) {
                                                                          return InkWell(
                                                                            onTap: (){
                                                                              schedule ="now";
                                                                              scheduleTemp = "now";
                                                                              scheduleIndex = 0;
                                                                              scheduleIndexTemp = 0;
                                                                              scheduleTemp = scheduleType[index].description;
                                                                              scheduleIndexTemp = scheduleType[index].scheduleIndex;
                                                                              changeState(() {});
                                                                            },
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24,0,24).h,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        AppLocalizations.of(context).translate(scheduleType[index].description),
                                                                                        style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(right: 8).w,
                                                                                        child: UBRadio<dynamic>(
                                                                                          value: scheduleType[index].description,
                                                                                          groupValue: scheduleTemp,
                                                                                          onChanged: (value) {
                                                                                            scheduleTemp = scheduleType[index].description;
                                                                                            scheduleIndexTemp = scheduleType[index].scheduleIndex;
                                                                                            changeState(() {});
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if(scheduleType.length-1 != index)
                                                                                  Divider(
                                                                                      height: 0 ,
                                                                                      thickness: 1,
                                                                                      color: colors(context).greyColor100
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
                                                      initialValue: AppLocalizations.of(context).translate(schedule!),
                                                    ),
                                                    if(scheduleIndex == 1)
                                                      Column(
                                                        children: [
                                                          24.verticalSpace,
                                                          FTDatePicker(
                                                          validator: (value){
                                                            if(value ==null){
                                                              return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                            }else{
                                                              return null;
                                                            }
                                                          },
                                                          isStartDateSelected: true,
                                                          text: fundTransferEntity.transactionDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse( fundTransferEntity.transactionDate!)) :null,
                                                          initialDate:DateTime.now().add(const Duration(days: 1)),
                                                          firstDate: DateTime.now().add(const Duration(days: 1)),
                                                          labelText: AppLocalizations.of(context).translate("transaction_date"),
                                                          title: AppLocalizations.of(context).translate("transaction_date"),
                                                          onChange: (value) {
                                                            setState(() {
                                                              isUserEdited = true;
                                                              fundTransferEntity.transactionDate = value;
                                                            });
                                                            _formKey.currentState?.validate();
                                                            unfocus();
                                                          },),
                                                        ],
                                                      ),
                                                    if(scheduleIndex == 2)
                                                      Column(
                                                          children:[
                                                            24.verticalSpace,
                                                            FTDatePicker(
                                                              validator: (value){
                                                                if(value ==null){
                                                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                                }else{
                                                                  return null;
                                                                }
                                                              },
                                                              isStartDateSelected: true,
                                                              text:fundTransferEntity.startDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse( fundTransferEntity.startDate!)) :null ,
                                                              initialDate:DateTime.now().add(const Duration(days: 1)),
                                                              firstDate: DateTime.now().add(const Duration(days: 1)),
                                                              labelText: AppLocalizations.of(context).translate("start_date"),
                                                              title: AppLocalizations.of(context).translate("start_date"),
                                                              onChange: (value) {
                                                                setState(() {
                                                                  isUserEdited = true;
                                                                  fundTransferEntity.startDate = value;
                                                                  if(fundTransferEntity.endDate != null){
                                                                    fundTransferEntity.endDate = null;
                                                                    setState(() {});
                                                                  }
                                                                });
                                                                _formKey.currentState?.validate();
                                                                unfocus();
                                                              },
                                                            ),
                                                            24.verticalSpace,
                                                            FTDatePicker(
                                                              validator: (value){
                                                                if(value ==null || fundTransferEntity.endDate == null){
                                                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                                }
                                                                // else if (DateFormat('d MMMM yyyy').parse(fundTransferEntity.endDate!).isBefore(DateFormat('d MMMM yyyy').parse( fundTransferEntity.startDate!))){
                                                                //   return "End date cannot be before ${fundTransferEntity.startDate}";
                                                                // }
                                                                else{
                                                                  return null;
                                                                }
                                                              },
                                                              isStartDateSelected: true,
                                                              text: fundTransferEntity.endDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse( fundTransferEntity.endDate!)) :null ,
                                                              initialDate:fundTransferEntity.startDate!=null ? DateFormat('d MMMM yyyy').parse( fundTransferEntity.startDate!).add(Duration(days: 1)) :
                                                              DateTime.now().add(const Duration(days: 1)),
                                                              firstDate:fundTransferEntity.startDate!=null ? DateFormat('d MMMM yyyy').parse( fundTransferEntity.startDate!).add(Duration(days: 1)) :
                                                              DateTime.now().add(const Duration(days: 1)),
                                                              labelText: AppLocalizations.of(context).translate("end_date"),
                                                              title: AppLocalizations.of(context).translate("end_date"),
                                                              onChange: (value) {
                                                                setState(() {
                                                                  isUserEdited = true;
                                                                  fundTransferEntity.endDate = value;
                                                                });
                                                                _formKey.currentState?.validate();
                                                                unfocus();
                                                              },
                                                            ),
                                                            24.verticalSpace,
                                                            AppDropDown(
                                                              validator: (value){
                                                                if(scheduleFrequency == null || scheduleFrequency == ""){
                                                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                                }else{
                                                                  return null;
                                                                }
                                                              },
                                                              label: AppLocalizations.of(context).translate("frequency"),
                                                              labelText: AppLocalizations.of(context).translate("select_frequency"),
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
                                                                            title: AppLocalizations.of(context).translate('schedule_type'),
                                                                            buttons: [
                                                                              Expanded(
                                                                                child: AppButton(
                                                                                    buttonType: ButtonType.PRIMARYENABLED,
                                                                                    buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                                    onTapButton: () {
                                                                                      scheduleFrequency = scheduleFrequencyTemp;
                                                                                      fundTransferEntity.scheduleFrequency = scheduleFrequency;
                                                                                      _formKey.currentState?.validate();
                                                                                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                                      Navigator.of(context).pop(true);
                                                                                      changeState(() {});
                                                                                      setState(() {});

                                                                                    }),
                                                                              ),
                                                                            ],
                                                                            children: [
                                                                              ListView.builder(
                                                                                itemCount: AppConstants.kGetFTFrequencyList.length,
                                                                                shrinkWrap: true,
                                                                                 padding: EdgeInsets.zero,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (context, index) {
                                                                                  return InkWell(
                                                                                    onTap: (){
                                                                                      scheduleFrequencyTemp = AppConstants.kGetFTFrequencyList[index].description;
                                                                                      changeState(() {});
                                                                                    },
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Padding(
                                                                                         padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24,0,24).w,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                               AppLocalizations.of(context).translate(AppConstants.kGetFTFrequencyList[index].description ?? "") ,
                                                                                                style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(right: 8).w,
                                                                                                child: UBRadio<dynamic>(
                                                                                                  value: AppConstants.kGetFTFrequencyList[index].description??"",
                                                                                                  groupValue: scheduleFrequencyTemp,
                                                                                                  onChanged: (value) {
                                                                                                    scheduleFrequencyTemp = AppConstants.kGetFTFrequencyList[index].description;
                                                                                                    changeState(() {});
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                         if(AppConstants.kGetFTFrequencyList.length-1 != index)
                                                                                        Divider(
                                                                                            height: 0 ,
                                                                                            thickness: 1,
                                                                                            color: colors(context).greyColor100
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
                                                              initialValue: AppLocalizations.of(context).translate(scheduleFrequency!),
                                                            ),
                                                          ]
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if(current != 0)
                                              Column(
                                                children: [
                                                  16.verticalSpace,
                                                  AppSwitch(
                                                    title: AppLocalizations.of(context).translate("notify_the_beneficiary"),
                                                    value: notifyBeneficiary,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        unfocus();
                                                        isUserEdited = true;
                                                        if(value == true){
                                                          setState(() {
                                                            isSavedValidated = false;
                                                          });
                                                        }else{
                                                          setState(() {
                                                            isSavedValidated = true;
                                                          });
                                                        }
                                                        notifyBeneficiary = value;
                                                        fundTransferEntity.beneficiaryMobile =null;
                                                      });
                                                    },
                                                    switchItems: [
                                                      AppTextField(
                                                        validator: (a){
                                                          if(a==""||a==null){
                                                            return AppLocalizations.of(context).translate("mandatory_field_msg");
                                                          } else{
                                                            return null;
                                                          }
                                                        },
                                                        isInfoIconVisible: false,
                                                        title: AppLocalizations.of(context).translate("beneficiary_mobile_no"),
                                                        hint: AppLocalizations.of(context).translate("Enter_mobile_number"),
                                                        isCurrency: false,
                                                        focusNode: _focusNodeBenificiary,
                                                        maxLength: 10,
                                                        inputType: TextInputType.phone,
                                                        onTextChanged:
                                                            (value) {

                                                            fundTransferEntity.beneficiaryMobile = value.replaceAll(",", "");
                                                            if(value.isEmpty || value.length != 10){
                                                                isSavedValidated = false;
                                                            } else {
                                                                isSavedValidated = true;
                                                            }
                                                          setState(() {});
                                                          _formKey.currentState?.validate();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                     AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context)),
                                   ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            20.verticalSpace,
                            AppButton(
                              buttonText: AppLocalizations.of(context)
                                  .translate("continue"),
                              onTapButton: () {
                                if (_formKey.currentState?.validate() ==
                                    false) {
                                  return;
                                }
                                if ((fundTransferEntity.amount! >
                                        fundTransferEntity.availableBalance!) &&
                                    (fundTransferEntity.bankCodePayFrom ==
                                        AppConstants.ubBankCode)) {
                                  setState(() {
                                    isAmountAvailable = false;
                                  });
                                } else {
                                  setState(() {
                                    isAmountAvailable = true;
                                  });
                                }
                                  unfocus();
                                  if (fundTransferEntity.beneficiaryMobile != null) {
                                    if (appValidator.validateMobileNumber(fundTransferEntity.beneficiaryMobile!)) {
                                      _onTap();
                                    } else {
                                      showAppDialog(
                                          title: AppLocalizations.of(context).translate("mobile_num_incorrect"),
                                          message: AppLocalizations.of(context).translate("mobile_num_incorrect_des"),
                                          alertType: AlertType.MOBILE,
                                          onPositiveCallback: () {
                                            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("saved")){
                                              _focusNodeSavedNotifyBen.requestFocus();
                                            }
                                            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("new")){
                                              _focusNodeNewNotifyBen.requestFocus();
                                            }
                                          },
                                          positiveButtonText: AppLocalizations.of(context).translate("ok"));
                                    }
                                  }
                                  else if(notifyBeneficiary == true && fundTransferEntity.beneficiaryMobile == null){
                                    showAppDialog(
                                        title: AppLocalizations.of(context).translate("mobile_num_empty"),
                                        message: AppLocalizations.of(context).translate("mobile_num_empty_des"),
                                        alertType: AlertType.MOBILE,
                                        onPositiveCallback: () {
                                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("saved")){
                                            _focusNodeSavedNotifyBen.requestFocus();
                                          }
                                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("new")){
                                            _focusNodeNewNotifyBen.requestFocus();
                                          }
                                        },
                                        positiveButtonText: AppLocalizations.of(context).translate("ok"));
                                  }
                                  else {
                                    _onTap();
                                  }
                                setState(() {});
                              },
                            ),
                            16.verticalSpace,
                            AppButton(
                              buttonColor: Colors.transparent,
                              buttonType: ButtonType.OUTLINEENABLED,
                              buttonText: AppLocalizations.of(context)
                                  .translate("cancel"),
                              onTapButton: () {
                                showAppDialog(
                                    title: AppLocalizations.of(context).translate("cancel_fund_transfer"),
                                    alertType: AlertType.TRANSFER,
                                    message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                                    positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                                    onPositiveCallback: () {
                                      Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                                    },
                                    negativeButtonText: AppLocalizations.of(context).translate("no"),
                                    onNegativeCallback: () {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }


  tabChangeNull() {
    fundTransferEntity.bankName = null;
    fundTransferEntity.bankCode = null;
    fundTransferEntity.branch = null;
    fundTransferEntity.amount = null;
    fundTransferEntity.startDate = null;
    fundTransferEntity.endDate = null;
    fundTransferEntity.scheduleFrequency = null;
    fundTransferEntity.transactionDate = null;
    fundTransferEntity.remark = null;
    fundTransferEntity.transactionCategory = null;
    isAmountAvailable = true;
    fundTransferEntity.beneficiaryMobile = null;
    notifyBeneficiary = false;
    selectedPayee = false;
    tranCatoryTemp = null;
    schedule = scheduleType[0].description;
    scheduleTemp = scheduleType[0].description;
    scheduleIndex = scheduleType[0].scheduleIndex;
    scheduleIndexTemp = scheduleType[0].scheduleIndex;
    bankName = null;
    bankCode = null;
    bankNameTemp = null;
    bankCodeTemp = null;
    branchName = null;
    branchCode = null;
    branchNameTemp = null;
    branchCodeTemp = null;
  }


  _onTap() {
    if(fundTransferEntity.bankCodePayFrom != AppConstants.ubBankCode && fundTransferEntity.bankCode != AppConstants.ubBankCode){
      setState(() {
        final TranLimitDetails? txnLimitDetails = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OTRTOOTR").first;
        maxGlobalLimitPerTran = txnLimitDetails?.maxGlobalLimitPerTran;
        maxUserAmountPerTran = txnLimitDetails?.maxUserAmountPerTran;
        twoFactorLimit = txnLimitDetails?.twoFactorLimit;
        minUserAmoubtPerTran = txnLimitDetails?.minUserAmountPerTran;
        isTwoFactorEnabled = txnLimitDetails?.enabledTwoFactorLimit;

        final _serviceCharge = txnLimitDetails?.serviceCharge;
        fundTransferEntity.serviceCharge= double.tryParse((_serviceCharge=="-"||_serviceCharge==null||_serviceCharge=="0"||_serviceCharge=="0.0"||_serviceCharge=="0.00")?"0.00":_serviceCharge);
        fundTransferEntity.tranType = txnLimitDetails?.transactionType;
      });
    }else if(fundTransferEntity.bankCodePayFrom == AppConstants.ubBankCode && fundTransferEntity.bankCode != AppConstants.ubBankCode) {
      setState(() {
        final TranLimitDetails? txnLimitDetails = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OTHERBANK").first;
        maxGlobalLimitPerTran = txnLimitDetails?.maxGlobalLimitPerTran;
        maxUserAmountPerTran = txnLimitDetails?.maxUserAmountPerTran;
        twoFactorLimit = txnLimitDetails?.twoFactorLimit;
        minUserAmoubtPerTran = txnLimitDetails?.minUserAmountPerTran;
        isTwoFactorEnabled = txnLimitDetails?.enabledTwoFactorLimit;

        final _serviceCharge = txnLimitDetails?.serviceCharge;
        fundTransferEntity.serviceCharge=double.tryParse((_serviceCharge=="-"||_serviceCharge==null||_serviceCharge=="0"||_serviceCharge=="0.0"||_serviceCharge=="0.00")?"0.00":_serviceCharge);
        fundTransferEntity.tranType = txnLimitDetails?.transactionType;
      });
    } else if(fundTransferEntity.bankCodePayFrom != AppConstants.ubBankCode && fundTransferEntity.bankCode == AppConstants.ubBankCode){
      setState(() {
        final TranLimitDetails? txnLimitDetails = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JP").first;
        maxGlobalLimitPerTran = txnLimitDetails?.maxGlobalLimitPerTran;
        maxUserAmountPerTran = txnLimitDetails?.maxUserAmountPerTran;
        twoFactorLimit = txnLimitDetails?.twoFactorLimit;
        minUserAmoubtPerTran = txnLimitDetails?.minUserAmountPerTran;
        isTwoFactorEnabled = txnLimitDetails?.enabledTwoFactorLimit;

        final _serviceCharge = txnLimitDetails?.serviceCharge;
        fundTransferEntity.serviceCharge=double.tryParse((_serviceCharge=="-"||_serviceCharge==null||_serviceCharge=="0"||_serviceCharge=="0.0"||_serviceCharge=="0.00")?"0.00":_serviceCharge);
        fundTransferEntity.tranType = txnLimitDetails?.transactionType;
      });
    } else if(fundTransferEntity.bankCodePayFrom == AppConstants.ubBankCode && fundTransferEntity.bankCode == AppConstants.ubBankCode && AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("own")){
      setState(() {
        final TranLimitDetails? txnLimitDetails = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUB").first;
        maxGlobalLimitPerTran = txnLimitDetails?.maxGlobalLimitPerTran;
        maxUserAmountPerTran = txnLimitDetails?.maxUserAmountPerTran;
        twoFactorLimit = txnLimitDetails?.twoFactorLimit;
        minUserAmoubtPerTran = txnLimitDetails?.minUserAmountPerTran;
        isTwoFactorEnabled = txnLimitDetails?.enabledTwoFactorLimit;

        final _serviceCharge = txnLimitDetails?.serviceCharge;
        fundTransferEntity.serviceCharge=double.tryParse((_serviceCharge=="-"||_serviceCharge==null||_serviceCharge=="0"||_serviceCharge=="0.0"||_serviceCharge=="0.00")?"0.00":_serviceCharge);
        fundTransferEntity.tranType = txnLimitDetails?.transactionType;
      });
    } else if(fundTransferEntity.bankCodePayFrom == AppConstants.ubBankCode && fundTransferEntity.bankCode == AppConstants.ubBankCode){
      setState(() {
        final TranLimitDetails? txnLimitDetails = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUB").first;
        maxGlobalLimitPerTran = txnLimitDetails?.maxGlobalLimitPerTran;
        maxUserAmountPerTran = txnLimitDetails?.maxUserAmountPerTran;
        twoFactorLimit = txnLimitDetails?.twoFactorLimit;
        minUserAmoubtPerTran = txnLimitDetails?.minUserAmountPerTran;
        isTwoFactorEnabled = txnLimitDetails?.enabledTwoFactorLimit;

        final _serviceCharge = txnLimitDetails?.serviceCharge;
        fundTransferEntity.serviceCharge=double.tryParse((_serviceCharge=="-"||_serviceCharge==null||_serviceCharge=="0"||_serviceCharge=="0.0"||_serviceCharge=="0.00")?"0.00":_serviceCharge);
        fundTransferEntity.tranType = txnLimitDetails?.transactionType;
      });
    }else {
    }
    if ((current == 2) && (fundTransferEntity.payFromNum == fundTransferEntity.payToacctnmbr && fundTransferEntity.bankCodePayFrom == fundTransferEntity.bankCode)){
    showAppDialog(
      title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
      alertType: AlertType.FAIL,
      message: AppLocalizations.of(context).translate("same_account_des"),
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () {
        fundTransferEntity.payToacctnmbr = null;
        _controllerNewToAcct.clear();
        accountName = null;
        setState(() {

        });
      },
    );
    return;
    }
    if ((current == 2) && (fundTransferEntity.payToacctnmbr?.length != 16 && fundTransferEntity.bankCode == AppConstants.ubBankCode)){
    showAppDialog(
      title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
      alertType: AlertType.FAIL,
      message: AppLocalizations.of(context).translate("to_account_name_required"),
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () {
        fundTransferEntity.payToacctnmbr = null;
        _controllerNewToAcct.clear();
        accountName = null;
        setState(() {

        });
      },
    );
    return;
    }
    if ((current == 1) && (fundTransferEntity.payFromNum == fundTransferEntity.payToacctnmbr && fundTransferEntity.bankCodePayFrom == fundTransferEntity.bankCode)){
    showAppDialog(
      title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
      alertType: AlertType.FAIL,
      message: AppLocalizations.of(context).translate("same_account_des"),
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () {
        // fundTransferEntity.payToacctnmbr = null;
        // _controllerNewToAcct.clear();
        setState(() {

        });
      },
    );
    return;
    }
    if (isAmountAvailable == false){
    showAppDialog(
    title: AppLocalizations.of(context).translate("insufficient_balance_of_Account"),
    alertType: AlertType.MONEY2,
    message: AppLocalizations.of(context).translate("not_sufficient_bal_des"),
    positiveButtonText: AppLocalizations.of(context).translate("ok"),
    onPositiveCallback: () {},
    );
    }
    else if (fundTransferEntity.amount! > num.parse(maxUserAmountPerTran!)) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("type_wise_limit"),
        alertType: AlertType.FAIL,
        message: "${AppLocalizations.of(context).translate("type_wise_limit_des_1")}${fundTransferEntity.amount.toString().withThousandSeparator()}${AppLocalizations.of(context).translate("type_wise_limit_des_2")}",
        positiveButtonText: AppLocalizations.of(context).translate("change_the_amount"),
        onPositiveCallback: () {
          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("own")){
            _focusNodeOwnAmount.requestFocus();
          }
          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("saved")){
            _focusNodeSavedAmount.requestFocus();
          }
          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("new")){
            _focusNodeNewAmount.requestFocus();
          }
        },
        bottomButtonText: AppLocalizations.of(context).translate("amend_transaction_limit"),
          onBottomButtonCallback: (){
          Navigator.pushNamed(context, Routes.kTransactionListView);
        }
      );
    }
     else if(fundTransferEntity.amount! > num.parse(maxGlobalLimitPerTran!)){
      showAppDialog(
          title: AppLocalizations.of(context).translate("type_wise_limit"),
          alertType: AlertType.FAIL,
          message: AppLocalizations.of(context).translate("type_wise_limit_des"),
          positiveButtonText: AppLocalizations.of(context).translate("try_again"),
          onPositiveCallback: () {
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("own")){
              _focusNodeOwnAmount.requestFocus();
            }
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("saved")){
              _focusNodeSavedAmount.requestFocus();
            }
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("new")){
              _focusNodeNewAmount.requestFocus();
            }
          },
      );
    }
     else if(fundTransferEntity.amount! < num.parse(minUserAmoubtPerTran!)){
      showAppDialog(
          title: AppLocalizations.of(context).translate("invalid_amount"),
          alertType: AlertType.FAIL,
          message: "${AppLocalizations.of(context).translate("amount_should_greater_than")} $minUserAmoubtPerTran",
          positiveButtonText: AppLocalizations.of(context).translate("ok"),
          onPositiveCallback: () {
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("own")){
              _focusNodeOwnAmount.requestFocus();
            }
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("saved")){
              _focusNodeSavedAmount.requestFocus();
            }
            if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("new")){
              _focusNodeNewAmount.requestFocus();
            }
          },
      );
    }
    else if(isTwoFactorEnabled! && fundTransferEntity.amount! > num.parse(twoFactorLimit!)){
      showAppDialog(
        title: AppLocalizations.of(context).translate("authentication_limit_exceeded"),
        alertType: AlertType.FAIL,
        message: AppLocalizations.of(context).translate("authentication_limit_exceeded_des"),
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () async {
          if (_isBiometricAvailable && _isAppBiometricAvailable) {
            await biometricHelper.authenticateWithBiometrics(context).then((success) {
              if (success==true) {
                bloc.add(RequestBiometricPrompt2FAEvent());
              } else {
                Navigator.pushNamed(
                    context, Routes.kFTEnterPasswordView,arguments: AppLocalizations.of(context).translate("fund_transfer")).then((value) {
                  if(value == true){
                    onTapConfirm();
                  }
                });
              }
            });
          }  else {
            Navigator.pushNamed(
                context, Routes.kFTEnterPasswordView,arguments: AppLocalizations.of(context).translate("fund_transfer")).then((value) {
              if(value == true){
                onTapConfirm();
              }
          
            });
          }

        },
      );
    }
    else if(isPayeeNotSelected == true && current == 1){
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_select_payee_next"), ToastStatus.ERROR);
    }
    else {
      onTapConfirm();
    }
  }

  unfocus() {
    _focusNodeAmount.unfocus();
    _focusNoderemarks.unfocus();
  }

  onTapConfirm() {
    fundTransferEntity.route = widget.requestMoneyValues?.route;
    if (current == 0 && scheduleIndex == 0) {
      fundTransferEntity.ftRouteType = FtRouteType.OWNNOW;
      setState(() {});
    } else if (current == 0 && scheduleIndex == 1) {
      fundTransferEntity.ftRouteType = FtRouteType.OWNLATER;
      setState(() {});
    } else if (current == 0 && scheduleIndex == 2) {
      fundTransferEntity.ftRouteType = FtRouteType.OWNRECUURING;
      setState(() {});
    } else if (current == 1 && scheduleIndex == 0) {
      fundTransferEntity.ftRouteType = FtRouteType.SAVEDNOW;
      setState(() {});
    } else if (current == 1 && scheduleIndex == 1) {
      fundTransferEntity.ftRouteType = FtRouteType.SAVEDLATER;
      setState(() {});
    } else if (current == 1 && scheduleIndex == 2) {
      fundTransferEntity.ftRouteType = FtRouteType.SAVEDRECURRING;
      setState(() {});
    } else if (current == 2 && scheduleIndex == 0) {
      fundTransferEntity.ftRouteType = FtRouteType.NEWNOW;
      setState(() {});
    } else if (current == 2 && scheduleIndex == 1) {
      fundTransferEntity.ftRouteType = FtRouteType.NEWLATER;
      setState(() {});
    } else if (current == 2 && scheduleIndex == 2) {
      fundTransferEntity.ftRouteType = FtRouteType.NEWRECURRING;
      setState(() {});
    }
    Navigator.pushNamed(context, Routes.kFundTransferNewReccurSummeryView,
        arguments: FundTransferArgs(fundTransferEntity));
  }

  String maskName(String input) {
    return input.replaceAllMapped(RegExp(r'[a-z]'), (match) => '*');
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
