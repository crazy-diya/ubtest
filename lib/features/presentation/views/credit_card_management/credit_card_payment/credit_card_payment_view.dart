import 'package:carousel_slider/carousel_controller.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/credit_card_payment/data/select_credit_card_view_args.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/credit_card_payment/widget/card_carousel_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/biometric_helper.dart';
import '../../../../../utils/model/bank_icons.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../../utils/text_editing_controllers.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../domain/entities/response/account_entity.dart';
import '../../../../domain/entities/response/fund_transfer_entity.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/carousel_widget/app_carousel_widget.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../widgets/credit_card_details_card.dart';
import '../widgets/credit_card_details_entity.dart';
import 'data/credit_card_entity.dart';
import 'data/credit_card_payment_args.dart';

class CreditCardPaymentView extends BaseView {
  final CreditCardPaymentArgs creditCardPaymentArgs;

  CreditCardPaymentView({required this.creditCardPaymentArgs});

  @override
  State<CreditCardPaymentView> createState() => _CreditCardPaymentViewState();
}

class _CreditCardPaymentViewState extends BaseViewState<CreditCardPaymentView> {
  final bloc = injection<CreditCardManagementBloc>();
  final _formKey = GlobalKey<FormState>();
  final localDataSource = injection<LocalDataSource>();
  final biometricHelper = injection<BiometricHelper>();
  bool _isBack = true;
  CurrencyTextEditingController amountControllerOwn = CurrencyTextEditingController();
  CurrencyTextEditingController amountControllerThirdParty = CurrencyTextEditingController();
  String? amount;
  TextEditingController remarkControllerOwn = TextEditingController();
  TextEditingController remarkControllerThirdParty = TextEditingController();
  String? remark;
  int carouselIndex = 0;
  TextEditingController holderNameController = TextEditingController();
  String? cardHolderNamePayTo;
  TextEditingController cardNumController = TextEditingController();
  String? cardNumPayTo;
  TextEditingController accountNumController = TextEditingController();
  String? accountNumber;
  String? _serviceCharge;
  bool isChangeAccount = false;
  CreditCardDetails? custDetails;
  List<AccountEntity> accountList = [];
  List<AccountEntity> accountListPortfolio = [];
  List<CreditCardDetailsCard> cardList = [];
  List<AccountEntity> accountListInstrument = [];
  int currentCarouselIndex = 0;
  String? nickName;
  String? maxUserAmountPerTran;
  String? maxDailyLimitPerTran;
  String? minUserAmoubtPerTran;
  String? maxGlobalLimitPerTran;
  String? twoFactorLimit;
  String? accountName;
  bool? isTwoFactorEnabled = false;
  String? avalBal;
  String? instrumentId;
  String? bankCode;
  bool isAmountAvailable = true;
  bool? isSelectedCreditCard = false;
  bool? isCreditCardNotSelected = false;
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  LoginMethods _loginMethod = LoginMethods.NONE;

  CreditCardDetailsCard? payToCreditCard;
  CarouselSliderController cardListCarousalController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>initialBiometric());
    cardList = widget.creditCardPaymentArgs.itemList;
    bloc.add(GetPortfolioAccDetailsCreditCardEvent());
    if (widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
      bloc.add(GetCardDetailsEvent(
          maskedPrimaryCardNumber: widget.creditCardPaymentArgs.itemList[0].maskedCardNumber
      ));
    }
    // if (widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
    //   maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.maxUserAmountPerDay;
    //   maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.maxGlobalLimitPerTran;
    //   maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.maxUserAmountPerTran;
    //   twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.twoFactorLimit;
    //   minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.minUserAmountPerTran;
    //   isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.enabledTwoFactorLimit;
    //
    //   _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOWNUB").first.serviceCharge;
    // }
    // if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.THIRDPARTY){
    //   maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.maxUserAmountPerDay;
    //   maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.maxGlobalLimitPerTran;
    //   maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.maxUserAmountPerTran;
    //   twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.twoFactorLimit;
    //   minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.minUserAmountPerTran;
    //   isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.enabledTwoFactorLimit;
    //
    //   _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="CRDOTHERBANK").first.serviceCharge;
    // }
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
        onPopInvoked: ()async{
          if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
            if (_formKey.currentState?.validate() == true || remarkControllerOwn.text.isNotEmpty)
            // if((amountControllerOwn.text == 0.00 || amountControllerOwn.text == 0.0) || remarkControllerOwn.text.isNotEmpty)
            {
              showAppDialog(
                  title: AppLocalizations.of(context).translate("cancel_the_transaction"),
                  alertType: AlertType.TRANSFER,
                  message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                      Routes.kHomeBaseView, (route) => false,
                    );
                  },
                  negativeButtonText:
                  AppLocalizations.of(context).translate("no"),
                  onNegativeCallback: () {});
            } else {
              Navigator.pop(context);
            }
          }
          else if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.THIRDPARTY){
            if(cardNumController.text.isNotEmpty || holderNameController.text.isNotEmpty
                || amountControllerThirdParty.text != "0.00"  || remarkControllerThirdParty.text.isNotEmpty
            ){
              showAppDialog(
                  title: AppLocalizations.of(context).translate("cancel_the_transaction"),
                  alertType: AlertType.TRANSFER,
                  message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                      Routes.kHomeBaseView, (route) => false,
                    );
                  },
                  negativeButtonText:
                  AppLocalizations.of(context).translate("no"),
                  onNegativeCallback: () {});
            } else {
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
          return true;
        },
        child: Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("credit_card_payment"),
        goBackEnabled: true,
        onBackPressed: (){
          if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
            if (_formKey.currentState?.validate() == true || remarkControllerOwn.text.isNotEmpty)
            // if((amountControllerOwn.text == 0.00 || amountControllerOwn.text == 0.0) || remarkControllerOwn.text.isNotEmpty)
            {
              showAppDialog(
                  title: AppLocalizations.of(context).translate("cancel_the_transaction"),
                  alertType: AlertType.TRANSFER,
                  message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                      Routes.kHomeBaseView, (route) => false,
                    );
                  },
                  negativeButtonText:
                  AppLocalizations.of(context).translate("no"),
                  onNegativeCallback: () {});
            } else {
              Navigator.pop(context);
            }
          }
          else if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.THIRDPARTY){
            if(cardNumController.text.isNotEmpty || holderNameController.text.isNotEmpty
            || amountControllerThirdParty.text != "0.00" || remarkControllerThirdParty.text.isNotEmpty
            ){
              showAppDialog(
                  title: AppLocalizations.of(context).translate("cancel_the_transaction"),
                  alertType: AlertType.TRANSFER,
                  message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                      Routes.kHomeBaseView, (route) => false,
                    );
                  },
                  negativeButtonText:
                  AppLocalizations.of(context).translate("no"),
                  onNegativeCallback: () {});
            }else {
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
      body: BlocProvider<CreditCardManagementBloc>(
        create: (_) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          listener: (context, state) {
            if (state is PortfolioAccountDetailsCreditCardFailState) {
              showAppDialog(
                title: AppLocalizations.of(context).translate("something_went_wrong"),
                alertType: AlertType.FAIL,
                message: AppLocalizations.of(context).translate("connection_could_not_be_made"),
                positiveButtonText: AppLocalizations.of(context).translate("ok"),
                onPositiveCallback: () {
                  Navigator.pop(context);
                },
              );
            }
            if (state is PortfolioAccountDetailsCreditCardSuccessState) {
              if (state.accDetails?.accountDetailsResponseDtos?.length != 0 &&
                  state.accDetails?.accountDetailsResponseDtos != null) {
                accountListPortfolio.clear();
                accountListPortfolio.addAll(state
                        .accDetails!.accountDetailsResponseDtos!
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
                                          AppConstants.ubBankCode.toString()),
                                  orElse: () => BankIcon(),
                                )
                                .icon,
                            nickName: e.nickName ?? "",
                            availableBalance:
                                double.parse(e.availableBalance ?? "0.00"),
                            accountType: e.accountType,
                            isPrimary: true,
                            cfprcd: e.cfprcd,
                            currency: e.cfcurr.toString().trim(),))
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
                accountList = accountList.unique((x) => x.accountNumber);

                accountList = accountList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                bloc.add(GetUserInstrumentForCardEvent(
                  requestType: RequestTypes.ACTIVE.name,
                ));
              }
              nickName = accountList[0].nickName ?? '';
              accountNumber = accountList[0].accountNumber ?? '';
              avalBal = accountList[0].availableBalance.toString();
              instrumentId = accountList[0].instrumentId.toString();
              bankCode = accountList[0].bankCode;
              setState(() {});
            }
            if(state is GetUserInstrumentForCardSuccessState){
              if(state.getUserInstList?.length!=0 && state.getUserInstList!=null){
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
                )).toList());
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
                accountList = accountList.unique((x) => x.accountNumber);
                nickName = accountList[0].nickName ?? '';
                accountNumber = accountList[0].accountNumber ?? '';
                avalBal = accountList[0].availableBalance.toString();
                instrumentId = accountList[0].instrumentId.toString();
                bankCode = accountList[0].bankCode;
                setState(() {});
              }
            }
            if(state is GetCardDetailsSuccessState){
              if(state.resCode == "00"){
                custDetails = CreditCardDetails(
                    creditLimit: state.cardDetailsResponse?.resCreditLimit,
                    availableToSpentAmount: state.cardDetailsResponse?.resAvailableBalance,
                    lastPaymentAmount: state.cardDetailsResponse?.resLastPaymentRecived,
                    lastPaymentDate: state.cardDetailsResponse?.resLastPaymentRecivedDate,
                    pendingAuthorizationAmount: state.cardDetailsResponse?.resPendingAuth.toString(),
                    installmentPayableBalance: state.cardDetailsResponse?.resInstPayableBalance.toString(),
                    statementBalance: state.cardDetailsResponse?.resStatmentBalance,
                    minimumPaymentDue: state.cardDetailsResponse?.resStmtMinAmtDue,
                    paymentDueDate: state.cardDetailsResponse?.resStmtPymtDueDate.toString(),
                    statementDate: state.cardDetailsResponse?.resStmtDate,
                    totalLoyaltyPoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints,
                    resAddonDetails: state.cardDetailsResponse?.resAddonDetails
                );
                // tempSelectedCreditCard = CreditCardMngmtRequestEntity(
                //   title: selectedCardDetails?.resCardTypeWithDesc ?? "",
                //   cardNo: selectedCardDetails
                //       ?.resMaskedPrimaryCardNumber ?? "",
                //   availablePoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints??"",
                //   pointsAboutToExpire: state.cardDetailsResponse?.resPointsToBeExpire??"",
                // );
              }
              if(state.resCode != "00") {
                showAppDialog(
                  title: AppLocalizations.of(context).translate("fail"),
                  alertType: AlertType.FAIL,
                  message: state.resDescription ?? AppLocalizations.of(context).translate("fail"),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {},
                );
              }
              setState(() {

              });
            }
            if(state is BiometricPromptFor2FACardSuccessState){
              onTapConfirm();
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                24.h,
                20.w,
                20.w,
                20.h + AppSizer.getHomeIndicatorStatus(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Text(
                              AppLocalizations.of(context)
                                  .translate('Pay_From'),
                              style: size14weight700.copyWith(
                                  color: colors(context).blackColor)),
                          16.verticalSpace,
                          AppCarouselWidget(
                            isSavedPayee: false,
                            accountList: accountList,
                            onPageChanged: (index, reason) {
                              setState(() {
                                isChangeAccount = true;
                                currentCarouselIndex = index;
                                final selectedItem = accountList[currentCarouselIndex];
                                nickName = selectedItem.nickName ?? '';
                                accountNumber = selectedItem.accountNumber ?? '';
                                avalBal = selectedItem.availableBalance.toString();
                                instrumentId = selectedItem.instrumentId.toString();
                                bankCode = selectedItem.bankCode;
                                // creditCardEntity.availableBalance =
                                //     cardList[index].availableBalance;
                                // creditCardEntity.bankCodePayFrom =
                                //     int.parse(accountList[index].bankCode!);
                                // if (amount != "0") {
                                //   if ((double.parse(amount!) >
                                //           creditCardEntity.availableBalance!
                                //               .toInt()) &&
                                //       (creditCardEntity.bankCodePayFrom ==
                                //           AppConstants.ubBankCode)) {
                                //     setState(() {
                                //       isAmountAvailable = false;
                                //     });
                                //   } else {
                                //     setState(() {
                                //       isAmountAvailable = true;
                                //     });
                                //   }
                                // }
                              });
                            },
                          ),
                          16.verticalSpace,

                          ///own account credit card payment
                          if (widget.creditCardPaymentArgs
                                  .creditCardPaymentType ==
                              CreditCardPaymentType.OWN)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)
                                        .translate('select_your_credit_card'),
                                    style: size14weight700.copyWith(
                                        color: colors(context).blackColor)),
                                16.verticalSpace,
                                CardCarouselWidget(
                                  carouselController:
                                      cardListCarousalController,
                                  onPageInSelectCreditCard: (value) {
                                    setState(() {
                                      isCreditCardNotSelected = value;
                                    });
                                  },
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      payToCreditCard = cardList[index];
                                      carouselIndex = index;
                                    });
                                    bloc.add(GetCardDetailsEvent(
                                        maskedPrimaryCardNumber: cardList[index].maskedCardNumber
                                    ));
                                  },
                                  onTap: () async {
                                    setState(() {
                                      cardList = widget.creditCardPaymentArgs.itemList;
                                    });
                                    await Navigator.pushNamed(
                                        context, Routes.kSelectCreditCardView,
                                        arguments: SelectCreditCardViewArgs(
                                          cardList: widget.creditCardPaymentArgs.itemList,
                                        )).then((value) {
                                      if (value != null &&
                                          value is CreditCardDetailsCard) {
                                        setState(() {
                                          payToCreditCard = value;
                                          isSelectedCreditCard = true;
                                          isCreditCardNotSelected = false;
                                          bloc.add(GetCardDetailsEvent(
                                              maskedPrimaryCardNumber: payToCreditCard?.maskedCardNumber
                                          ));
                                          cardList = [];
                                          cardList.add(value);
                                          cardListCarousalController
                                              .jumpToPage(0);
                                        });
                                      }
                                    });
                                  },
                                  cardList: cardList,
                                  isSelectedCreditCard: ValueNotifier(
                                      isSelectedCreditCard ?? true),
                                  creditCardsLength: (cardList.length) <= 3
                                      ? (cardList.length) + 1
                                      : 4,
                                ),
                                16.verticalSpace,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 0, 16, 0)
                                            .w,
                                    child: Column(
                                      children: [
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("last_statement_due"),
                                          amount: custDetails?.statementBalance == null || custDetails?.statementBalance == "" ? 0.00 :
                                          double.parse(custDetails?.statementBalance ?? "0.0"),
                                          // custDetails.statementBalance,
                                          isCurrency: true,
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("minimum_payment_due"),
                                          isCurrency: true,
                                          amount: custDetails?.minimumPaymentDue == null || custDetails?.minimumPaymentDue == "" ? 0.00 :
                                          double.parse(custDetails?.minimumPaymentDue ?? "0.0"),
                                          // custDetails.minimumPaymentDue,
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context)
                                              .translate("current_outstanding"),
                                          amount: cardList[carouselIndex].availableBalance == null || cardList[carouselIndex].availableBalance =="" ? 0.00 :
                                          double.parse(cardList[carouselIndex].availableBalance ?? "0.0"),
                                          isCurrency: true,
                                          isLastItem: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                InkWell(
                                  onTap: () async {
                                    getTxnLimits();
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
                                            StatefulBuilder(builder:
                                                (context, changeState) {
                                              return BottomSheetBuilder(
                                                title: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'transaction_limits'),
                                                isTwoButton: true,
                                                children: [
                                                  FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "max_per_tran_limit"),
                                                    amount: double.parse(maxUserAmountPerTran ?? "0.00"),
                                                    isCurrency: true,
                                                  ),
                                                  FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "maximum_daily_limit"),
                                                    amount: double.parse(maxDailyLimitPerTran ?? "0.00"),
                                                    isLastItem: isTwoFactorEnabled == false ? true : false,
                                                    isCurrency: true,
                                                  ),
                                                  if(isTwoFactorEnabled == true)
                                                    FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "two_factor_authentication"),
                                                    amount: double.parse(twoFactorLimit ?? "0.00"),
                                                    isCurrency: true,
                                                    isLastItem: true,
                                                  ),
                                                ],
                                              );
                                            }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 14)
                                            .w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            PhosphorIcon(
                                                PhosphorIcons.coins(
                                                    PhosphorIconsStyle.bold),
                                                color: colors(context)
                                                    .primaryColor),
                                            8.horizontalSpace,
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'show_transaction_limits'),
                                              style: size14weight700.copyWith(
                                                  color: colors(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16).w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextField(
                                          shouldRedirectToNextField: false,
                                          hint: AppLocalizations.of(context)
                                              .translate("amount"),
                                          title: AppLocalizations.of(context)
                                              .translate("amount"),
                                          isCurrency: true,
                                          maxLength: 15,
                                          inputType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          showCurrencySymbol: true,
                                          onTextChanged: (value) {
                                            setState(() {
                                              amount = value.replaceAll(",", "");
                                            });
                                          },
                                          validator: (value) {
                                            if (amountControllerOwn.text.isEmpty ||
                                                amountControllerOwn.text ==
                                                    "0.00") {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg");
                                            } else if (num.parse(avalBal!) <
                                                num.parse(amountControllerThirdParty.text.replaceAll(",", "")) && bankCode == AppConstants.ubBankCode) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "this_amount_not_available");
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: amountControllerOwn,
                                          isInfoIconVisible: false,
                                        ),
                                        24.verticalSpace,
                                        AppTextField(
                                          hint: AppLocalizations.of(context)
                                              .translate("enter_remarks"),
                                          title: AppLocalizations.of(context)
                                              .translate("remark_optional"),
                                          maxLength: 30,
                                          onTextChanged: (value) {
                                            setState(() {
                                              remark = value;
                                              // _isBack = _isEnableBack();
                                            });
                                          },
                                          maxLines: 1,
                                          controller: remarkControllerOwn,
                                          isInfoIconVisible: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AppSizer.verticalSpacing(
                                    AppSizer.getHomeIndicatorStatus(context)),
                              ],
                            ),

                          ///third party credit card payment
                          if (widget.creditCardPaymentArgs
                                  .creditCardPaymentType ==
                              CreditCardPaymentType.THIRDPARTY)
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16).w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextField(
                                          hint: AppLocalizations.of(context)
                                              .translate(
                                                  "enter_credit_card_account_number"),
                                          title: AppLocalizations.of(context)
                                              .translate(
                                                  "to_credit_card_account_number"),
                                          maxLength: 30,
                                          inputType: TextInputType.number,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9]")),
                                          ],
                                          onTextChanged: (value) {
                                            setState(() {
                                              cardNumPayTo = value;
                                              // _isBack = _isEnableBack();
                                            });
                                          },
                                          maxLines: 1,
                                          controller: cardNumController,
                                          isInfoIconVisible: false,
                                          validator: (val) {
                                            if (cardNumController
                                                    .text.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg");
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        24.verticalSpace,
                                        AppTextField(
                                          hint: AppLocalizations.of(context)
                                              .translate(
                                                  "enter_cardholders_name"),
                                          title: AppLocalizations.of(context)
                                              .translate("card_holders_name"),
                                          maxLength: 30,
                                          onTextChanged: (value) {
                                            setState(() {
                                              cardHolderNamePayTo = value;
                                              // _isBack = _isEnableBack();
                                            });
                                          },
                                          inputType: TextInputType.text,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[A-Z a-z ]")),
                                          ],
                                          validator: (val) {
                                            if (holderNameController
                                                    .text.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg");
                                            } else {
                                              return null;
                                            }
                                          },
                                          maxLines: 1,
                                          controller: holderNameController,
                                          isInfoIconVisible: false,
                                        ),
                                        24.verticalSpace,
                                        AppTextField(
                                          hint: AppLocalizations.of(context)
                                              .translate("amount"),
                                          title: AppLocalizations.of(context)
                                              .translate("amount"),
                                          isCurrency: true,
                                          maxLength: 15,
                                          inputType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          showCurrencySymbol: true,
                                          onTextChanged: (value) {
                                            setState(() {
                                              amount = value.replaceAll(",", "");
                                              //   _isBack = _isEnableBack();
                                            });
                                          },
                                          validator: (value) {
                                            if (amountControllerThirdParty.text.isEmpty ||
                                                amountControllerThirdParty.text ==
                                                    "0.00") {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg");
                                            } else if (num.parse(avalBal!) < num.parse(amountControllerThirdParty.text.replaceAll(",", "")) && bankCode == AppConstants.ubBankCode) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "this_amount_not_available");
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: amountControllerThirdParty,
                                          isInfoIconVisible: false,
                                        ),
                                        24.verticalSpace,
                                        AppTextField(
                                          hint: AppLocalizations.of(context)
                                              .translate("enter_remarks"),
                                          title: AppLocalizations.of(context)
                                              .translate("remark_optional"),
                                          maxLength: 30,
                                          onTextChanged: (value) {
                                            setState(() {
                                              // remark = value;
                                              // _isBack = _isEnableBack();
                                            });
                                          },
                                          maxLines: 1,
                                          controller: remarkControllerThirdParty,
                                          isInfoIconVisible: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    getTxnLimits();
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
                                            StatefulBuilder(builder:
                                                (context, changeState) {
                                              return BottomSheetBuilder(
                                                title: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'transaction_limits'),
                                                isTwoButton: true,
                                                children: [
                                                  FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "max_per_tran_limit"),
                                                    amount: double.parse(maxUserAmountPerTran ?? "0.00"),
                                                    isCurrency: true,
                                                  ),
                                                  FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "maximum_daily_limit"),
                                                    amount: double.parse(maxDailyLimitPerTran ?? "0.00"),
                                                    isCurrency: true,
                                                    isLastItem: isTwoFactorEnabled == false ? true : false,
                                                  ),
                                                  if(isTwoFactorEnabled == true)
                                                    FTSummeryDataComponent(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "two_factor_authentication"),
                                                    amount: double.parse(twoFactorLimit ?? "0.00"),
                                                    isCurrency: true,
                                                    isLastItem: true,
                                                  ),
                                                ],
                                              );
                                            }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 14)
                                            .w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            PhosphorIcon(
                                                PhosphorIcons.coins(
                                                    PhosphorIconsStyle.bold),
                                                color: colors(context)
                                                    .primaryColor),
                                            8.horizontalSpace,
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'show_transaction_limits'),
                                              style: size14weight700.copyWith(
                                                  color: colors(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Column(
                    children: [
                      AppButton(
                          buttonText: AppLocalizations.of(context).translate("pay"),
                          onTapButton: () {
                            getTxnLimits();
                            if (_formKey.currentState?.validate() == true) {
                              if ((double.parse(amount!).toInt() > num.parse(avalBal!)) && bankCode == AppConstants.ubBankCode
                              ) {
                                setState(() {
                                  isAmountAvailable = false;
                                });
                              } else {
                                setState(() {
                                  isAmountAvailable = true;
                                });
                              }
                              _onTap();
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

_onTap(){
  if (isAmountAvailable == false){
    showAppDialog(
      title: AppLocalizations.of(context).translate("insufficient_balance_of_Account"),
      alertType: AlertType.MONEY2,
      message: AppLocalizations.of(context).translate("not_sufficient_bal_des"),
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () {},
    );
  }
  else if(double.parse(amount!) > num.parse(maxDailyLimitPerTran!)){
    showAppDialog(
      title: AppLocalizations.of(context).translate("type_wise_limit"),
      alertType: AlertType.FAIL,
      message: "${"${AppLocalizations.of(context).translate("type_wise_limit_des_1")}" "${amount.toString().withThousandSeparator()}"
          "${AppLocalizations.of(context).translate("type_wise_limit_des")}"
      }",
      positiveButtonText: AppLocalizations.of(context).translate("try_again"),
      onPositiveCallback: () {
      },
    );
  }
  else if(double.parse(amount!) > num.parse(maxGlobalLimitPerTran!)){
    showAppDialog(
      title: AppLocalizations.of(context).translate("type_wise_limit"),
      alertType: AlertType.FAIL,
      message: "${"${AppLocalizations.of(context).translate("type_wise_limit_des_1")}" "${amount.toString().withThousandSeparator()}"
          "${AppLocalizations.of(context).translate("type_wise_limit_des")}"
        }",
      positiveButtonText: AppLocalizations.of(context).translate("try_again"),
      onPositiveCallback: () {
      },
    );
  }
  else if (double.parse(amount!) > num.parse(maxUserAmountPerTran!)) {
    showAppDialog(
        title: AppLocalizations.of(context).translate("type_wise_limit"),
        alertType: AlertType.FAIL,
        message: "${AppLocalizations.of(context).translate("type_wise_limit_des_1")}${amount.toString().withThousandSeparator()}${AppLocalizations.of(context).translate("type_wise_limit_des_2")}",
        positiveButtonText: AppLocalizations.of(context).translate("change_the_amount"),
        onPositiveCallback: () {
          // if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("own")){
          //   _focusNodeOwnAmount.requestFocus();
          // }
        },
        bottomButtonText: AppLocalizations.of(context).translate("amend_transaction_limit"),
        onBottomButtonCallback: (){
          Navigator.pushNamed(context, Routes.kTransactionListView);
        }
    );
  }
  else if(isTwoFactorEnabled! && double.parse(amount!) > num.parse(twoFactorLimit!)){
    showAppDialog(
      title: "2FA Limit was Exceeded",
      // AppLocalizations.of(context).translate("2fa_limit_exceeded_title"),
      alertType: AlertType.FAIL,
      message: AppLocalizations.of(context).translate("authentication_limit_exceeded_des"),
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () async {
        if (_isBiometricAvailable && _isAppBiometricAvailable) {
          await biometricHelper.authenticateWithBiometrics(context).then((success) {
            if (success==true) {
              bloc.add(RequestBiometricPrompt2FACardEvent());
            } else {
              Navigator.pushNamed(
                  context, Routes.kFTEnterPasswordView,arguments: AppLocalizations.of(context).translate("credit_card_payment")).then((value) {
                if(value == true){
                  onTapConfirm();
                }
              });
            }
          });
        }  else {
          Navigator.pushNamed(
              context, Routes.kFTEnterPasswordView,arguments: AppLocalizations.of(context).translate("credit_card_payment")).then((value) {
            if(value == true){
              onTapConfirm();
            }

          });
        }

      },
    );
  }
  else if(double.parse(amount!) < num.parse(minUserAmoubtPerTran!)){
    showAppDialog(
      title: AppLocalizations.of(context).translate("invalid_amount"),
      alertType: AlertType.FAIL,
      message: "${AppLocalizations.of(context).translate("amount_should_greater_than")} $minUserAmoubtPerTran",
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      onPositiveCallback: () {

      },
    );
  }
  else{
    onTapConfirm();
  }
}

  onTapConfirm(){
    if (widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN) {
      Navigator.pushNamed(context,
          Routes.kCreditCardPaymentSummaryView,
          arguments: CreditCardPaymentArgs(
              creditCardPaymentType: widget
                  .creditCardPaymentArgs
                  .creditCardPaymentType,
              amount: amountControllerOwn.text,
              remark: remarkControllerOwn.text,
              itemList: widget.creditCardPaymentArgs.itemList,
              bankCode: bankCode,
              payFrom: FundTransferEntity(
                  payFromName: nickName,
                  payFromNum: accountNumber,
                  instrumentId: int.parse(instrumentId ?? "1"),
                  serviceCharge: double.parse(_serviceCharge ?? "0.00")
              ),
              payTo: CreditCardEntity(
                  isUBAccount: true,
                  cardNumber: cardList[carouselIndex].maskedCardNumber,
                  nickName: cardList[carouselIndex].creditCardName,
                  accountNumber: cardList[carouselIndex].accountNumber
              )
          ));
    }
    else if (widget.creditCardPaymentArgs.creditCardPaymentType ==
        CreditCardPaymentType.THIRDPARTY) {
      Navigator.pushNamed(context,
          Routes.kCreditCardPaymentSummaryView,
          arguments: CreditCardPaymentArgs(
              itemList: widget.creditCardPaymentArgs.itemList,
              creditCardPaymentType: widget
                  .creditCardPaymentArgs
                  .creditCardPaymentType,
              remark: remarkControllerThirdParty.text,
              amount: amountControllerThirdParty.text,
              bankCode: bankCode,
              payFrom: FundTransferEntity(
                  payFromName: nickName,
                  payFromNum: accountNumber,
                  instrumentId: int.parse(instrumentId ?? "1"),
                  serviceCharge: double.parse(_serviceCharge ?? "0.00")
              ),
              payTo: CreditCardEntity(
                  isUBAccount: true,
                  cardNumber: cardNumController.text,
                  nickName: holderNameController.text,
                  accountNumber: cardNumController.text
              )));
    }
  }

  getTxnLimits(){
    if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
      if (bankCode == AppConstants.ubBankCode.toString()){
        maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.maxUserAmountPerDay;
        maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.maxUserAmountPerTran;
        twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.twoFactorLimit;
        minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.minUserAmountPerTran;
        isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.enabledTwoFactorLimit;

        _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="OWNUBCC").first.serviceCharge;
        setState(() {});
      } else {
        maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxUserAmountPerDay;
        maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxUserAmountPerTran;
        twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.twoFactorLimit;
        minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.minUserAmountPerTran;
        isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.enabledTwoFactorLimit;

        _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.serviceCharge;
        setState(() {});
      }
    } else {
      if (bankCode == AppConstants.ubBankCode.toString()){
        maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.maxUserAmountPerDay;
        maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.maxUserAmountPerTran;
        twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.twoFactorLimit;
        minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.minUserAmountPerTran;
        isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.enabledTwoFactorLimit;

        _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="WITHINUBCC").first.serviceCharge;
        setState(() {});
      } else {
        maxDailyLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxUserAmountPerDay;
        maxGlobalLimitPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.maxUserAmountPerTran;
        twoFactorLimit = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.twoFactorLimit;
        minUserAmoubtPerTran = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.minUserAmountPerTran;
        isTwoFactorEnabled = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.enabledTwoFactorLimit;

        _serviceCharge = localDataSource.getTxnLimits()?.where((e) => e.transactionType=="JPCC").first.serviceCharge;
        setState(() {});
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
