import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/payee_management_save_payee_view.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/widget/payee_details_textrow.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_event.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

// class EditPayeeConfirmViewArgs {
//   final SavedPayeeEntity? savedPayeeEntity;
//   final bool? isFavorite;
//   final String? refnum;
//   final int payeeId;

//   EditPayeeConfirmViewArgs(
//       {this.savedPayeeEntity,
//       this.isFavorite,
//       this.refnum,
//       required this.payeeId});
// }

class EditPayeeConfirmView extends BaseView {
  final SavedPayeeEntity? savedPayeeEntity;
  EditPayeeConfirmView({this.savedPayeeEntity});

  @override
  _EditPayeeConfirmViewState createState() => _EditPayeeConfirmViewState();
}

class _EditPayeeConfirmViewState extends BaseViewState<EditPayeeConfirmView> {
  var _bloc = injection<PayeeManagementBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
      widget.savedPayeeEntity!.isFavorite ?
          IconButton(
              onPressed: () async {
                widget.savedPayeeEntity!.isFavorite =
                    !widget.savedPayeeEntity!.isFavorite;
                setState(() {});
              },
              icon: PhosphorIcon(
                PhosphorIcons.star(PhosphorIconsStyle.bold),
                color:  colors(context).secondaryColor,
              )) : SizedBox.shrink()
        ],
        title: AppLocalizations.of(context).translate("edit_payee"),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child:
            BlocListener<PayeeManagementBloc, BaseState<PayeeManagementState>>(
          listener: (context, state) {
            if (state is EditPayeeSuccessState) {
              if(state.errorCode == "844"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("account_already_exists"),
                  // message: splitAndJoinAtBrTags(state.message ?? ""),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: splitAndJoinAtBrTags(
                                    extractTextWithinTags(
                                        input: state.message ?? "")[0]),
                                style: size14weight400.copyWith(
                                    color: colors(context).greyColor)),
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
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  },
                );
              }
              else if(state.errorCode == "508"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("already_added_nickname"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  },
                );
              }
              else {
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      action: "edit",
                      id: widget.savedPayeeEntity!.id.toString(),
                      phoneNumber: AppConstants.profileData.mobileNo.toString(),
                      appBarTitle: 'otp_verification',
                      requestOTP: true,

                      ///todo: change the OTP type
                      otpType: kPayeeOTPType,
                    )).then((value) {
                  final result = value as bool;
                  if (result == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.kPayeeManagementSavedPayeeView,
                            (route) =>
                        route.settings.name == Routes.kQuickAccessCarousel ,
                        arguments:
                        PayeeManagementSavedPayeeViewArgs(isFromFundTransfer: false)
                    );
                    // Navigator.of(context)
                    //   ..pop()
                    //   ..pop(widget.savedPayeeEntity);
                    ToastUtils.showCustomToast(
                        context,
                        AppLocalizations.of(context)
                            .translate("edit_payee_success_message"),
                        ToastStatus.SUCCESS);
                  }
                });
              }
            } else if (state is EditPayeeFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
              Navigator.of(context)..pop();
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor),
                      child: Column(
                        children: [
                          DetailsField(
                            field1: AppLocalizations.of(context)
                                .translate("nickname"),
                            field2: widget.savedPayeeEntity!.nickName ?? "-",
                            //field2: widget.payeeDetails.nickName,
                          ),
                          DetailsField(
                            field1:
                                AppLocalizations.of(context).translate("bank"),
                            field2: widget.savedPayeeEntity!.bankName ?? "-",
                          ),

                          DetailsField(

                            field1: AppLocalizations.of(context)
                                .translate("Account_Number"),
                            field2:
                                widget.savedPayeeEntity!.accountNumber ?? "-",
                          ),
                          DetailsField(
                            isEnableDivider: widget.savedPayeeEntity?.bankCode !=
                                AppConstants.ubBankCode.toString() ? true:false,
                            field1: AppLocalizations.of(context)
                                .translate("account_holders_name"),
                            field2:
                                widget.savedPayeeEntity!.accountHolderName ??
                                    "-",
                          ),
                          Visibility(
                            visible: widget.savedPayeeEntity?.bankCode !=
                                AppConstants.ubBankCode.toString(),
                            child: DetailsField(
                              isEnableDivider: false,
                              field1: AppLocalizations.of(context)
                                  .translate("branch"),
                              field2: (widget.savedPayeeEntity!.branchName ==
                                          null ||
                                      widget.savedPayeeEntity!.branchName == "")
                                  ? "-"
                                  : widget.savedPayeeEntity?.branchName ??
                                      "-",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        _bloc.add(
                          EditPayeeEvent(
                            payeeId: widget.savedPayeeEntity!.id,
                            nikname: widget.savedPayeeEntity!.nickName,
                            bankcode: widget.savedPayeeEntity!.bankCode,
                            accountnumber:
                                widget.savedPayeeEntity!.accountNumber,
                            holdername:
                                widget.savedPayeeEntity!.accountHolderName,
                            addfavorite: widget.savedPayeeEntity!.isFavorite,
                            branchCode: (widget.savedPayeeEntity?.branchCode ==
                                        "" ||
                                    widget.savedPayeeEntity?.branchCode ==
                                        "-" ||
                                    widget.savedPayeeEntity?.branchCode == null)
                                ? null
                                : widget.savedPayeeEntity?.branchCode,
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonColor: Colors.transparent,
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                          title: AppLocalizations.of(context).translate("cancel_the_add_payee"),
                          alertType: AlertType.USER3,
                          message: AppLocalizations.of(context).translate("add_payee_cancel_des"),
                          positiveButtonText: AppLocalizations.of(context)
                              .translate("yes,_cancel"),
                          negativeButtonText:
                              AppLocalizations.of(context).translate("no"),
                          onNegativeCallback: () {},
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
        ),
      ),
    );
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
