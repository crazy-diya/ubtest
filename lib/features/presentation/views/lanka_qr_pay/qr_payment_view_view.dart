import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/lanka_qr_pay/qr_payment_summary_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/carousel_widget/app_carousel_widget.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/text_editing_controllers.dart';
import '../../../data/models/common/lanka_qr_payload.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';

class QRPaymentViewArgs {
  LankaQrPayload? lankaQrPayload;
  final String? route;

  QRPaymentViewArgs({required this.lankaQrPayload, this.route});
}

class QRPaymentView extends BaseView {
  final QRPaymentViewArgs qrPaymentViewArgs;

  QRPaymentView({ super.key,required this.qrPaymentViewArgs});

  @override
  _QRPaymentViewState createState() => _QRPaymentViewState();
}

class _QRPaymentViewState extends BaseViewState<QRPaymentView> {
  var _bloc = injection<AccountBloc>();
  final localDataSource = injection<LocalDataSource>();
  final biometricHelper = injection<BiometricHelper>();
  List<AccountEntity> accountList = [];
  List<AccountEntity> accountListPortfolio = [];
  final fundTransferEntity = FundTransferEntity();
  final TextEditingController refController = TextEditingController();
  late CurrencyTextEditingController amountController;

  double? amount = 0.00;
  double initialValue = 0.00;
  String? remark;
  String? payFromName;
  int currentCarouselIndex = 0;
  int? currentItem;
  String? nickName;
  String? accountNumber;
  String? instrumentId;
  bool isChangeAccount = false;
  String? refNumber;
  String? avalBal;
  bool isAmountAvailable = true;

  String? maxUserAmountPerTran;
  String? maxGlobalLimitPerTran;
  String? twoFactorLimit;
  String? minUserAmoubtPerTran;
  bool? isTwoFactorEnable = false;
  double? serviceCharge = 0.00;

  //biometric for 2FA
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetTranLimitForFTEvent());
    amountController = CurrencyTextEditingController(
          initialValue: double.parse(
              (widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee != "" &&
                      widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee !=
                          null)
                  ? widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee??"0.00"
                  : "0.00"));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      refController.text =
          widget.qrPaymentViewArgs.lankaQrPayload?.referenceId ?? "";
      amount = double.tryParse(
          (widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee != "" &&
                  widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee !=
                      null)
              ? widget.qrPaymentViewArgs.lankaQrPayload?.transactionFee??"0.00"
              : "0.00");
      initialValue = amount ?? 0.00;

      _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
      await initialBiometric();
    });
  }

  Future<void> initialBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      
    }
    
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        showAppDialog(
          title: AppLocalizations.of(context).translate("cancel_qr_payment"),
          alertType: AlertType.QR,
          message:
              AppLocalizations.of(context).translate("cancel_qr_payment_des"),
          positiveButtonText:
              AppLocalizations.of(context).translate("yes,_cancel"),
          negativeButtonText: AppLocalizations.of(context).translate("no"),
          onPositiveCallback: () {
            Navigator.of(context).pop();
          },
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("qr_payment"),
          onBackPressed: () {
            showAppDialog(
              title:
                  AppLocalizations.of(context).translate("cancel_qr_payment"),
              alertType: AlertType.QR,
              message: AppLocalizations.of(context)
                  .translate("cancel_qr_payment_des"),
              positiveButtonText:
                  AppLocalizations.of(context).translate("yes,_cancel"),
              negativeButtonText: AppLocalizations.of(context).translate("no"),
              onPositiveCallback: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        body: BlocProvider<AccountBloc>(
          create: (context) => _bloc,
          child: BlocListener<AccountBloc, BaseState<AccountState>>(
              listener: (context, state) {
                if (state is PortfolioAccountDetailsSuccessState) {
                  if (state.accDetails?.accountDetailsResponseDtos?.length !=
                          0 &&
                      state.accDetails?.accountDetailsResponseDtos != null) {
                    accountListPortfolio.clear();
                    accountListPortfolio.addAll(state
                        .accDetails!.accountDetailsResponseDtos!
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
                     accountList = accountList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                    accountList = accountList.unique((x) => x.accountNumber);

                    if (currentCarouselIndex == 0) {
                      fundTransferEntity.availableBalance =
                          accountList[0].availableBalance;
                      fundTransferEntity.bankCodePayFrom =
                          int.parse(accountList[0].bankCode!);
                    }
                  }
                  
                  if (amount != null) {
                    if ((amount! >
                            fundTransferEntity.availableBalance!.toInt()) &&
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
                  _formKey.currentState?.validate();
                  setState(() {});
                } else if (state is AccountDetailFailState) {
                  showAppDialog(
                      title: AppLocalizations.of(context).translate("there_was_some_error"),
                      alertType: AlertType.FAIL,
                      message: state.errorMessage,
                      positiveButtonText:
                          AppLocalizations.of(context).translate("Try_Again"),
                      onPositiveCallback: () {
                        accountList.clear();
                        _bloc.add(GetPortfolioAccDetailsEvent());
                      },
                      negativeButtonText: AppLocalizations.of(context).translate("go_back"),
                      onNegativeCallback: () {
                        Navigator.of(context).pop();
                      });
                } else if (state is GetTransLimitForFTSuccessState) {
                    hideProgressBar();
                  _bloc.add(GetPortfolioAccDetailsEvent());
                } else if (state is GetTransLimitForFTFailedState) {
                  showAppDialog(
                      alertType: AlertType.WARNING,
                      title: AppLocalizations.of(context).translate("something_went_wrong"),
                      message:AppLocalizations.of(context).translate("txn_limit_not_ft"),
                      positiveButtonText: AppLocalizations.of(context).translate("ok"),
                      onPositiveCallback: () {
                        Navigator.pop(context);
                        setState(() {});
                      });
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  0,
                  20.w,
                  20.h + AppSizer.getHomeIndicatorStatus(context),
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              Text(
                                  AppLocalizations.of(context)
                                      .translate("pay_to"),
                                  style: size14weight700.copyWith(
                                      color: colors(context).blackColor)),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                    color: colors(context).whiteColor,
                                    borderRadius: BorderRadius.circular(8).r),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 64.w,
                                          height: 64.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8).r,
                                              border: Border.all(
                                                  color: colors(context)
                                                      .greyColor300!)),
                                          child: Center(
                                            child: PhosphorIcon(
                                              PhosphorIcons.storefront(
                                                  PhosphorIconsStyle.bold),
                                              color:
                                                  colors(context).primaryColor,
                                            ),
                                          )),
                                      12.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          2.verticalSpace,
                                          Text(
                                              widget
                                                      .qrPaymentViewArgs
                                                      .lankaQrPayload!
                                                      .merchantName ??
                                                  "",
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          4.verticalSpace,
                                          Text(
                                              widget
                                                      .qrPaymentViewArgs
                                                      .lankaQrPayload!
                                                      .merchantCity ??
                                                  "",
                                              style: size14weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          2.verticalSpace,
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Text(AppLocalizations.of(context).translate("Pay_From"),
                                  style: size14weight700.copyWith(
                                      color: colors(context).blackColor)),
                              16.verticalSpace,
                              AppCarouselWidget(
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
                                      avalBal = selectedItem.availableBalance
                                          .toString();
                                      instrumentId =
                                          selectedItem.instrumentId.toString();
                                      fundTransferEntity.bankCodePayFrom =
                                          int.parse(selectedItem.bankCode!);
                                      fundTransferEntity.availableBalance =
                                          accountList[index].availableBalance;
                                      if (amount != null) {
                                        if ((amount! >
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
                                      }
                                    });
                                  }),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                    color: colors(context).whiteColor,
                                    borderRadius: BorderRadius.circular(8).r),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: widget
                                                    .qrPaymentViewArgs
                                                    .lankaQrPayload!
                                                    .referenceId !=
                                                '***' &&
                                            widget
                                                .qrPaymentViewArgs
                                                .lankaQrPayload!
                                                .referenceId!
                                                .isNotEmpty,
                                        child: AppTextField(
                                          isEnable: false,
                                          hint: AppLocalizations.of(context).translate("reference_number"),
                                          // isLabel: true,
                                          title: AppLocalizations.of(context).translate("reference_number"),
                                          inputType: TextInputType.number,
                                          controller: refController,
                                          // inputTextStyle:
                                          //     TextStyle(color: colors(context).greyColor, fontWeight: FontWeight.w600),
                                          isReadOnly: true,
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget
                                                    .qrPaymentViewArgs
                                                    .lankaQrPayload!
                                                    .referenceId ==
                                                '***' ||
                                            widget
                                                .qrPaymentViewArgs
                                                .lankaQrPayload!
                                                .referenceId!
                                                .isEmpty,
                                        child: AppTextField(
                                          // hint: AppLocalizations.of(context)
                                          //     .translate("reference_number"),
                                          hint: AppLocalizations.of(context).translate("reference_number"),
                                          title: AppLocalizations.of(context).translate("reference_number"),
                                          inputType: TextInputType.number,
                                          onTextChanged: (value) {
                                            setState(() {
                                              refNumber = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == "" || value == null) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "mandatory_field_msg");
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        isEnable: (widget
                                                        .qrPaymentViewArgs
                                                        .lankaQrPayload
                                                        ?.pointOfInitiationMethod ==
                                                    "12" &&
                                                initialValue != 0)
                                            ? false
                                            : true,
                                        hint: AppLocalizations.of(context)
                                            .translate("amount"),
                                        title: AppLocalizations.of(context)
                                            .translate("amount"),
                                        isCurrency: true,
                                        maxLength: 15,
                                        inputType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        controller: amountController,
                                        showCurrencySymbol: true,
                                        onTextChanged: (value) {
                                          setState(() {
                                            amount = double.parse(
                                                value.trim().replaceAll(
                                                      ",",
                                                      "",
                                                    ));

                                            if (amount != null) {
                                              if ((amount! >
                                                      fundTransferEntity
                                                          .availableBalance!
                                                          .toInt()) &&
                                                  (fundTransferEntity
                                                          .bankCodePayFrom ==
                                                      AppConstants
                                                          .ubBankCode)) {
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
                                        validator: (value) {
                                          if (amountController.text.isEmpty ||
                                              amountController.text == "0.00") {
                                            return AppLocalizations.of(context)
                                                .translate(
                                                    "mandatory_field_msg");
                                          } else if (isAmountAvailable ==
                                              false) {
                                            return AppLocalizations.of(context)
                                                .translate(
                                                    "this_amount_not_available");
                                          } else {
                                            return null;
                                          }
                                        },
                                        isInfoIconVisible: false,
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        //key: const Key("remark"),
                                        title: AppLocalizations.of(context)
                                            .translate("remark_optional"),
                                        hint: AppLocalizations.of(context)
                                            .translate("remark_optional"),
                                        maxLength: 30,
                                        onTextChanged: (value) {
                                          setState(() {
                                            remark = value;
                                          });
                                        },
                                        isInfoIconVisible: false,
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
                                .translate("pay_now"),
                            onTapButton: () {
                              if (_formKey.currentState?.validate() == true) {
                                _ontap();
                              }
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
                                title: AppLocalizations.of(context)
                                    .translate("cancel_qr_payment"),
                                alertType: AlertType.QR,
                                message: AppLocalizations.of(context)
                                    .translate("cancel_qr_payment_des"),
                                positiveButtonText: AppLocalizations.of(context)
                                    .translate("yes,_cancel"),
                                negativeButtonText: AppLocalizations.of(context)
                                    .translate("no"),
                                onPositiveCallback: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  _ontap() {
    if (localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .transactionType
            ?.toUpperCase() ==
        "LQR") {
      setState(() {
        maxGlobalLimitPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .maxGlobalLimitPerTran;
        maxUserAmountPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .maxUserAmountPerTran;
        twoFactorLimit = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .twoFactorLimit;
        minUserAmoubtPerTran = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .minUserAmountPerTran;
        isTwoFactorEnable = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .enabledTwoFactorLimit;

        final _serviceCharge = localDataSource
            .getTxnLimits()
            ?.where((e) => e.transactionType?.toUpperCase() == "LQR")
            .first
            .serviceCharge;
        serviceCharge = double.tryParse((_serviceCharge == "-" ||
                _serviceCharge == null ||
                _serviceCharge == "0" ||
                _serviceCharge == "0.0" ||
                _serviceCharge == "0.00")
            ? "0.00"
            : _serviceCharge);
      });
    }
    if (isAmountAvailable == false) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("insufficient_balance_of_Account"),
        alertType: AlertType.FAIL,
        message: AppLocalizations.of(context).translate("not_sufficient_bal_des"),
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () {},
      );
    } else if (amount!.toInt() > num.parse(maxUserAmountPerTran!)) {
      showAppDialog(
          title: AppLocalizations.of(context).translate("type_wise_limit"),
          alertType: AlertType.FAIL,
          message:
              "${AppLocalizations.of(context).translate("type_wise_limit_des_1")}${amount.toString().withThousandSeparator()}${AppLocalizations.of(context).translate("type_wise_limit_des_2")}",
          positiveButtonText: AppLocalizations.of(context).translate("change_the_amount"),
          onPositiveCallback: () {},
          bottomButtonText: AppLocalizations.of(context).translate("amend_transaction_limit"),
          onBottomButtonCallback: () {
            Navigator.pushNamed(context, Routes.kTransactionListView);
          });
    } else if (amount!.toInt() > num.parse(maxGlobalLimitPerTran!)) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("type_wise_limit"),
        alertType: AlertType.FAIL,
        message: AppLocalizations.of(context).translate("type_wise_limit_des"),
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () {},
      );
    } else if (amount!.toInt() < num.parse(minUserAmoubtPerTran!)) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("invalid_amount"),
        alertType: AlertType.FAIL,
        message: "${AppLocalizations.of(context).translate("amount_should_greater_than")} $minUserAmoubtPerTran",
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () {},
      );
    } else if (isTwoFactorEnable! &&
        amount!.toInt() > num.parse(twoFactorLimit!)) {
      showAppDialog(
        title: AppLocalizations.of(context).translate("type_wise_limit"),
        alertType: AlertType.FAIL,
        message: AppLocalizations.of(context).translate("2FA_imit_was_exceeded_des"),
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
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
                        AppLocalizations.of(context).translate("qr_payment"))
                .then((value) {
              if (value == true) {
                onTapConfirm();
              }
              // else{
              //   showAppDialog(
              //       alertType: AlertType.FAIL,
              //       title: "Something went wrong",
              //       //message: "Something went wrong please try again",
              //       positiveButtonText: "Try Again",
              //       onPositiveCallback: () {});
              // }
            });
          }
        },
      );
    } else {
      onTapConfirm();
    }
  }

  onTapConfirm() {
    Navigator.pushNamed(
      context,
      Routes.kQRPaymentSummary,
      arguments: QRPaymentSuummaryArgs(
        route: widget.qrPaymentViewArgs.route,
        serviceCharge: serviceCharge,
        beforeTrans: isChangeAccount == false
            ? accountList[0].availableBalance.toString()
            : avalBal!,
        refnumber: (widget.qrPaymentViewArgs.lankaQrPayload?.referenceId ==
                    '***' ||
                widget.qrPaymentViewArgs.lankaQrPayload?.referenceId == null ||
                widget.qrPaymentViewArgs.lankaQrPayload?.referenceId == "")
            ? refNumber
            : widget.qrPaymentViewArgs.lankaQrPayload?.referenceId,
        accountList: accountList,
        amount: amount ?? double.parse(amountController.text ?? "0.00"),
        lankaQrPayload: widget.qrPaymentViewArgs.lankaQrPayload,
        remark: remark ?? "",
        payFromName:
            isChangeAccount == false ? accountList[0].nickName : nickName,
        payFromNum: isChangeAccount == false
            ? accountList[0].accountNumber
            : accountNumber,
        instrumentId: isChangeAccount == false
            ? accountList[0].instrumentId.toString()
            : instrumentId!,
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
