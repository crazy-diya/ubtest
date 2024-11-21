import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/widget/payee_details_textrow.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_event.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class AddPayeeDetailsConfirmView extends BaseView {
  final SavedPayeeEntity? payeeDetails;
  final bool isFromFromFundTransfer;

  AddPayeeDetailsConfirmView(
      {this.payeeDetails, this.isFromFromFundTransfer = false});

  @override
  _AddPayDetailsViewState createState() => _AddPayDetailsViewState();
}

class _AddPayDetailsViewState
    extends BaseViewState<AddPayeeDetailsConfirmView> {
  var bloc = injection<PayeeManagementBloc>();
  String? payeeId;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("add_payee"),
          actions: [
            widget.payeeDetails!.isFavorite ?
            IconButton(
                onPressed: () async {
                  widget.payeeDetails!.isFavorite =
                      !widget.payeeDetails!.isFavorite;
                  setState(() {});
                },
                icon: PhosphorIcon(
                  PhosphorIcons.star(PhosphorIconsStyle.bold),
                  color:  colors(context).secondaryColor,
                )) : SizedBox.shrink()
          ]),
      body: BlocProvider(
        create: (context) => bloc,
        child:
            BlocListener<PayeeManagementBloc, BaseState<PayeeManagementState>>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AddPayeeSuccessState) {
              if(state.responseCode == "844"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("already_added_nickname"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  },
                );
              } else if(state.responseCode == "508"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("account_already_exists"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              children: [
                                TextSpan(
                                    text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[0]} ",
                                    style:size14weight400.copyWith(color: colors(context).greyColor)
                                ),
                                TextSpan(
                                    text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[1]}",
                                    style:size14weight700.copyWith(color: colors(context).greyColor)
                                ),
                              ])
                      )
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  },
                );
              }else if(state.responseCode == "511"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("account_already_exists"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              children: [
                                TextSpan(
                                    text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[0]} ",
                                    style:size14weight400.copyWith(color: colors(context).greyColor)
                                ),
                                TextSpan(
                                    text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[1]}",
                                    style:size14weight700.copyWith(color: colors(context).greyColor)
                                ),
                              ])
                      )
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  },
                );
              } else {
                payeeId == state.payeeId.toString();
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      phoneNumber: AppConstants.profileData.mobileNo.toString(),
                      appBarTitle: 'otp_verification',
                      requestOTP: true,
                      action: "create",
                      id: state.payeeId.toString(),

                      ///todo: change the OTP type
                      otpType: kPayeeOTPType,
                    )).then((value) {
                  final result = value as bool;
                  if (result == true) {
                    Navigator.of(context)
                      ..pop()
                      ..pop(true);
                    ToastUtils.showCustomToast(
                        context,
                        AppLocalizations.of(context)
                            .translate("add_payee_success_message"),
                        ToastStatus.SUCCESS);
                  }
                });
              }
              // Navigator.pushNamed(context, Routes.kOtpView,
              //     arguments: OTPViewArgs(
              //       phoneNumber: AppConstants.profileData.mobileNo.toString(),
              //       appBarTitle: 'add_payee',
              //       requestOTP: true,
              //
              //       ///todo: change the OTP type
              //       otpType: kPayeeOTPType,
              //     )).then((value){
              //       if(value != null){
              //         Navigator.of(context)..pop()..pop(true);
              //         ToastUtils.showCustomToast(
              //             context,
              //             AppLocalizations.of(context)
              //                 .translate("add_payee_success_message"),
              //             ToastStatus.success);
              //       }
              // });

              // ToastUtils.showCustomToast(
              //     context,
              //     AppLocalizations.of(context)
              //         .translate("add_payee_success_message"),
              //     ToastStatus.success);
              // Navigator.pop(context, true);
              // Navigator.pop(context, true);
            } else if (state is AddPayeeFailedState) {
              // showAppDialog(
              //     title: "System Error",
              //     alertType: AlertType.FAIL,
              //     message:
              //         "Unable to save Payee to the Payee list. Please try again",
              //     positiveButtonText: "Try Again",
              //     //negativeButtonText: '',
              //     onPositiveCallback: () {
              //        Navigator.of(context)..pop()..pop();
              //     },
              //     onNegativeCallback: () {});
              if (state.code == "512") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("already_added_nickname"),
                    alertType: AlertType.FAIL,
                    message: AppLocalizations.of(context)
                        .translate("do_you_really_want_to_cancel"),
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                      Navigator.of(context)..pop();
                    },
                    onNegativeCallback: () {});
              } else if (state.code == "510") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("system_error"),
                    alertType: AlertType.FAIL,
                    message: state.message,
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    onNegativeCallback: () {});
              } else if (state.code == "511") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("account_already_exists"),
                    alertType: AlertType.WARNING,
                    // message: splitAndJoinAtBrTags(state.message ?? ""),
                    dialogContentWidget: Column(
                      children: [
                        Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                  text: splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[0]),
                                  style:size14weight400.copyWith(color: colors(context).greyColor)
                              ),
                              TextSpan(
                                  // recognizer: TapGestureRecognizer()
                                  //   ..onTap = () async {
                                  //     splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1]);
                                  //   },
                                  text:" ${splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1])}" ,
                                  style:size14weight700.copyWith(color: colors(context).greyColor)
                              ),
                            ])

                        )
                      ],
                    ),
                    positiveButtonText: AppLocalizations.of(context).translate("close"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                      Navigator.of(context)..pop();
                    },
                    onNegativeCallback: () {});
              } else if (state.code == "0014") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                    alertType: AlertType.FAIL,
                    message: state.message,
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                      Navigator.of(context)..pop();
                    },
                    onNegativeCallback: () {});
              } else {
                showAppDialog(
                    title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                    alertType: AlertType.FAIL,
                    message: state.message,
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    onNegativeCallback: () {});
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor),
                      child: Column(
                        children: [
                          DetailsField(
                            field1: AppLocalizations.of(context)
                                .translate("nickname"),
                            field2: widget.payeeDetails!.nickName ?? "-",
                            //field2: widget.payeeDetails.nickName,
                          ),
                          DetailsField(
                            field1:
                                AppLocalizations.of(context).translate("bank"),
                            field2: widget.payeeDetails!.bankName ?? "-",
                          ),
                          DetailsField(
                            field1: AppLocalizations.of(context)
                                .translate("Account_Number"),
                            field2: widget.payeeDetails!.accountNumber ?? "-",
                          ),
                          DetailsField(
                            isEnableDivider: widget.payeeDetails!.bankCode !=
                                AppConstants.ubBankCode.toString() ? true:false ,
                            field1: AppLocalizations.of(context)
                                .translate("account_holders_name"),
                            field2:
                                widget.payeeDetails!.accountHolderName ?? "-",
                          ),
                          Visibility(
                            visible: widget.payeeDetails!.bankCode !=
                                AppConstants.ubBankCode.toString(),
                            child: DetailsField(
                              isEnableDivider: false,
                              field1: AppLocalizations.of(context)
                                  .translate("branch"),
                              field2: widget.payeeDetails!.branchName ?? "-",
                            ),
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
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        bloc.add(
                          AddPayeeEvent(
                            verified: false,
                            branchCode: widget.payeeDetails!.branchCode,
                            nikname: widget.payeeDetails!.nickName,
                            bankcode: widget.payeeDetails!.bankCode,
                            accountnumber: widget.payeeDetails!.accountNumber,
                            holdername: widget.payeeDetails!.accountHolderName,
                            addfavorite: widget.payeeDetails!.isFavorite,
                            //branchCode: widget.payeeDetails!.branchCode,
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                          title: AppLocalizations.of(context)
                              .translate("cancel_the_add_payee"),
                          alertType: AlertType.USER3,
                          message: AppLocalizations.of(context)
                              .translate("cancel_the_edit_des"),
                          positiveButtonText: AppLocalizations.of(context)
                              .translate("yes,_cancel"),
                          negativeButtonText:
                              AppLocalizations.of(context).translate("no"),
                          onNegativeCallback: () {},
                          onPositiveCallback: () {
                            Navigator.pushNamed(context, Routes.kHomeBaseView);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchCaller(String number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
