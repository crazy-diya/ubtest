import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/service/app_permission.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/just_pay_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_scroll_bar.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';

class TermsJustPayArgs {
  final String? termsType;
  final JustPayData? justPayData;

  TermsJustPayArgs({this.termsType, this.justPayData});
}

class JustPayTnCView extends BaseView {
  final TermsJustPayArgs termsJustPayArgs;

  JustPayTnCView({required this.termsJustPayArgs});

  @override
  _JustPayTnCViewState createState() => _JustPayTnCViewState();
}

class _JustPayTnCViewState extends BaseViewState<JustPayTnCView> {
  final _bloc = injection<ContactInformationBloc>();
  final ScrollController scrollController = ScrollController();

  ButtonType _acceptButtonType = ButtonType.PRIMARYDISABLED;
  String _termsData = '';
  int? _termID = 0;
 

  @override
  void initState() {
    super.initState();
    _bloc.add(GetOnboardTermsEvent(
      termType: ObType.justPay.name,
    ));
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
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("terms_and_conditions"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ContactInformationBloc>(
        create: (context) => _bloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (context, state) {
             if (state is OnboardTermsLoadedState) {
                  setState(() {
                    _termsData = state.termsData?.termBody != null
                        ? state.termsData!.termBody!
                        : '';
                    _termID = state.termsData!.termId!;
                    // _acceptButtonType = ButtonType.ENABLED;
                    log(_termsData);
                  });
                  if (scrollController.position.pixels == 0) {
                    setState(() {
                      _acceptButtonType = ButtonType.PRIMARYENABLED;
                    });
                  }
                }
             else if (state is OnboardTermsSubmittedState) {
                  log("Finish Process");
                  Navigator.pushReplacementNamed(context,Routes.kOtherBankSetupLoginDetailsView);

                }
             else if (state is OnboardTermsFailedState) {
                  Navigator.pop(context);
                  ToastUtils.showCustomToast(
                      context, state.message!, ToastStatus.FAIL);
                }
            if (state is JustPayChallengeIdSuccessState) {
              log("JustPay Challenge Id Success");
              if (state.justPayChallengeIdResponse?.challengeId != null) {
                _bloc.add(JustPaySDKCreateIdentityEvent(
                    challengeId:
                        state.justPayChallengeIdResponse?.challengeId));
                setState(() {});
              }
            }
            else if (state is JustPaySDKCreateIdentitySuccessState) {
              log("SDK SIGN");
              _bloc.add(JustPaySDKTCSignEvent(termAndCondition: _termsData));
            }
            else if (state is JustPaySDKTCSignSuccessState) {
              log("API SIGN");
               _bloc.add(JustPayTCSignEvent( termAndCondition: state.justPayPayload?.data.toString()));
            }
            else if (state is JustPayTCSignSuccessState) {
              _bloc.add(AcceptOnboardTermsEvent(
                  termType: kJustPayTermType,
                justpayInstrumentId: widget.termsJustPayArgs.justPayData?.accountNo,
                  acceptedDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(DateTime.now()),
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
            padding:  EdgeInsets.fromLTRB(10.w,0.h,10.w,(20.h + AppSizer.getHomeIndicatorStatus(context))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppScrollView(
                    primary: false,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Html(
                        onLinkTap: (url, attributes, element) {
                          _launchUrl(url);
                        },
                        data: _termsData,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                     20.verticalSpace,
                      AppButton(
                        buttonType: _termsData.isNotEmpty
                            ? _acceptButtonType
                            : ButtonType.PRIMARYENABLED,
                        buttonText:
                            AppLocalizations.of(context).translate("agree"),
                        onTapButton: () async {
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
                                .translate("You_can’t_complete_registration"),
                            positiveButtonText: AppLocalizations.of(context)
                                .translate("Exit"),
                            negativeButtonText: AppLocalizations.of(context)
                                .translate("Cancel"),
                            onPositiveCallback: () {
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName(
                                      Routes.kRegistrationMethodView));
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
        _bloc.add(JustPaySDKTCSignEvent(termAndCondition: _termsData));
      } else {
        try {
          String data = await PlatformServices.getJustPayDeviceId();
          if (data.isNotEmpty && data != "ERR_DID") {
            _bloc.add(JustPayChallengeIdEvent(isOnboarded: false,
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

  // _termsVerificationRequest() {
  //   if (widget.justPayArgs.justPayBean.challangeId != null) {
  //     _createJustPayIdentity(widget.justPayArgs.justPayBean.challangeId!);
  //   } else {
  //     _onIdentitySuccess();
  //   }
  // }

  // _createJustPayIdentity(String s) async {
  //   showProgressBar();
  //   try {
  //     JustPayPayload justPayPayload =
  //         await PlatformServices.justPayCreateIdentity(s); // exception occure
  //     if (justPayPayload.isSuccess) {
  //       hideProgressBar();
  //       _onIdentitySuccess();
  //     } else {
  //       hideProgressBar();
  //       showAppDialog(
  //         title: 'Oops!',
  //         message: 'Something went wrong',
  //         alertType: AlertType.FAIL,
  //       );
  //     }
  //   } on Exception catch (e) {
  //     hideProgressBar();
  //   }
  // }

  // _onIdentitySuccess() async {
  //   AppPermissionManager.requestReadPhoneStatePermission(context, () async {
  //     showProgressBar();
  //     try {
  //       JustPayPayload justPayPayload =
  //           await PlatformServices.justPaySignedTerms(
  //               widget.justPayArgs.justPayBean.justPayTerms!);
  //       if (justPayPayload.isSuccess) {
  //         hideProgressBar();
  //         if (widget.justPayArgs.isDeviceChange) {
  //           bloc.add(ParseSignedTermsRequestDeviceChangeEvent(
  //               encTc: justPayPayload.data));
  //         } else {
  //           hideProgressBar();
  //           bloc.add(
  //             ParseSignedTermsRequestEvent(
  //               accountType: AppConstants.INSTRUMENT_TYPE_ACCOUNT,
  //               cardToken: widget.justPayArgs.justPayBean.paymentToken,
  //               challengeIdExistFlag:
  //                   await PlatformServices.isJustPayIdentityExists()
  //                       ? "0"
  //                       : "1",
  //               signedTerms: justPayPayload.data,
  //             ),
  //           );
  //         }
  //       } else {
  //         hideProgressBar();
  //         showAppDialog(
  //           title: 'Oops!',
  //           message: 'Something went wrong',
  //           alertType: AlertType.FAIL,
  //         );
  //       }
  //     } on Exception catch (e) {
  //       hideProgressBar();
  //     }
  //   });
  // }

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
