import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../otp/otp_view.dart';
import '../widgets/credit_card_details_card.dart';

class NewPinRequestView extends BaseView {
  final List<CreditCardDetailsCard> itemList;


  NewPinRequestView({required this.itemList});

  @override
  State<NewPinRequestView> createState() => _NewPinRequestViewState();
}

class _NewPinRequestViewState extends BaseViewState<NewPinRequestView> {
  final bloc = injection<CreditCardManagementBloc>();
  final _scrollController = ScrollController();
  List<CreditCardDetailsCard> creditCardList = [
    // CreditCardMngmtRequestEntity(
    //   cardNo: "454545 **** 0001",
    //   title: "Visa Gold",
    //   bankCode: "7302",
    // ),
    // CreditCardMngmtRequestEntity(
    //   cardNo: "004545 **** 0003",
    //   title: "Visa Platinum ",
    //   bankCode: "7302",
    // ),
  ];
  late CreditCardDetailsCard? tempSelectedCreditCard;
  final _formKey = GlobalKey<FormState>();
  String? remark;
  TextEditingController remarkController = TextEditingController();
  @override
  void initState() {
    super.initState();
    creditCardList = widget.itemList;
    tempSelectedCreditCard = creditCardList[0];
  }
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("new_pin_request"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
            listener: (context, state){
            if(state is GetCardPinSuccessState){
              if(state.resCode == "00"){
                showAppDialog(
                  title: AppLocalizations.of(context).translate("Send_request_successful"),
                  alertType: AlertType.SUCCESS,
                  message: AppLocalizations.of(context).translate("Send_request_successful_des"),
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
            if(state is GetCardPinFailedState){
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
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
                                                    title: AppLocalizations.of(
                                                        context)
                                                        .translate(
                                                        'select_your_credit_card'),
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
                                                              setState(() {
                                                                tempSelectedCreditCard =
                                                                    tempSelectedCreditCard;
                                                              });
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
                                                        itemCount:
                                                        creditCardList.length,
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              tempSelectedCreditCard =
                                                              creditCardList[
                                                              index];
                                                              changeState(() {});
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      index ==
                                                                          0
                                                                          ? 0
                                                                          : 24.h,
                                                                      0,
                                                                      24.h),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                                width: 48,
                                                                                height: 48,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8).r, border: Border.all(color: colors(context).greyColor300!)),
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
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  creditCardList[index].cardType ?? "-",
                                                                                  style: size16weight700.copyWith(color: colors(context).blackColor),
                                                                                ),
                                                                                4.verticalSpace,
                                                                                Text(
                                                                                  creditCardList[index].maskedCardNumber ?? "-",
                                                                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                            8.w),
                                                                        child: UBRadio<
                                                                            dynamic>(
                                                                          value: creditCardList[index]
                                                                              .maskedCardNumber,
                                                                          groupValue:
                                                                          tempSelectedCreditCard!.maskedCardNumber,
                                                                          onChanged:
                                                                              (value) {
                                                                            // tempSelectedCreditCard!.title =
                                                                            //     value!.description;
                                                                            tempSelectedCreditCard =
                                                                                value;
                                                                            changeState(
                                                                                    () {});
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (creditCardList
                                                                    .length -
                                                                    1 !=
                                                                    index)
                                                                  Divider(
                                                                    height: 0,
                                                                    thickness: 1,
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
                                      },
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                             width: 64,
                                            height: 64,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8).r,
                                                border: Border.all(
                                                    color: colors(context)
                                                        .greyColor300!)),
                                            child: ClipRRect(
                                              borderRadius:
                                                    BorderRadius.circular(8).r,
                                              child: Center(
                                                child: Image.asset(
                                                  width: 44,
                                                  height: 44,
                                                  bankIcons
                                                      .firstWhere(
                                                        (element) =>
                                                    element.bankCode ==
                                                        "7302",
                                                  )
                                                      .icon!,
                                                ),
                                              )),
                                            ),
                                            24.horizontalSpace,
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(tempSelectedCreditCard!.cardType ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: size16weight700.copyWith(
                                                            color: colors(context)
                                                                .blackColor)),
                                                    8.verticalSpace,
                                                    Text(tempSelectedCreditCard!.maskedCardNumber ?? "",
                                                        style: size14weight400.copyWith(
                                                            color: colors(context)
                                                                .blackColor)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Spacer(),
                                            PhosphorIcon(
                                              PhosphorIcons.caretRight(
                                                  PhosphorIconsStyle.bold),
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
                                padding: const EdgeInsets.all(16.0).w,
                                child: AppTextField(
                                  validator: (a){
                                    if(remarkController.text.isEmpty){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_remarks"),
                                  title: AppLocalizations.of(context)
                                      .translate("remarks"),
                                  maxLength: 30,
                                  onTextChanged: (value) {
                                    setState(() {
                                      remark = value;
                                    });
                                  },
                                  maxLines: 1,
                                  controller: remarkController,
                                  isInfoIconVisible: false,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                          buttonType:  ButtonType.PRIMARYENABLED,
                          buttonText: AppLocalizations.of(context).translate("Send_request"),
                          onTapButton: () async {
                            if (_formKey.currentState?.validate() == true) {
                              _onTap();
                            }
                            // showAppDialog(
                            //     alertType: AlertType.SUCCESS,
                            //     title: AppLocalizations.of(context).translate("Send_request_successful"),
                            //     message:
                            //     "You have successfully submitted your request to change your PIN",
                            //     positiveButtonText: AppLocalizations.of(context).translate("done"),
                            //     onPositiveCallback: () {
                            //       Navigator.pop(context);
                            //       setState(() {});
                            //     });

                            // showAppDialog(
                            //     alertType: AlertType.CONNECTION,
                            //     title: AppLocalizations.of(context).translate("unable_connect_server"),
                            //     message:
                            //     "Connection could not be made.Please try again later.",
                            //     positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                            //     onPositiveCallback: () {
                            //       Navigator.pop(context);
                            //       setState(() {});
                            //     });

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
  _onTap(){
    Navigator.pushNamed(context, Routes.kOtpView,
        arguments: OTPViewArgs(
            phoneNumber: AppConstants.profileData.mobileNo
                .toString(),
            appBarTitle: "otp_verification",
            otpType: "newpinrequest",
            requestOTP: true))
        .then((value) {
      if (value == true) {
        bloc.add(GetCardPinEvent(
            maskedCardNumber: tempSelectedCreditCard?.maskedCardNumber,
            pinChangeReason: remark
        ));
      }
    });

    // showAppDialog(
    //     alertType: AlertType.CONNECTION,
    //     title: AppLocalizations.of(context).translate("unable_connect_server"),
    //     message:
    //     "Connection could not be made.Please try again later.",
    //     positiveButtonText: AppLocalizations.of(context).translate("try_again"),
    //     onPositiveCallback: () {
    //       Navigator.pop(context);
    //       setState(() {});
    //     });
    // Navigator.pushNamed(context, Routes.kOtpView,
    //         arguments: OTPViewArgs(
    //             phoneNumber: AppConstants.profileData.mobileNo
    //                 .toString(),
    //             appBarTitle: "otp_verification",
    //             otpType: "e-statement",
    //             requestOTP: true))
    //     .then((value) {
    //   if (value != null) {
    //     ToastUtils.showCustomToast(
    //         context, "success", ToastStatus.SUCCESS);
    //   }
    // });
  }
  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
