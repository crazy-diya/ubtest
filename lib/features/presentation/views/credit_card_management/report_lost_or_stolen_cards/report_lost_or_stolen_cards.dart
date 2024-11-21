import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/report_lost_or_stolen_cards/collect_branch_view.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../otp/otp_view.dart';

class ReportLostOrStolenCardsView extends BaseView {
  String maskedCardNumber;

  ReportLostOrStolenCardsView({required this.maskedCardNumber});
  @override
  State<ReportLostOrStolenCardsView> createState() =>
      _ReportLostOrStolenCardsViewState();
}

class _ReportLostOrStolenCardsViewState
    extends BaseViewState<ReportLostOrStolenCardsView> {
  final bloc = injection<CreditCardManagementBloc>();
  bool _checkbox1 = false;
  bool _checkbox2 = false;


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context)
              .translate("report_lost_card_title"),
          goBackEnabled: true,
        ),
        body: BlocProvider<CreditCardManagementBloc>(
          create: (context) => bloc,
          child: BlocListener<CreditCardManagementBloc,
              BaseState<CreditCardManagementState>>(
              bloc: bloc,
              listener:(context, state){
                if(state is GetCardLostStolenSuccessState){
                  if(state.resCode == "00")
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("Send_request_successful"),
                    alertType: AlertType.SUCCESS,
                    message: AppLocalizations.of(context).translate("stolen_crd_success_des"),
                    positiveButtonText: AppLocalizations.of(context).translate("done"),
                    onPositiveCallback: () {
                      Navigator.pop(context);
                    },
                  );
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
                if(state is GetCardLostStolenFailedState){
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
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.w, 16.h, 16.w, 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        16.horizontalSpace,
                                        Expanded(
                                          child: Text( AppLocalizations.of(context).translate("purchases_lost_credit_card_description"),
                                          style: size16weight400.copyWith(color: colors(context).greyColor),),
                                        ),
                                      ],
                                    ),
                                    // 16.verticalSpace,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        8.horizontalSpace,
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4).w),
                                          checkColor: colors(context).whiteColor,
                                          activeColor: colors(context).primaryColor,
                                          value: _checkbox1,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox1 = !_checkbox1;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("replace_the_card"),
                                            style: size16weight700.copyWith(
                                                color: colors(context).greyColor),
                                          ),
                                        ), //Checkbox
                                      ], //<Widget>[]
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
                                padding: EdgeInsets.fromLTRB(0.w, 16.h, 16.w, 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        16.horizontalSpace,
                                        Expanded(
                                          child: Text( AppLocalizations.of(context).translate("send_replaced_credit_card_description"),
                                            style: size16weight400.copyWith(color: colors(context).greyColor),),
                                        ),
                                      ],
                                    ),
                                    // 16.verticalSpace,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        8.horizontalSpace,
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4).w),
                                          checkColor: colors(context).whiteColor,
                                          activeColor: colors(context).primaryColor,
                                          value: _checkbox2,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox2 = !_checkbox2;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("yes"),
                                            style: size16weight700.copyWith(
                                                color: colors(context).greyColor),
                                          ),
                                        ), //Checkbox
                                      ], //<Widget>[]
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
                        buttonType: _checkbox1?ButtonType.PRIMARYENABLED:ButtonType.PRIMARYDISABLED,
                        buttonText: AppLocalizations.of(context).translate("continue"),
                        onTapButton: () async {
                          _checkbox2
                              ?Navigator.pushNamed(context, Routes.kCollectionBranchView ,
                              arguments: LostStolenArgs(
                                maskCardNumber: widget.maskedCardNumber,
                                isBranhSelected: _checkbox1,
                                reIsueReq: _checkbox1 == true ? "Y" : "",
                              )):
                          Navigator.pushNamed(context, Routes.kOtpView,
                              arguments: OTPViewArgs(
                                  phoneNumber: AppConstants.profileData.mobileNo
                                      .toString(),
                                  appBarTitle: "otp_verification",
                                  otpType: "lostorstolencard",
                                  requestOTP: true))
                              .then((value) {
                            if (value == true) {
                              bloc.add(GetCardLostStolenEvent(
                                  maskedCardNumber: widget.maskedCardNumber,
                                  reissueRequest: _checkbox1 == true ? "Y" : "",
                                  isBranch: false,
                                  branchCode: ""
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
                        buttonText: AppLocalizations.of(context).translate("cancel"),
                        onTapButton: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
