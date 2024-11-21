import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/save_and_exits_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/input_formatters.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_validator.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_event.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../base_view.dart';
// Import the package

class JustPayRegisterOtherBankDetailsView extends BaseView {
  JustPayRegisterOtherBankDetailsView({super.key});

  @override
  _JustPayRegisterOtherBankDetailsViewState createState() =>
      _JustPayRegisterOtherBankDetailsViewState();
}

class _JustPayRegisterOtherBankDetailsViewState
    extends BaseViewState<JustPayRegisterOtherBankDetailsView> {
  final _bloc = injection<ContactInformationBloc>();
  final localDataSource = injection<LocalDataSource>();
  final AppValidator appValidator = AppValidator();
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  late TextEditingController _identificationNumController;
  final _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // _mobileController.dispose();
    // _emailController.dispose();
    // _identificationNumController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _mobileController = TextEditingController(
        text: localDataSource.getSaveAndExist().mobilenumber ?? null);
    _emailController = TextEditingController(
        text: localDataSource.getSaveAndExist().email ?? null);
    _identificationNumController = TextEditingController(
        text: localDataSource.getSaveAndExist().nic ?? null);
    _scrollController.addListener(_onScrollDraft);
    super.initState();
  }

  _onScrollDraft(){
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("Other_Bank_Account"),
      ),
      body: BlocProvider<ContactInformationBloc>(
        create: (_) => _bloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (context, state) {
            if (state is JustPayVerificationSuccessState) {
              Navigator.pushNamed(
                  context, Routes.kDocumentVerificationOtherBankView,
                  arguments: SaveAndExist(
                    mobilenumber: _mobileController.text.trim(),
                    email: _emailController.text.trim(),
                    nic: _identificationNumController.text.trim(),
                  ));
            }
            else if (state is JustPayVerificationFailedState) {
              if (state.errorCode == "06") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("already_uBgo_user"),
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchCaller(splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1]));
                              },
                            text:" ${splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1])}" ,
                            style:size14weight700.copyWith(color: colors(context).primaryColor) 
                          ),
                        ])

                       )
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText:
                      AppLocalizations.of(context).translate("login"),
                );
              }
              else if (state.errorCode == "07") {
                showAppDialog(
                  title: AppLocalizations.of(context).translate("already_a_union_bank_customer"),
                  alertType: AlertType.USER1,
                  message: AppLocalizations.of(context)
                      .translate("already_a_union_bank_customer_desc"),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate("use_my_union_bank_account"),
                  negativeButtonText: AppLocalizations.of(context)
                      .translate("continue_with_other_bank_acc"),
                  onPositiveCallback: () {
                    Navigator.of(context)
                        .popAndPushNamed(Routes.kUbRegisterDetailsView);
                  },
                );
              }
              else if(state.errorCode=="842"){
                showAppDialog(
                alertType: AlertType.USER1,
                title: AppLocalizations.of(context).translate("already_a_union_bank_customer"),
                message: splitAndJoinAtBrTags(state.message ?? ""),
                positiveButtonText: AppLocalizations.of(context).translate("use_my_union_bank_account"),
                onPositiveCallback: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.kLoginView, (route) => false);
                }
            );}
              else if(state.errorCode=="502"){
                showAppDialog(
                alertType: AlertType.FAIL,
                title: AppLocalizations.of(context).translate("incorrect_details"),
                message: splitAndJoinAtBrTags(state.message ?? ""),
                positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                onPositiveCallback: (){
                }
            );}
              else {
                showAppDialog(
                  alertType: AlertType.FAIL,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: state.message ?? "",
                  positiveButtonText: 'Ok',
                );
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 3.40.verticalSpace,
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.ubOnboardingRegistration,
                              ),
                            ),
                            28.verticalSpace,
                            Text(
                              AppLocalizations.of(context)
                                  .translate("Please_below_details"),
                              style: size16weight400.copyWith(
                                color: colors(context).greyColor,
                              ),
                            ),
                            24.verticalSpace,
                                AppTextField(
                                  isNationalFlag: true,
                                    title:  AppLocalizations.of(context).translate("Mobile_Number"),
                                    controller: _mobileController,
                                    isInfoIconVisible: false,
                                    hint: AppLocalizations.of(context).translate("Enter_mobile_number"),
                                    textCapitalization: TextCapitalization.none,
                                    isLabel: false,
                                    maxLength: 9,
                                    inputType: TextInputType.phone,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                  ],
                                    validator: (value) {
                                      if (_mobileController.text == "") {
                                        return AppLocalizations.of(context).translate("mobile_number_required");
                                      } else {
                                        if (!appValidator.validateMobileNmb(_mobileController.text)) {
                                          return AppLocalizations.of(context).translate("enter_valid_mobile");
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                ),
                            24.verticalSpace,
                            AppTextField(
                              title: AppLocalizations.of(context).translate("email_address"),
                              controller: _emailController,
                              isInfoIconVisible: false,
                              icon: const Icon(
                                Icons.access_time,
                                size: 18,
                              ),
                              hint:
                                  AppLocalizations.of(context).translate("Enter_email_address"),
                              textCapitalization: TextCapitalization.none,
                              isLabel: false,
                              validator: (value) {
                                if (_emailController.text == "") {
                                  return AppLocalizations.of(context).translate("email_required");
                                } else {
                                  if (!appValidator.validateEmail(_emailController.text)) {
                                    return AppLocalizations.of(context).translate("enter_valid_email");
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              inputType: TextInputType.emailAddress,
                            ),
                            24.verticalSpace,
                            AppTextField(
                              isLabel:false,
                              title: AppLocalizations.of(context)
                                  .translate("NIC_number"),
                              controller: _identificationNumController,
                              isInfoIconVisible: false,
                              hint: AppLocalizations.of(context)
                                  .translate("Enter_national_identity_card_number"),
                              textCapitalization: TextCapitalization.characters,
                              inputFormatter: [SriLankanNICFormatter()],
                              validator: (value) {
                                if (_identificationNumController.text == "") {
                                  return AppLocalizations.of(context).translate("nic_required");
                                } else {
                                  if (!appValidator
                                      .advancedNicValidation(_identificationNumController.text)) {
                                    return AppLocalizations.of(context).translate("nic_required_des");
                                  } else {
                                    return null;
                                  }
                                }
                              },
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
                            AppLocalizations.of(context).translate("continue"),
                        onTapButton: () {
                          if (_formKey.currentState?.validate() == false) {
                            return;
                          }
                         WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          final mobileNumber = _mobileController.text.trim();
                          final email = _emailController.text.trim();
                          final identificatioNum =
                              _identificationNumController.text.trim();
                          _bloc.add(ValidateJustPayEvent(
                            obType: ObType.JUSTPAY.name,
                            mobileNumber: "0$mobileNumber",
                            email: email,
                            nic: identificatioNum,
                          ));
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
    return _bloc;
  }
}
