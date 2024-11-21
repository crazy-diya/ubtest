// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/fund_transfer_new_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/carousel_widget/app_carousel_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/ft_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/app_validator.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/text_editing_controllers.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../base_view.dart';
import 'bill_payment_summary_view.dart';

class BillPaymentViewArgs {
  final BillerCategoryEntity? billerCategoryEntity;
  final CustomFieldEntity? customFieldEntity;
  final BillerEntity? billerEntity;
  final SavedBillerEntity? savedBillerEntity;
  final bool? isSaved;
  final double? chargeAmount;
  final int? serviceProviderId;
  final String? referenceSample;
  final String? referencePattern;
  final String route;

  BillPaymentViewArgs({
    this.billerCategoryEntity,
    this.customFieldEntity,
    this.billerEntity,
    this.savedBillerEntity,
    this.isSaved = false,
    this.chargeAmount,
    this.serviceProviderId,
    this.referenceSample,
    this.referencePattern,
    required this.route,
  });
}

class BillPaymentProcessView extends BaseView {
  final BillPaymentViewArgs billPaymentViewArgs;

  BillPaymentProcessView({required this.billPaymentViewArgs});

  @override
  _BillPaymentProcessViewState createState() => _BillPaymentProcessViewState();
}

class _BillPaymentProcessViewState
    extends BaseViewState<BillPaymentProcessView> {
  var _bloc = injection<AccountBloc>();
  final localDataSource = injection<LocalDataSource>();
  final biometricHelper = injection<BiometricHelper>();
  List<AccountEntity> accountList = [];
  List<AccountEntity> accountListPortfolio = [];
  List<AccountEntity> accountListInstrument = [];
  final fundTransferEntity = FundTransferEntity();

  bool startDateSelected = false;

  String? frequency = "daily";
  String? tempFrequency  = "daily";

  String? payToNumber;
  TextEditingController mobileNumberController = TextEditingController();
  CurrencyTextEditingController amountController =
      CurrencyTextEditingController();
  TextEditingController remarkController = TextEditingController();
  String? remark;

  TextEditingController remarksController = TextEditingController();

  String? amount = "0";

  String? transactionDate;
  String? startDate;
  String? endDate;

  bool _isBack = true;
  int ownRecDays = 0;
  int currentCarouselIndex = 0;

  String? nickName;
  String? accountNumber;
  String? avalBal;

  String? instrumentId;

  bool isChangeAccount = false;
  double? serviceCharge = 0.00;
  late String regexPattern;
  String? maxUserAmountPerTran;
  String? maxGlobalLimitPerTran;
  String? twoFactorLimit;
  bool? isTwoFactorEnable = false;
  String? minUserAmoubtPerTran;

  //biometric for 2FA
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;

  LoginMethods _loginMethod = LoginMethods.NONE;

  bool isAmountAvailable = true;

  List<ScheduleType> scheduleTypes = [
    ScheduleType(description: "now", scheduleIndex: 0),
    ScheduleType(description: "later", scheduleIndex: 1),
    ScheduleType(description: "recurring", scheduleIndex: 2),
  ];

  String? scheduleTypeDescription = "now";
  // int? scheduleTypeIndex = 0;

  String? scheduleTempTypeDescription = "now";
  // int? scheduleTempTypeIndex = 0;

  @override
  void initState() {
    super.initState();

    _bloc.add(GetTranLimitForFTEvent());

    if (widget.billPaymentViewArgs.isSaved == true)
      mobileNumberController = TextEditingController(
          text: widget.billPaymentViewArgs.savedBillerEntity?.value);
    if (widget.billPaymentViewArgs.isSaved == true)
      payToNumber = widget.billPaymentViewArgs.savedBillerEntity?.value;
    _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => initialBiometric());
    regexPattern = widget.billPaymentViewArgs.referencePattern ?? "";
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        if (_isBack == false) {
          showAppDialog(
              title: AppLocalizations.of(context)
                  .translate("cancel_the_bill_payment_title"),
              message: AppLocalizations.of(context)
                  .translate("cancel_the_bill_payment_desk"),
              alertType: AlertType.DOCUMENT1,
              onPositiveCallback: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.kHomeBaseView,
                  (Route<dynamic> route) => false,
                );
              },
              negativeButtonText: AppLocalizations.of(context).translate("no"),
              positiveButtonText:
                  AppLocalizations.of(context).translate("yes,_cancel"));
        } else {
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("bill_payment"),
          onBackPressed: () {
            if (_isBack == false) {
              showAppDialog(
                  title: AppLocalizations.of(context)
                      .translate("cancel_the_bill_payment_title"),
                  message: AppLocalizations.of(context)
                      .translate("cancel_the_bill_payment_desk"),
                  alertType: AlertType.DOCUMENT1,
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeBaseView,
                      (Route<dynamic> route) => false,
                    );
                  },
                  negativeButtonText:
                      AppLocalizations.of(context).translate("no"),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("yes,_cancel"));
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: BlocProvider<AccountBloc>(
          create: (_) => _bloc,
          child: BlocListener<AccountBloc, BaseState<AccountState>>(
            listener: (_, state) {
              if (state is PortfolioAccountDetailsSuccessState) {
                if (state.accDetails?.accountDetailsResponseDtos?.length != 0 &&
                    state.accDetails?.accountDetailsResponseDtos != null) {
                  accountListPortfolio.clear();
                  accountListPortfolio
                      .addAll(state.accDetails!.accountDetailsResponseDtos!
                          .map((e) => AccountEntity(
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
                                status: e.status,
                                instrumentId: e.instrumentId,
                                bankName: e.bankName,
                                bankCode: e.bankCode ??
                                    AppConstants.ubBankCode.toString(),
                                accountNumber: e.accountNumber,
                                nickName: e.nickName ?? "",
                                availableBalance:
                                    double.parse(e.availableBalance ?? "0.00"),
                                accountType: e.accountType,
                                isPrimary: false,
                                cfprcd: e.cfprcd,
                                currency: e.cfcurr.toString().trim(),
                              ))
                          .toList());
                  accountListPortfolio.removeWhere((e)=>e.currency?.trim()!="LKR");
                  accountListPortfolio = accountListPortfolio
                      .where((element) =>
                          (element.accountType == "S" &&
                              element.status?.toUpperCase() == "ACTIVE") ||
                          (element.accountType == "D" &&
                              element.status?.toUpperCase() == "ACTIVE"))
                      .toList();

                  accountList.addAll(accountListPortfolio);
                  // accountListForPayTo.addAll(accountListPortfolio);
                  // accountListForPayTo =
                  //     accountListForPayTo.unique((x) => x.accountNumber);
                   accountList = accountList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                  accountList = accountList.unique((x) => x.accountNumber);

                  if (currentCarouselIndex == 0) {
                    fundTransferEntity.availableBalance =
                        accountList[0].availableBalance;
                    fundTransferEntity.bankCodePayFrom =
                        int.parse(accountList[0].bankCode!);
                  }
                  //   fundTransferEntity.payFromNum =
                  //       accountList[0].accountNumber;
                  //   fundTransferEntity.payFromName = accountList[0].nickName;
                  //   fundTransferEntity.bankCodePayFrom = int.parse(accountList[0].bankCode!);
                  //   fundTransferEntity.instrumentId = accountList[0].instrumentId;
                  // }

                  // if(accountListForPayTo.length > 1){
                  //   accountListForPayTo.removeAt(currentIndex);
                  //   if (currentIndexforPayto == 0 && current == 0) {
                  //     fundTransferEntity.payToacctnmbr = accountListForPayTo[0].accountNumber;
                  //     fundTransferEntity.payToacctname = accountListForPayTo[0].nickName;
                  //     fundTransferEntity.bankName = accountListForPayTo[0].bankName;
                  //     fundTransferEntity.bankCode = int.parse(accountListForPayTo[0].bankCode!);
                  //     fundTransferEntity.instrumentId = accountListForPayTo[0].instrumentId;
                  //   }
                  // }
                }
                _bloc.add(GetUserInstrumentEvent(
                  requestType: RequestTypes.ACTIVE.name,
                ));
              }
              else if (state is GetUserInstrumentSuccessState) {
                if (state.getUserInstList?.length != 0 &&
                    state.getUserInstList != null) {
                  setState(() {
                    accountListInstrument.clear();
                    accountListInstrument.addAll(state.getUserInstList!
                        .map((e) => AccountEntity(
                              icon: bankIcons
                                  .firstWhere(
                                    (element) =>
                                        element.bankCode ==
                                        (e.bankCode ??
                                            AppConstants.ubBankCode.toString()),
                                    orElse: () => BankIcon(),
                                  )
                                  .icon,
                              instrumentId: e.id,
                              bankName: e.bankName,
                              bankCode: e.bankCode,
                              accountNumber: e.accountNo,
                              nickName: e.nickName ?? "",
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
                    if (currentCarouselIndex == 0) {
                      fundTransferEntity.availableBalance =
                          accountList[0].availableBalance;
                      fundTransferEntity.bankCodePayFrom =
                          int.parse(accountList[0].bankCode!);
                    }
                  });
                }
                //  hideProgressBar();
              }
              else if (state is GetUserInstrumentFailedState) {
                //  hideProgressBar();
                showAppDialog(
                     title: AppLocalizations.of(context).translate("there_was_some_error"),
                      alertType: AlertType.FAIL,
                      message: state.message,
                      positiveButtonText:
                          AppLocalizations.of(context).translate("Try_Again"),
                    onPositiveCallback: () {
                      accountList.clear();
                      _bloc.add(GetPortfolioAccDetailsEvent());
                    },
                    negativeButtonText: "Go Back",
                    onNegativeCallback: () {
                      Navigator.of(context).pop();
                    });
              }
              else if (state is AccountDetailFailState) {
                _bloc.add(GetUserInstrumentEvent(
                  requestType: RequestTypes.ACTIVE.name,
                ));
              }
              else if (state is GetTransLimitForFTSuccessState) {
                _bloc.add(GetPortfolioAccDetailsEvent());
              }
              else if (state is GetTransLimitForFTFailedState) {
                // hideProgressBar();
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
              else if (state is BiometricPromptFor2FASuccessState) {
                onTapConfirm();
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  24.h,
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
                            Text("Pay To",
                                style: size14weight700.copyWith(
                                    color: colors(context).blackColor)),
                            16.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 65.w,
                                        height: 65.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8).r,
                                            border: Border.all(
                                                color: colors(context)
                                                    .greyColor300!)),
                                        child: widget
                                                    .billPaymentViewArgs
                                                    .billerEntity
                                                    ?.billerImage ==
                                                null
                                            ? Center(
                                                child: Text(
                                                  widget.billPaymentViewArgs
                                                              .isSaved ==
                                                          true
                                                      ? widget
                                                              .billPaymentViewArgs
                                                              .savedBillerEntity
                                                              ?.nickName
                                                              .toString()
                                                              .getNameInitial() ??
                                                          ""
                                                      : widget
                                                              .billPaymentViewArgs
                                                              .billerEntity
                                                              ?.billerName
                                                              ?.toString()
                                                              .getNameInitial() ??
                                                          "",
                                                  style:
                                                      size20weight700.copyWith(
                                                          color: colors(context)
                                                              .primaryColor),
                                                ),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: widget
                                                    .billPaymentViewArgs
                                                    .billerEntity!
                                                    .billerImage!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8).r,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    height: 20.w,
                                                    width: 20.w,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: colors(
                                                                    context)
                                                                .primaryColor),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        PhosphorIcon(
                                                  PhosphorIcons.warningCircle(
                                                      PhosphorIconsStyle.bold),
                                                ),
                                              )),
                                    24.horizontalSpace,
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  widget.billPaymentViewArgs
                                                              .isSaved ==
                                                          true
                                                      ? widget
                                                              .billPaymentViewArgs
                                                              .savedBillerEntity
                                                              ?.nickName ??
                                                          ""
                                                      : widget
                                                              .billPaymentViewArgs
                                                              .billerEntity
                                                              ?.billerName ??
                                                          "-",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: size16weight700.copyWith(
                                                      color: colors(context)
                                                          .blackColor),
                                                ),
                                                8.verticalSpace,
                                                Text(
                                                    widget.billPaymentViewArgs
                                                                .isSaved ==
                                                            true
                                                        ? widget
                                                                .billPaymentViewArgs
                                                                .savedBillerEntity
                                                                ?.value ??
                                                            ""
                                                        : widget
                                                                .billPaymentViewArgs
                                                                .billerCategoryEntity
                                                                ?.categoryName ??
                                                            "-",
                                                    overflow: TextOverflow.ellipsis,
                                                    style:
                                                        size14weight400.copyWith(
                                                            color: colors(context)
                                                                .blackColor))
                                              ],
                                            ),
                                          ),
                                          // const Spacer(),
                                          24.horizontalSpace,
                                          PhosphorIcon(
                                            PhosphorIcons.caretRight(
                                                PhosphorIconsStyle.bold),
                                            color: colors(context).greyColor300,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            16.verticalSpace,
                            Text("Pay From",
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
                                  final selectedItem =
                                      accountList[currentCarouselIndex];
                                  nickName = selectedItem.nickName ?? '';
                                  accountNumber =
                                      selectedItem.accountNumber ?? '';
                                  avalBal =
                                      selectedItem.availableBalance.toString();
                                  instrumentId =
                                      selectedItem.instrumentId.toString();
                                  fundTransferEntity.availableBalance =
                                      accountList[index].availableBalance;
                                  fundTransferEntity.bankCodePayFrom =
                                      int.parse(accountList[index].bankCode!);
                                  if (amount != "0") {
                                    if ((double.parse(amount!) >
                                            fundTransferEntity.availableBalance!
                                                .toInt()) &&
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
                                  }
                                });
                              },
                            ),
                            16.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (widget.billPaymentViewArgs.isSaved ==
                                        false)
                                      Column(
                                        children: [
                                          AppTextField(
                                            title: widget.billPaymentViewArgs
                                                    .referenceSample ??
                                                "",
                                            hint: widget.billPaymentViewArgs
                                                    .referenceSample ??
                                                "",
                                            inputType: AppValidator.isNumber(
                                                    regexPattern)
                                                ? TextInputType.number
                                                : TextInputType.text,
                                            onTextChanged: (value) {
                                              setState(() {
                                                payToNumber = value;
                                                _isBack = _isEnableBack();
                                              });
                                            },
                                            validator: (value) {
                                              RegExp regex =
                                                  AppValidator.isNumberRegex(
                                                      regexPattern);

                                              if (value == null ||
                                                  value == "") {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        "mandatory_field_msg");
                                              } else {
                                                if (regex.hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "invalid_format");
                                                }
                                              }
                                            },
                                            controller: mobileNumberController,
                                            isInfoIconVisible: false,
                                            inputFormatter: [],
                                          ),
                                          24.verticalSpace,
                                        ],
                                      ),
                                    AppTextField(
                                      hint: AppLocalizations.of(context)
                                          .translate("amount"),
                                      title: AppLocalizations.of(context)
                                          .translate("amount"),
                                      isCurrency: true,
                                      maxLength: 15,
                                      inputType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      showCurrencySymbol: true,
                                      onTextChanged: (value) {
                                        setState(() {
                                          amount = value.replaceAll(",", "");
                                          _isBack = _isEnableBack();
                                        });
                                        if ((double.parse(amount!).toInt() >
                                                fundTransferEntity
                                                    .availableBalance!
                                                    .toInt()) &&
                                            (fundTransferEntity
                                                    .bankCodePayFrom ==
                                                AppConstants.ubBankCode)) {
                                          setState(() {
                                            isAmountAvailable = false;
                                          });
                                        } else {
                                          setState(() {
                                            isAmountAvailable = true;
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if (amountController.text.isEmpty ||
                                            amountController.text == "0.00") {
                                          return AppLocalizations.of(context)
                                              .translate("mandatory_field_msg");
                                        } else if (isAmountAvailable == false) {
                                          return AppLocalizations.of(context)
                                              .translate(
                                                  "this_amount_not_available");
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: amountController,
                                      isInfoIconVisible: false,
                                    ),
                                    24.verticalSpace,
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 24, right: 24, bottom: 20),
                                    //   child: SizedBox(
                                    //     width: MediaQuery.of(context).size.width,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    // isNow = true;
                                    // isLater = false;
                                    // isRecurring = false;
                                    // transactionDate = null;
                                    // remark2 = null;
                                    // remark3 = null;
                                    // startDate = null;
                                    // endDate = null;
                                    // frequency = null;
                                    // startDateSelected = false;
                                    // ownRecDays = 0;
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //             //width: MediaQuery.of(context).size.width * 0.4,
                                    //             decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(8),
                                    //                 color: isNow == true
                                    //                     ? colors(context).secondaryColor
                                    //                     : Colors.transparent),
                                    //             padding: const EdgeInsets.all(12),
                                    //             child: Center(
                                    //               child: Text(
                                    //                 "Now",
                                    //                 style: TextStyle(
                                    //                     fontSize: 16,
                                    //                     fontWeight: FontWeight.w500,
                                    //                     color:
                                    //                         colors(context).blackColor),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    // isNow = false;
                                    // isLater = true;
                                    // isRecurring = false;
                                    // startDate = null;
                                    // endDate =  null;
                                    // transactionDate = null;
                                    // startDateSelected = false;
                                    // frequency = null;
                                    // remark3 = null;
                                    // remark = null;
                                    // ownRecDays = 0;
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //             //width: MediaQuery.of(context).size.width * 0.4,
                                    //             decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(8),
                                    //                 color: isNow == false &&
                                    //                         isRecurring == false
                                    //                     ? colors(context).secondaryColor
                                    //                     : Colors.transparent),
                                    //             padding: const EdgeInsets.all(12),
                                    //             child: Center(
                                    //               child: Text(
                                    //                 "Later",
                                    //                 style: TextStyle(
                                    //                     fontSize: 16,
                                    //                     fontWeight: FontWeight.w500,
                                    //                     color:
                                    //                         colors(context).blackColor),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               isNow = false;
                                    //               isLater = false;
                                    //               isRecurring = true;
                                    //               transactionDate = null;
                                    //               startDate = null;
                                    //               remark = null;
                                    //               remark2 = null;
                                    //               startDateSelected = false;
                                    //               ownRecDays = 0;
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //             //width: MediaQuery.of(context).size.width * 0.4,
                                    //             decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(8),
                                    //                 color: isNow == false &&
                                    //                         isLater == false
                                    //                     ? colors(context).secondaryColor
                                    //                     : Colors.transparent),
                                    //             padding: const EdgeInsets.all(12),
                                    //             child: Center(
                                    //               child: Text(
                                    //                 "Recurring",
                                    //                 style: TextStyle(
                                    //                     fontSize: 16,
                                    //                     fontWeight: FontWeight.w500,
                                    //                     color:
                                    //                         colors(context).blackColor),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    AppTextField(
                                      hint: AppLocalizations.of(context)
                                          .translate("enter_remarks"),
                                      title: AppLocalizations.of(context)
                                          .translate("remark_optional"),
                                      maxLength: 30,
                                      onTextChanged: (value) {
                                        setState(() {
                                          remark = value;
                                          _isBack = _isEnableBack();
                                        });
                                      },
                                      maxLines: 1,
                                      controller: remarkController,
                                      isInfoIconVisible: false,
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
                                      label: AppLocalizations.of(context)
                                          .translate("when"),
                                      labelText: AppLocalizations.of(context)
                                          .translate("schedule_type"),
                                      validator: (value) {
                                        if (scheduleTempTypeDescription ==
                                                null ||
                                            scheduleTempTypeDescription == "") {
                                          return AppLocalizations.of(context)
                                              .translate(
                                                  "mandatory_field_msg_selection");
                                        } else {
                                          return null;
                                        }
                                      },
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
                                                        title: AppLocalizations
                                                                .of(context)
                                                            .translate('when'),
                                                        buttons: [
                                                          Expanded(
                                                            child: AppButton(
                                                                buttonType:
                                                                    ButtonType
                                                                        .PRIMARYENABLED,
                                                                buttonText: AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "continue"),
                                                                onTapButton:
                                                                    () {
                                                                  scheduleTypeDescription =
                                                                      scheduleTempTypeDescription;
                                                                  // scheduleTypeIndex =
                                                                  //     scheduleTempTypeIndex;

                                                                  startDate =
                                                                      null;
                                                                  endDate =
                                                                      null;
                                                                  transactionDate =
                                                                      null;
                                                                  startDateSelected =
                                                                      false;
                                                                  frequency =
                                                                      "daily";
                                                                  ownRecDays =
                                                                      0;
                                                                  startDateSelected =
                                                                      false;
                                                                  tempFrequency =
                                                                      "daily";
                                                                  fundTransferEntity
                                                                          .scheduleFrequency =
                                                                      null;

                                                                  _formKey
                                                                      .currentState
                                                                      ?.reset();

                                                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);
                                                                  changeState(
                                                                      () {});
                                                                  setState(
                                                                      () {});
                                                                }),
                                                          ),
                                                        ],
                                                        children: [
                                                          ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                scheduleTypes
                                                                    .length,
                                                            shrinkWrap: true,
                                                            padding: EdgeInsets.zero,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  scheduleTempTypeDescription =
                                                                      scheduleTypes[
                                                                              index]
                                                                          .description;
                                                                  // scheduleTempTypeIndex =
                                                                  //     scheduleTypes[
                                                                  //             index]
                                                                  //         .scheduleIndex;
                                                                  changeState(
                                                                      () {});
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                              0, index == 0 ? 0 : 24.h, 0, 24.h),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(AppLocalizations.of(context).translate(scheduleTypes[index].description )
                                                                            ??
                                                                                "",
                                                                            style:
                                                                                size16weight700.copyWith(
                                                                              color: colors(context).blackColor,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.w),
                                                                            child:
                                                                                UBRadio<dynamic>(
                                                                              value: scheduleTypes[index].description,
                                                                              groupValue: scheduleTempTypeDescription,
                                                                              onChanged: (value) {
                                                                                scheduleTempTypeDescription = value!;
                                                                                // scheduleTempTypeIndex = value!.scheduleIndex;
                                                                                changeState(() {});
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    if (scheduleTypes.length -
                                                                            1 !=
                                                                        index)
                                                                      Divider(
                                                                        height:
                                                                            0,
                                                                        thickness:
                                                                            1,
                                                                        color: colors(context)
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
                                        setState(() {});
                                      },
                                      initialValue:AppLocalizations.of(context).translate( scheduleTypeDescription!),
                                    ),
                                    if (scheduleTypeDescription == "later")
                                      Column(
                                        children: [
                                          24.verticalSpace,
                                          FTDatePicker(
                                            title: AppLocalizations.of(context)
                                                .translate("transaction_date"),
                                            labelText: AppLocalizations.of(
                                                    context)
                                                .translate("transaction_date"),
                                            isStartDateSelected: true,
                                            firstDate: DateTime.now().add(
                                                Duration(days: ownRecDays + 1)),
                                            initialDate: DateTime.now().add(
                                                Duration(days: ownRecDays + 1)),
                                            text: transactionDate != null
                                                ? DateFormat('dd-MMM-yyyy')
                                                    .format(DateFormat(
                                                            'd MMMM yyyy')
                                                        .parse(
                                                            transactionDate!))
                                                : null,
                                            // DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(widget.fundTransferArgs.fundTransferEntity.endDate!)),
                                            onChange: (value) {
                                              transactionDate = value;
                                              _isBack = _isEnableBack();
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        "mandatory_field_msg_selection");
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    if (scheduleTypeDescription == "recurring")
                                      Column(children: [
                                        24.verticalSpace,
                                        FTDatePicker(
                                          title: AppLocalizations.of(context).translate("start_date"),
                                          isStartDateSelected: true,
                                          text: startDate != null ? DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(startDate!)) : null,
                                          initialDate: DateTime.now().add(const Duration(days: 1)),
                                          labelText: AppLocalizations.of(context).translate("start_date"),
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChange: (value) {
                                            startDate = value;
                                            _isBack = _isEnableBack();
                                            if (endDate != null) {
                                              setState(() {
                                                endDate = null;
                                              });
                                            }
                                            ownRecDays = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(startDate!)),).difference(DateTime.now()).inDays;
                                            if ((startDate != null || startDate == "")) {
                                              startDateSelected = true;
                                              setState(() {});
                                            } else {
                                              startDateSelected = false;
                                              setState(() {});
                                            }
                                          },
                                          firstDate: DateTime.now().add(const Duration(days: 1)),
                                        ),
                                        24.verticalSpace,
                                        FTDatePicker(
                                          title: AppLocalizations.of(context).translate("end_date"),
                                          isStartDateSelected: startDateSelected,
                                          text: endDate != null
                                              ? DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(endDate!))
                                              : null,
                                          initialDate: DateTime.now().add(Duration(days: ownRecDays + 2)),
                                          firstDate: DateTime.now().add(Duration(days: ownRecDays + 2)),
                                          labelText:
                                              AppLocalizations.of(context).translate("end_date"),
                                          validator: (value) {
                                            if (value == null || value == "" || endDate == null || endDate == "") {
                                              return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChange: (value) {
                                            endDate = value;
                                            _isBack = _isEnableBack();
                                          },
                                        ),
                                        24.verticalSpace,
                                        AppDropDown(
                                          validator: (value) {
                                            if (frequency == null ||
                                                frequency == "") {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg_selection");
                                            } else {
                                              return null;
                                            }
                                          },
                                          label: AppLocalizations.of(context)
                                              .translate("frequency"),
                                          labelText: AppLocalizations.of(
                                                  context)
                                              .translate("select_frequency"),
                                          onTap: () async {
                                            final result =
                                                await showModalBottomSheet<
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
                                                            (context,
                                                                changeState) {
                                                          return BottomSheetBuilder(
                                                            title: AppLocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    'select_frequency'),
                                                            buttons: [
                                                              Expanded(
                                                                child:
                                                                    AppButton(
                                                                        buttonType:
                                                                            ButtonType
                                                                                .PRIMARYENABLED,
                                                                        buttonText:
                                                                            AppLocalizations.of(context).translate(
                                                                                "continue"),
                                                                        onTapButton:
                                                                            () {
                                                                          frequency =
                                                                              tempFrequency;
                                                                          fundTransferEntity.scheduleFrequency =
                                                                              frequency;

                                                                              
                                                                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                          Navigator.of(context)
                                                                              .pop(true);
                                                                          changeState(
                                                                              () {});
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                              ),
                                                            ],
                                                            children: [
                                                              ListView.builder(
                                                                itemCount:
                                                                    AppConstants
                                                                        .kGetFTFrequencyList
                                                                        .length,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                    padding: EdgeInsets.zero,
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      tempFrequency = AppConstants
                                                                          .kGetFTFrequencyList[
                                                                              index]
                                                                          .description;
                                                                      changeState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.fromLTRB(0, index == 0 ? 0 : 24, 0, 24).h,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                               AppLocalizations.of(context).translate(AppConstants.kGetFTFrequencyList[index].description ?? ""),
                                                                                style: size16weight700.copyWith(
                                                                                  color: colors(context).blackColor,
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(right: 8.w),
                                                                                child: UBRadio<dynamic>(
                                                                                  value: AppConstants.kGetFTFrequencyList[index].description ?? "",
                                                                                  groupValue: tempFrequency,
                                                                                  onChanged: (value) {
                                                                                    tempFrequency = AppConstants.kGetFTFrequencyList[index].description;
                                                                                    changeState(() {});
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        if (AppConstants.kGetFTFrequencyList.length -
                                                                                1 !=
                                                                            index)
                                                                          Divider(
                                                                            thickness:
                                                                                1,
                                                                            height:
                                                                                0,
                                                                            color:
                                                                                colors(context).greyColor100,
                                                                          )
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        }));
                                            setState(() {});
                                          },
                                          initialValue:AppLocalizations.of(context).translate(frequency!),
                                        ),
                                      ])
                                  ],
                                ),
                              ),
                            ),
                            AppSizer.verticalSpacing(
                                AppSizer.getHomeIndicatorStatus(context)),
                          ],
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Column(
                      children: [
                        AppButton(
                            buttonText: AppLocalizations.of(context)
                                .translate("continue"),
                            onTapButton: () {
                              if (_formKey.currentState?.validate() == true) {
                                _ontap();
                              }
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText:
                              AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () {
                            showAppDialog(
                                title: AppLocalizations.of(context)
                                    .translate("cancel_the_bill_payment_title"),
                                message: AppLocalizations.of(context)
                                    .translate("cancel_the_bill_payment_desk"),
                                alertType: AlertType.DOCUMENT1,
                                onPositiveCallback: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.kHomeBaseView,
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                negativeButtonText: AppLocalizations.of(context)
                                    .translate("no"),
                                positiveButtonText: AppLocalizations.of(context)
                                    .translate("yes,_cancel"));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _ontap() {
    if (localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .transactionType
            ?.toUpperCase() ==
        "BILLPAY") {
      setState(() {
        maxGlobalLimitPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .maxUserAmountPerTran;
        twoFactorLimit = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .twoFactorLimit;
        minUserAmoubtPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .minUserAmountPerTran;
        isTwoFactorEnable = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "BILLPAY")
            .first
            .enabledTwoFactorLimit;
        serviceCharge = widget.billPaymentViewArgs.chargeAmount;
      });
    }
    if (isAmountAvailable == false) {
      showAppDialog(
        title: "Insufficient Balance of Account",
        alertType: AlertType.MONEY2,
        message: "You do not have sufficient funds.",
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () {},
      );
    } else if (double.parse(amount!).toInt() >
        num.parse(maxUserAmountPerTran!)) {
      showAppDialog(
          title: AppLocalizations.of(context).translate("type_wise_limit"),
          alertType: AlertType.FAIL,
          message:
              "${AppLocalizations.of(context).translate("type_wise_limit_des_1")}${amount.toString().withThousandSeparator()}${AppLocalizations.of(context).translate("type_wise_limit_des_2")}",
          positiveButtonText: "Change the Amount",
          onPositiveCallback: () {},
          bottomButtonText: "Amend Transaction Type-wise Limit",
          onBottomButtonCallback: () {
            Navigator.pushNamed(context, Routes.kTransactionListView);
          });
    } else if (double.parse(amount!).toInt() >
        num.parse(maxGlobalLimitPerTran!)) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("type_wise_limit"),
        alertType: AlertType.FAIL,
        message: AppLocalizations.of(context).translate("type_wise_limit_des"),
        positiveButtonText: AppLocalizations.of(context).translate("try_again"),
        onPositiveCallback: () {},
      );
    } else if (double.parse(amount!).toInt() <
        num.parse(minUserAmoubtPerTran!)) {
      showAppDialog(
        title: "Invalid Amount",
        alertType: AlertType.FAIL,
        message: "Amount should be greater than LKR $minUserAmoubtPerTran",
        positiveButtonText: "Ok",
        onPositiveCallback: () {},
      );
    } else if (isTwoFactorEnable! &&
        double.parse(amount!).toInt() > num.parse(twoFactorLimit!)) {
      showAppDialog(
        title: "Authentication Limit Exceeded",
        alertType: AlertType.FAIL,
        message:
            "2FA Limit was exceeded. Please authenticate\nyourself to continue this transaction",
        positiveButtonText: "Ok",
        onPositiveCallback: () async {
          if (_isBiometricAvailable && _isAppBiometricAvailable) {
            await biometricHelper
                .authenticateWithBiometrics(context)
                .then((success) {
              if (success == true) {
                _bloc.add(RequestBiometricPrompt2FAEvent());
              }
            });
          } else {
            Navigator.pushNamed(context, Routes.kFTEnterPasswordView,
                    arguments:
                        AppLocalizations.of(context).translate("bill_payment"))
                .then((value) {
              if (value == true) {
                onTapConfirm();
              }
            });
          }
        },
      );
    } else {
      onTapConfirm();
    }
  }

  onTapConfirm() {
    if (scheduleTypeDescription == "now") {
      Navigator.pushNamed(
        context,
        Routes.kBillPaymentSummaryView,
        arguments: BillPaymentSummeryArgs(
          billPaymentViewArgs: widget.billPaymentViewArgs,
          isSaved: widget.billPaymentViewArgs.isSaved!,
          bpRouteType: BPRouteType.NOW,
          route: widget.billPaymentViewArgs.route,
          instrumentId: isChangeAccount == false
              ? accountList[0].instrumentId.toString()
              : instrumentId.toString(),
          serviceProviderId: widget.billPaymentViewArgs.isSaved == true
              ? null
              : widget.billPaymentViewArgs.serviceProviderId??0,
          tranCatagory: widget.billPaymentViewArgs.isSaved == true
              ? null
              : widget.billPaymentViewArgs.billerCategoryEntity
                  ?.categoryDescription??"",
          payToAccNumber: payToNumber,
          billerCategoryEntity: widget.billPaymentViewArgs.billerCategoryEntity,
          amount: double.parse(amount!.trim().replaceAll(",", "")),
          payFromAccName:
              isChangeAccount == false ? accountList[0].nickName : nickName,
          payFromAccNumber: isChangeAccount == false
              ? accountList[0].accountNumber
              : accountNumber,
          //accNumber: widget.billPaymentViewArgs?.billerEntity?.customFieldList?.first.userValue,
          customFields:
              widget.billPaymentViewArgs.billerEntity?.customFieldList,
          billerEntity: widget.billPaymentViewArgs.billerEntity,
          remark: remark,
          serviceCharge: serviceCharge!,
          fundTransferEntity: fundTransferEntity,
          //serviceCharge: widget.billPaymentViewArgs.chargeAmount ?? 50,
          payToAccName: widget.billPaymentViewArgs.isSaved == true
              ? widget.billPaymentViewArgs.savedBillerEntity?.nickName ?? ""
              : widget.billPaymentViewArgs.billerEntity?.billerName,
          balanceBeforeTran: isChangeAccount == false
              ? accountList[0].availableBalance.toString()
              : avalBal,
        ),
      );
    }
    if (scheduleTypeDescription == "later") {
      Navigator.pushNamed(
        context,
        Routes.kBillPaymentSummaryView,
        arguments: BillPaymentSummeryArgs(
            billPaymentViewArgs: widget.billPaymentViewArgs,
            isSaved: widget.billPaymentViewArgs.isSaved!,
            bpRouteType: BPRouteType.LATER,
            route: widget.billPaymentViewArgs.route,
            instrumentId: isChangeAccount == false
                ? accountList[0].instrumentId.toString()
                : instrumentId.toString(),
            payFromAccName: isChangeAccount == false
                ? accountList[0].nickName
                : nickName,
            payFromAccNumber: isChangeAccount == false
                ? accountList[0].accountNumber
                : accountNumber,
            // payFromAccNumber: isChangeAccount == false ? accountList[0].accountNumber :accountList.reversed.first.accountNumber,
            payToAccNumber: payToNumber,
            payToAccName: widget.billPaymentViewArgs.isSaved == true
                ? widget.billPaymentViewArgs.savedBillerEntity?.nickName ?? ""
                : widget.billPaymentViewArgs.billerEntity?.billerName,
            accountEntity: accountList[0],
            amount: double.parse(amount!.trim().replaceAll(",", "")),
            customFields:
                widget.billPaymentViewArgs.billerEntity?.customFieldList,
            billerEntity: widget.billPaymentViewArgs.billerEntity,
            remark: remark,
            serviceCharge: serviceCharge!,
            fundTransferEntity: fundTransferEntity,
            tranDate: transactionDate,
            billerCategoryEntity:
                widget.billPaymentViewArgs.billerCategoryEntity,
            balanceBeforeTran: isChangeAccount == false
                ? accountList[0].availableBalance.toString()
                : avalBal),
      );
    }
    if (scheduleTypeDescription == "recurring") {
      Navigator.pushNamed(
        context,
        Routes.kBillPaymentSummaryView,
        arguments: BillPaymentSummeryArgs(
            billPaymentViewArgs: widget.billPaymentViewArgs,
            isSaved: widget.billPaymentViewArgs.isSaved!,
            route: widget.billPaymentViewArgs.route,
            payFromAccNumber: isChangeAccount == false
                ? accountList[0].accountNumber
                : accountNumber,
            payFromAccName: isChangeAccount == false
                ? accountList[0].nickName
                : nickName,
            payToAccName: widget.billPaymentViewArgs.isSaved == true
                ? widget.billPaymentViewArgs.savedBillerEntity?.nickName ?? ""
                : widget.billPaymentViewArgs.billerEntity?.billerName,
            instrumentId: isChangeAccount == false
                ? accountList[0].instrumentId.toString()
                : instrumentId.toString(),
            toAccountNumber: payToNumber,
            fundTransferEntity: fundTransferEntity,
            amount: double.parse(amount!.trim().replaceAll(",", "")),
            startDate: startDate,
            endDate: endDate,
            remark: remark,
            scheduleFrequency:AppUtils.getFrequencyWithoutLocalization(fundTransferEntity.scheduleFrequency??"daily"),
            payToAccNumber: payToNumber,
            accountEntity: accountList[0],
            billerCategoryEntity:
                widget.billPaymentViewArgs.billerCategoryEntity,
            customFields:
                widget.billPaymentViewArgs.billerEntity?.customFieldList,
            billerEntity: widget.billPaymentViewArgs.billerEntity,
            serviceCharge: serviceCharge!,
            bpRouteType: BPRouteType.RECUURING,
            balanceBeforeTran: isChangeAccount == false
                ? accountList[0].availableBalance.toString()
                : avalBal),
      );
    }
  }



  bool _isEnableBack() {
    if (amountController.text.isNotEmpty ||
        amountController.text != null ||
        mobileNumberController.text.isNotEmpty ||
        mobileNumberController != null ||
        transactionDate != null ||
        transactionDate!.isNotEmpty ||
        startDate != null ||
        startDate!.isNotEmpty ||
        endDate != null ||
        endDate!.isNotEmpty ||
        fundTransferEntity.scheduleFrequency!.isNotEmpty ||
        fundTransferEntity.scheduleFrequency != null ||
        remark!.isNotEmpty ||
        remark != null) {
      return _isBack = false;
    } else {
      return _isBack = true;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
