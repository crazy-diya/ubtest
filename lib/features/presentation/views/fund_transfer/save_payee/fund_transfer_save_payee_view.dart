import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';



import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../bloc/payee_management/payee_management_bloc.dart';
import '../../../bloc/payee_management/payee_management_event.dart';
import '../../../bloc/payee_management/payee_management_state.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/app_switch/app_switch.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../data/fund_transfer_recipt_view_args.dart';
import '../widgets/ft_saved_payee_compnent.dart';


class FDsavePayeeView extends BaseView {
  final FundTransferReceiptViewArgs fundTransferReceiptViewArgs;


  FDsavePayeeView({required this.fundTransferReceiptViewArgs});

  @override
  _FDsavePayeeViewState createState() => _FDsavePayeeViewState();
}

class _FDsavePayeeViewState extends BaseViewState<FDsavePayeeView> {
  var bloc = injection<PayeeManagementBloc>();
  bool toggleValue = false;
  String? nickName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("save_payee"),
      ),
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
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("add_payee_success_message"),
                    ToastStatus.SUCCESS);
                Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
              }
            }
            if (state is AddPayeeFailedState) {
              if (state.code == "512") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("nickname_already_exists"),
                    alertType: AlertType.FAIL,
                    message: AppLocalizations.of(context)
                        .translate("do_you_really_want_to_cancel"),
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
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
                    },
                    onNegativeCallback: () {});
              } else if (state.code == "511") {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("account_already_exists"),
                    alertType: AlertType.USER1,
                    message: state.message,
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                    },
                    onNegativeCallback: () {});
              } else {
                showAppDialog(
                    title: AppLocalizations.of(context).translate("system_error"),
                    alertType: AlertType.FAIL,
                    message:
                    AppLocalizations.of(context).translate("the_new_payee_not_added_des"),
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                    //negativeButtonText: '',
                    onPositiveCallback: () {
                    },
                    onNegativeCallback: () {});
              }
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.w + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  16.verticalSpace,
                                  FTSavedPayeeComponent(
                                    field1: AppLocalizations.of(context).translate("Account_Number"),
                                    field2: widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctnmbr ??
                                        "-",
                                  ),
                                  12.verticalSpace,
                                  FTSavedPayeeComponent(
                                    field1:AppLocalizations.of(context).translate("account_holder_name"),
                                    field2: widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctname ?? "-",
                                  ),
                                  12.verticalSpace,
                                  FTSavedPayeeComponent(
                                    isLastItem: true,
                                    field1: AppLocalizations.of(context).translate("bank"),
                                    field2: widget.fundTransferReceiptViewArgs.fundTransferEntity.bankName ?? "-",
                                  ),


                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       AppLocalizations.of(context).translate("add_favorite"),
                                  //       style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w600,
                                  //         color: colors(context).blackColor,
                                  //       ),
                                  //     ),
                                  //     CupertinoSwitch(
                                  //       value: toggleValue,
                                  //       trackColor: colors(context).greyColor?.withOpacity(.65),
                                  //               activeColor:colors(context).primaryColor,
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           toggleValue = value;
                                  //         });
                                  //       },
                                  //     ),
                                  //     // Optional spacing between the switch and description
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            16.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0).w,
                                    child: AppTextField(
                                      hint: AppLocalizations.of(context).translate("nickname"),
                                      title: AppLocalizations.of(context).translate("nickname"),
                                      key: const Key("keyNickName"),
                                      inputType: TextInputType.text,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Z a-z ]")),
                                      ],
                                      validator: (value) {
                                        if(value==null || value=="")
                                        {
                                          return AppLocalizations.of(context).translate("mandatory_field_msg");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTextChanged: (value) {
                                        setState(() {
                                          nickName = value;
                                        });
                                      },
                                    ),
                                  ),
                                  AppSwitch(
                                    title: AppLocalizations.of(context).translate("add_favorite"),
                                    value: toggleValue,
                                    addExtraPadding: false,
                                    onChanged: (value) {
                                      setState(() {
                                        toggleValue = value;
                                      });
                                    },
                                    switchItems: [],
                                  ),
                                ],
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
                          buttonText: AppLocalizations.of(context).translate("save"),
                          onTapButton: () {
                             if(_formKey.currentState?.validate() == false){
                                      return;
                             }
                            bloc.add(
                              AddPayeeEvent(
                                verified: true,
                                  nikname: nickName,
                                  bankcode: widget.fundTransferReceiptViewArgs.fundTransferEntity.bankCode.toString(),
                                  accountnumber: widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctnmbr,
                                  holdername: widget.fundTransferReceiptViewArgs.fundTransferEntity.payToacctname,
                                  addfavorite: toggleValue,
                                // widget.payeeDetails!.branchCode,
                              ),
                            );
                          }),
                      16.verticalSpace,
                      AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("home"),
                          onTapButton: () {
                            showAppDialog(
                              title: AppLocalizations.of(context).translate("cancel_the_edit"),
                              alertType: AlertType.INFO,
                              message: AppLocalizations.of(context).translate("cancel_the_edit_des"),
                              positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                              negativeButtonText: AppLocalizations.of(context).translate("no"),
                              onPositiveCallback: () {
                                Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                              },
                            );
                          },
                        )
                    ],
                  ),
                ],
              ),),
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
