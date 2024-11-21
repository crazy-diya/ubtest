
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_scroll_bar.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../core/service/platform_services.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_sizer.dart';
import '../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../bloc/on_boarding/contact_information/contact_information_event.dart';
import '../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../user_onboarding/data/just_pay_data.dart';

class OtherTermsArgs {
  final String? termsType;
  final String? challengeReqId;
  final JustPayData? justPayData;

  OtherTermsArgs({this.termsType, this.justPayData, this.challengeReqId});
}
class TnCManageOtherBankView extends BaseView {
  final OtherTermsArgs otherTermsArgs;

  TnCManageOtherBankView({required this.otherTermsArgs, });

  @override
  _TnCManageOtherBankViewState createState() => _TnCManageOtherBankViewState();
}

//791662338V
class _TnCManageOtherBankViewState extends BaseViewState<TnCManageOtherBankView> {
   LocalDataSource localDataSource = injection<LocalDataSource>();
  String _termsData = '';
  int? _termID = 0;
  final _contactbloc = injection<ContactInformationBloc>();
  final ScrollController scrollController = ScrollController();

  ButtonType _acceptButtonType = ButtonType.PRIMARYDISABLED;

  @override
  void initState() {
    super.initState();
    _contactbloc.add(GetOnboardTermsEvent(termType: ObType.justPay.name));
    scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _acceptButtonType = ButtonType.PRIMARYENABLED;
      });
    }
    scrollController.position.pixels;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("terms_and_conditions"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ContactInformationBloc>(
        create: (context) => _contactbloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (context, state) {
            if (state is OnboardTermsLoadedState) {
                setState(() {
                  _termsData = state.termsData!.termBody != null
                      ? state.termsData!.termBody!
                      : '';
                  _termID = state.termsData!.termId!;
                  termIdAll = state.termsData!.termId!;
                });
                if (scrollController.position.pixels == 0) {
                  setState(() {
                    _acceptButtonType = ButtonType.PRIMARYENABLED;
                  });
                }
              }
            else if (state is OnboardTermsSubmittedState) {
                  
                if (widget.otherTermsArgs.termsType!.isNotEmpty) {
                  // Navigator.pop(context, true);
                  showAppDialog(
                    title: AppLocalizations.of(context).translate(
                        "success"),
                    alertType: AlertType.SUCCESS,
                    message: AppLocalizations.of(context)
                        .translate("add_other_bank_sucess_message"),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("ok"),
                    // negativeButtonText: AppLocalizations.of(context)
                    //     .translate("no"),
                    onPositiveCallback: () {
                      Navigator.of(context)..pop()..pop(true);
                      localDataSource.setNewDeviceState(JustPayState.FINISH.name);
                    },
                  );
                }
              }
            else if (state is OnboardTermsFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
              }
            if (state is JustPayChallengeIdSuccessState) {
              log("JustPay Challenge Id Success");
              if (state.justPayChallengeIdResponse?.challengeId != null) {
                _contactbloc.add(JustPaySDKCreateIdentityEvent(
                    challengeId:
                    state.justPayChallengeIdResponse?.challengeId));
                setState(() {});
              }
            }
            else if (state is JustPaySDKCreateIdentitySuccessState) {
              log("SDK SIGN");
              _contactbloc.add(JustPaySDKTCSignEvent(termAndCondition: _termsData));
            }
            else if (state is JustPaySDKTCSignSuccessState) {
              log("API SIGN");
              _contactbloc.add(JustPayTCSignEvent( termAndCondition: state.justPayPayload?.data.toString()));
            }
            else if (state is JustPayTCSignSuccessState) {
              _contactbloc.add(AcceptOnboardTermsEvent(
                termType: kJustPayTermType,
                justpayInstrumentId: widget.otherTermsArgs.justPayData?.accountNo,
                  acceptedDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(DateTime.now()),
                  instrumentId: widget.otherTermsArgs.challengeReqId,
                  termId: _termID));
            }
            else if (state is JustPayChallengeIdFailedState) {
              log("Challenge Id failed");
              Navigator.pop(context);
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
            else if (state is JustPayTCSignFailedState) {
              log("JustPayTC failed");
              Navigator.pop(context);
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
            else if (state is JustPaySDKTCSignFailedState) {
              log("JustPaySDKTC failed");
              Navigator.pop(context);
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0.h),
                child: AppScrollView(
                  controller: scrollController,
                  child: Html(
                    data: _termsData,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                AppButton(
                  buttonType: _termsData.isNotEmpty
                      ? _acceptButtonType
                      : ButtonType.PRIMARYENABLED,
                  buttonText:
                  AppLocalizations.of(context).translate("agree"),
                  onTapButton: () {
                    _onRequestPermissionsResult();
                  },
                ),
                16.verticalSpace,
                AppButton(
                  buttonType: ButtonType.OUTLINEENABLED,
                  buttonText:
                  AppLocalizations.of(context).translate("Decline"),
                  onTapButton: () {
                    showAppDialog(
                      title: AppLocalizations.of(context)
                          .translate("Decline_Terms_&_Conditions"),
                      alertType: AlertType.DOCUMENT1,
                      message: AppLocalizations.of(context)
                          .translate("manage_instrument_terms_decline"),

                      positiveButtonText: AppLocalizations.of(context)
                          .translate("yes_decline"),
                      negativeButtonText:
                      AppLocalizations.of(context).translate("no"),
                      onPositiveCallback: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
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
  _onRequestPermissionsResult() {
    AppPermissionManager.requestReadPhoneStatePermission(context, () async {
      showProgressBar();
      if (await PlatformServices.isJustPayIdentityExists()) {
        log("SDK SIGN");
        _contactbloc.add(JustPaySDKTCSignEvent(termAndCondition: _termsData));
      } else {
        try {
          String data = await PlatformServices.getJustPayDeviceId();
          if (data.isNotEmpty && data != "ERR_DID") {
            _contactbloc.add(JustPayChallengeIdEvent(
              isOnboarded: true,
                challengeReqDeviceId: data));
          } else {
            hideProgressBar();
            Navigator.pop(context);
            ToastUtils.showCustomToast(
                context, AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED), ToastStatus.FAIL);
          }
        } catch (e) {
          hideProgressBar();
          Navigator.pop(context);
          ToastUtils.showCustomToast(
              context, AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED), ToastStatus.FAIL);
        }
      }
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _contactbloc;
  }
}