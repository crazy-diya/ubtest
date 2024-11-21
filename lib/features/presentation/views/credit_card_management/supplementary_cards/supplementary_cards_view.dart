import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/card_management/card_list_response.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../../otp/otp_view.dart';
import '../widgets/credit_card_details_entity.dart';

class SupplementaryCardsView extends BaseView {
  final List<CardResAddonCardDetail> addOnCardList;


  SupplementaryCardsView({required this.addOnCardList});

  @override
  State<SupplementaryCardsView> createState() => _SupplementaryCardsViewState();
}

class _SupplementaryCardsViewState
    extends BaseViewState<SupplementaryCardsView> {
  final bloc = injection<CreditCardManagementBloc>();
  final _formKey = GlobalKey<FormState>();
  List<CreditCardDetails> creditCardList = [];

  CreditCardDetails? tempSelectedCreditCard;
  final TextEditingController creditLimitController = TextEditingController();
  final TextEditingController cashLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // bloc.add(GetCardListEvent());
    creditCardList.addAll(widget.addOnCardList.
    map((e) => CreditCardDetails(
        cardType: e.resAddonCardTypeWithDesc?.removeUnwantedProductCodes(),
        cardNumber: e.resAddonMaskedCardNumber,
        name: e.resAddonCustomerName,
        cardStatus: e.resAddonCardStatusWithDesc,
        creditLimit: e.resAddonCreditLimit,
        cardLimit: e.resAddonCashLimit,
        accountNumber: e.resCmsAccNo
    )).toList());
    tempSelectedCreditCard = creditCardList[0];
    setState(() {});
    // tempSelectedCreditCard = creditCardList[0];
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("supplementary_cards"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
            bloc: bloc,
            listener: (context, state){
              if(state is GetCardListLoadedState){}
              if(state is GetCardCreditLimitSuccessState){
                if(state.resCode == "00"){
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("Send_request_successful"),
                    alertType: AlertType.SUCCESS,
                    message: AppLocalizations.of(context).translate("cr_limit_success_des"),
                    positiveButtonText: AppLocalizations.of(context).translate("done"),
                    onPositiveCallback: () {
                      Navigator.pop(context);
                    },
                  );
                }
                if(state.resCode != "00") {
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("unable_to_proceed"),
                    alertType: AlertType.FAIL,
                    message: state.resDescription ?? AppLocalizations.of(context).translate("fail"),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                }
              }
              if(state is GetCardCreditLimitFailedState){
                showAppDialog(
                  title: AppLocalizations.of(context).translate("something_went_wrong"),
                  alertType: AlertType.FAIL,
                  message: state.message ?? AppLocalizations.of(context).translate("fail"),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {
                  },
                );
              }
            },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.verticalSpace,
                        Text(
                          AppLocalizations.of(context)
                              .translate("select_your_credit_card"),
                          style: size14weight700.copyWith(
                              color: colors(context).blackColor),
                        ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
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
                                            StatefulBuilder(builder: (context, changeState) {
                                              return BottomSheetBuilder(
                                                title: AppLocalizations.of(context).translate('select_your_credit_card'),
                                                buttons: [
                                                  Expanded(
                                                    child: AppButton(
                                                        buttonType: ButtonType.PRIMARYENABLED,
                                                        buttonText: AppLocalizations.of(context).translate("continue"),
                                                        onTapButton: () {
                                                          setState(() {
                                                            tempSelectedCreditCard = tempSelectedCreditCard;
                                                          });
                                                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                          Navigator.of(context).pop(true);
                                                          changeState(() {});
                                                          setState(() {});
                                                        }),
                                                  ),
                                                ],
                                                children: [
                                                  ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: creditCardList.length,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          tempSelectedCreditCard = creditCardList[index];
                                                          changeState(() {});
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.fromLTRB(0,
                                                                      index == 0 ? 0 : 24.h, 0, 24.h),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                            width: 48,
                                                                            height: 48,
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8).r,
                                                                                border: Border.all(color: colors(context).greyColor300!)),
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8).r,
                                                                              child: Center(
                                                                                child: Image.asset(
                                                                                  AppAssets.ubBank,
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              ),
                                                                            )),
                                                                        12.horizontalSpace,
                                                                        Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              creditCardList[index].name ?? "-",
                                                                              style: size16weight700.copyWith(color: colors(context).blackColor),
                                                                            ),
                                                                            4.verticalSpace,
                                                                            Text(
                                                                              creditCardList[index].cardNumber ?? "-",
                                                                              style: size14weight400.copyWith(color: colors(context).greyColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 8.w),
                                                                    child: UBRadio<dynamic>(
                                                                      value: creditCardList[index].cardNumber,
                                                                      groupValue: tempSelectedCreditCard?.cardNumber,
                                                                      onChanged: (value) {
                                                                        tempSelectedCreditCard?.cardNumber = value.description;
                                                                        // tempSelectedCreditCard = value;
                                                                        changeState(() {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (creditCardList.length - 1 != index)
                                                              Divider(
                                                                height: 0,
                                                                thickness: 1,
                                                                color: colors(context).greyColor100,
                                                              )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              );
                                            }));
                                  },
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8).r,
                                                  border: Border.all(color: colors(context).greyColor300!)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8).r,
                                                child: Center(
                                                  child: Image.asset(
                                                    width: 44,
                                                    height: 44,
                                              bankIcons.firstWhere((element) => element.bankCode == "7302",).icon!,
                                            )),
                                          ),
                                        ),
                                        24.horizontalSpace,
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    tempSelectedCreditCard?.cardType ?? "-",
                                                    // textAlign: TextAlign.justify,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: size16weight700.copyWith(color: colors(context).blackColor)
                                                ),
                                                8.verticalSpace,
                                                Text(
                                                    tempSelectedCreditCard?.cardNumber ??
                                                        "-",
                                                    style: size14weight400.copyWith(color: colors(context).blackColor)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        PhosphorIcon(
                                          PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                          color: colors(context).greyColor300,
                                        )
                                      ],
                                    ),
                                  ),
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
                            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                            child: Column(
                              children: [
                                FTSummeryDataComponent(
                                  title:
                                      AppLocalizations.of(context).translate("name"),
                                  data: tempSelectedCreditCard?.name ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("status"),
                                  data: tempSelectedCreditCard?.cardStatus?.toTitleCase() ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("cms_account_number"),
                                  data:
                                      tempSelectedCreditCard?.accountNumber ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("existing_credit_limit"),
                                  amount: tempSelectedCreditCard?.creditLimit == null || tempSelectedCreditCard?.creditLimit == "" ? 0.00 :
                                  double.parse(tempSelectedCreditCard?.creditLimit ?? "0.00"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("existing_cash_limit"),
                                  amount: tempSelectedCreditCard?.cardLimit == null || tempSelectedCreditCard?.cardLimit == "" ? 0.00 :
                                  double.parse(tempSelectedCreditCard?.cardLimit ?? "0.00"),
                                  isCurrency: true,
                                  isLastItem: true,
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
                            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextField(
                                  validator: (value){
                                    if(creditLimitController.text.isEmpty || creditLimitController.text == ""){
                                      return AppLocalizations.of(context).translate("supplimentary_card_limit_des");
                                    }else{
                                      return null;
                                    }
                                  },
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),// Allow only digits
                                    TextInputFormatter.withFunction((oldValue, newValue) {
                                        if (newValue.text.isEmpty) {
                                          return newValue;
                                        }
                                        final int? number = int.tryParse(newValue.text);
                                        if (number != null && (number >= 0 && number <= 100)) {
                                          return newValue;
                                        }
                                        return oldValue;
                                      },
                                    ),
                                  ],
                                  controller: creditLimitController,
                                  isInfoIconVisible: false,
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_new_credit_limit"),
                                  title: AppLocalizations.of(context)
                                      .translate("new_credit_limit"),
                                  isLabel: false,
                                  inputType: TextInputType.number,
                                  maxLength: 3,
                                  onTextChanged: (value) {
                                    setState(() {
                                      creditLimitController.text = value;
                                    });
                                  },
                                ),
                                12.verticalSpace,
                                Text(
                                    AppLocalizations.of(context).translate("new_credit_limit_description"),
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor)),
                                16.verticalSpace,
                                AppTextField(
                                  validator: (value){
                                    if(cashLimitController.text.isEmpty || cashLimitController.text == ""){
                                      return AppLocalizations.of(context).translate("supplimentary_card_limit_des");
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: cashLimitController,
                                  isInfoIconVisible: false,
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_cash_limit"),
                                  isLabel: false,
                                  title: AppLocalizations.of(context)
                                      .translate("new_cash_limit"),
                                  inputType: TextInputType.number,
                                  maxLength: 3,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),// Allow only digits
                                    TextInputFormatter.withFunction((oldValue, newValue) {
                                      if (newValue.text.isEmpty) {
                                        return newValue;
                                      }
                                      final int? number = int.tryParse(newValue.text);
                                      if (number != null && (number >= 0 && number <= 100)) {
                                        return newValue;
                                      }
                                      return oldValue;
                                    },
                                    ),
                                  ],
                                  onTextChanged: (value) {
                                    setState(() {
                                      cashLimitController.text = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                        // buttonType:
                        //     (creditLimitController.text.isNotEmpty) &&
                        //             (cashLimitController.text.isNotEmpty)
                        //         ? ButtonType.PRIMARYENABLED
                        //         : ButtonType.PRIMARYDISABLED,
                        buttonText: AppLocalizations.of(context).translate("submit"),
                        onTapButton: () async {
                          if(_formKey.currentState?.validate() == false){
                            return;
                          }
                          Navigator.pushNamed(context, Routes.kOtpView,
                                  arguments: OTPViewArgs(
                                      phoneNumber: AppConstants.profileData.mobileNo
                                          .toString(),
                                      appBarTitle: "otp_verification",
                                      otpType: "cardaddonlimits",
                                      requestOTP: true))
                              .then((value) {
                            if (value == true) {
                              bloc.add(GetCardCreditLimitEvent(
                                  maskedAddonCardNumber: tempSelectedCreditCard?.cardNumber,
                                  addonCashLimitPerc: cashLimitController.text,
                                  addonCrLimitPerc: creditLimitController.text
                              ));
                            }
                          });
                        },
                      ),
                      16.verticalSpace,
                      AppButton(
                        buttonColor: colors(context).primaryColor50,
                        borderColor: colors(context).primaryColor,
                        textColor: colors(context).primaryColor,
                        buttonText: AppLocalizations.of(context).translate("reset"),
                        onTapButton: () async {
                          setState(() {
                            creditLimitController.clear();
                            cashLimitController.clear();
                          });
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
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
