import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/theme/theme_data.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../../../utils/enums.dart';
import '../../../../../../utils/text_editing_controllers.dart';
import '../../../../../data/models/requests/settings_update_txn_limit_request.dart';
import '../../../../bloc/settings/settings_bloc.dart';
import '../../../../bloc/settings/settings_event.dart';
import '../../../../bloc/settings/settings_state.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/text_fields/app_text_field.dart';
import '../../../../widgets/toast_widget/toast_widget.dart';
import '../../../base_view.dart';
import '../data/settings_tran_limit_entity.dart';

class TransactionLimitDetailsView extends BaseView {
  final TranLimitEntity transactionLimit;

  TransactionLimitDetailsView({required this.transactionLimit});

  @override
  _RequestMoneyHistoryViewState createState() =>
      _RequestMoneyHistoryViewState();
}

class _RequestMoneyHistoryViewState
    extends BaseViewState<TransactionLimitDetailsView> {
  var bloc = injection<SettingsBloc>();
  CurrencyTextEditingController maxPerTranController =
  CurrencyTextEditingController();
  CurrencyTextEditingController maxDailyController =
  CurrencyTextEditingController();
  CurrencyTextEditingController twoFactorController =
  CurrencyTextEditingController();
  final _formKey = GlobalKey<FormState>();

  //bool? isEditEnable = false;
  bool? isEdited = false;
  List<TranLimitEntity> tansactionList = [];
  final _toolTipController = SuperTooltipController();

  @override
  void initState() {
    super.initState();
    maxDailyController.text = widget.transactionLimit.maxUserAmountPerDay!;
    maxPerTranController.text = widget.transactionLimit.maxUserAmountPerTran!;
    twoFactorController.text = widget.transactionLimit.twoFactorLimmit.toString();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("transaction_limits"),
        onBackPressed: () {
          if (isEdited == true) {
            showAppDialog(
                alertType: AlertType.INFO,
                title: AppLocalizations.of(context).translate("Exit"),
                message: AppLocalizations.of(context).translate("exit_des"),
                negativeButtonText:
                AppLocalizations.of(context).translate("no"),
                positiveButtonText:
                AppLocalizations.of(context).translate("yes,_cancel"),
                onNegativeCallback: () {},
                onPositiveCallback: () {
                  Navigator.pop(context, null);
                });
          } else {
            Navigator.pop(context);
          }
        },
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (_, state) {
            if (state is GetTransLimitSuccessState) {
              ///todo: metana tw response code thyenna plwn ewa define krma e tika dann oni
              if (state.code == "01") {
                ToastUtils.showCustomToast(context,
                    state.message ?? "connection exception!", ToastStatus.FAIL);
              } else if (state.code == "001") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else {
                tansactionList.clear();
                tansactionList.addAll(state.tranLimitDetails!
                    .map((e) =>
                    TranLimitEntity(
                        transactionType: e.transactionType,
                        description: e.description,
                        maxUserAmountPerDay: e.maxUserAmountPerDay,
                        maxUserAmountPerTran: e.maxUserAmountPerTran,
                        maxGlobalLimitPerTran: e.maxGlobalLimitPerTran,
                        twoFactorLimmit: e.twoFactorLimit,
                        isTwofactorEnabble: e.enabledTwoFactorLimit,
                        minUserAmountPerTran: e.minUserAmountPerTran,
                        globalTwoFactorLimit: e.globalTwoFactorLimit,
                        maxGlobalLimitPerDay: e.maxGlobalLimitPerDay))
                    .toList());

                setState(() {});
              }
            }
            if (state is GetTransLimitFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("connection_exception"), ToastStatus.FAIL);
            }
            if (state is ResetTxnLimitSuccessState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("success"), ToastStatus.SUCCESS);
              Navigator.pop(context);
            }
            if (state is ResetTxnLimitFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("connection_exception"), ToastStatus.FAIL);
            }
            if (state is UpdateTxnLimitSuccessState) {
              if (state.code == "01") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else if (state.code == "001") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("success"), ToastStatus.SUCCESS);
                bloc.add(GetTranLimitEvent(
                  channelType: "MB",
                  messageType: "txnDetailsReq",
                ));
              }
            }
            if (state is UpdateTxnLimitFailedState) {
              showAppDialog(
                title: AppLocalizations.of(context).translate("something_gone_wrong"),
                message: state.message ?? AppLocalizations.of(context).translate("something_gone_wrong"),
                alertType: AlertType.FAIL,
                onPositiveCallback: () {},
                positiveButtonText: AppLocalizations.of(context).translate("ok"),
              );
            }
          },
          child: GestureDetector(
            onTap: () {
              if (_toolTipController.isVisible) {
                _toolTipController.hideTooltip();
              }
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context),),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(8)
                                        .r,
                                    color: colors(context).whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(8)
                                            .r,
                                        color: colors(context).primaryColor),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(16.w,24.h,16.w,24.h)
                                          ,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "LKR ${widget.transactionLimit
                                                .maxUserAmountPerDay ?? ""}",
                                            style: size18weight700.copyWith(
                                                color:
                                                colors(context).whiteColor),
                                          ),
                                          Text(
                                              widget.transactionLimit
                                                  .description ??
                                                  "",
                                              style: size12weight400.copyWith(
                                                  color: colors(context)
                                                      .whiteColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(8)
                                        .r,
                                    color: colors(context).whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppTextField(
                                        validator: (a) {
                                          if (double.parse(
                                              maxPerTranController.text
                                                  .replaceAll(',', '')) <
                                              double.parse(widget.transactionLimit
                                                  .minUserAmountPerTran!.replaceAll(',', ''))) {
                                            return "${AppLocalizations.of(context).translate("must_be_least_LKR")} ${widget
                                                .transactionLimit
                                                .minUserAmountPerTran}";
                                          } else if (double.parse(
                                              maxPerTranController.text
                                                  .replaceAll(',', '')) >
                                              double.parse(widget.transactionLimit
                                                  .maxGlobalLimitPerTran!.replaceAll(',', ''))) {
                                            return "${AppLocalizations.of(context).translate("cannot_exceed_LKR")} ${widget
                                                .transactionLimit
                                                .maxGlobalLimitPerTran}";
                                          } else if ((widget.transactionLimit
                                              .isTwofactorEnabble ==
                                              true) &&
                                              double.parse(
                                                  maxPerTranController.text
                                                      .replaceAll(',', '')) <
                                                  double.parse(
                                                      twoFactorController.text
                                                          .replaceAll(',', ''))) {
                                            return "${AppLocalizations.of(context).translate("must_above_defined_2FA_LKR")} ${twoFactorController
                                                .text.replaceAll(',', '')})";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: maxPerTranController,
                                        initialValue: maxPerTranController.text,
                                        isCurrency: true,
                                        showCurrencySymbol: true,
                                        isInfoIconVisible: false,
                                        title: AppLocalizations.of(context)
                                            .translate("maximum_per_transaction"),
                                        hint: AppLocalizations.of(context)
                                            .translate("maximum_per_transaction"),
                                        inputType: TextInputType.number,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        onTextChanged: (value) {
                                          isEdited = true;
                                          setState(() {});
                                        },
                                      ),
                                      12.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("maximum_limit_LKR")} ${widget
                                            .transactionLimit
                                            .maxGlobalLimitPerTran
                                            ?.withThousandSeparator()}",
                                        style: size14weight400.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        validator: (a) {
                                          if (double.parse(maxDailyController.text
                                              .replaceAll(',', '')) > double.parse(widget.transactionLimit.maxGlobalLimitPerDay!)) {
                                            return "${AppLocalizations.of(context).translate("cannot_exceed_LKR")} ${widget.transactionLimit.maxGlobalLimitPerDay}";
                                          } else if (double.parse(
                                              maxDailyController.text.replaceAll(',', '')) == 0) {
                                            return "${AppLocalizations.of(context).translate("must_greater_than")} 0";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: maxDailyController,
                                        isCurrency: true,
                                        showCurrencySymbol: true,
                                        isInfoIconVisible: false,
                                        title: AppLocalizations.of(context)
                                            .translate("maximum_daily_limit"),
                                        hint: AppLocalizations.of(context)
                                            .translate("maximum_daily_limit"),
                                        inputType: TextInputType.number,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        onTextChanged: (value) {
                                          isEdited = true;
                                          setState(() {});
                                        },
                                      ),
                                      12.verticalSpace,
                                      Text(
                                        "${AppLocalizations.of(context).translate("maximum_limit_LKR")} ${widget
                                            .transactionLimit.maxGlobalLimitPerDay
                                            ?.withThousandSeparator()}",
                                        style: size14weight400.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(8)
                                        .r,
                                    color: colors(context).whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                "two_factor_authentication"),
                                            style: size16weight700.copyWith(
                                                color:
                                                colors(context).blackColor),
                                          ),
                                          CupertinoSwitch(
                                              value: widget.transactionLimit
                                                  .isTwofactorEnabble ??
                                                  false,
                                              trackColor: colors(context)
                                                  .greyColor
                                                  ?.withOpacity(.65),
                                              activeColor:
                                              colors(context).primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  isEdited = true;
                                                  widget.transactionLimit
                                                      .isTwofactorEnabble = value;
                                                });
                                              }),
                                        ],
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        validator: (a) {
                                          if ((widget.transactionLimit.isTwofactorEnabble == true) && (double.parse(twoFactorController
                                              .text.replaceAll(',', '')) < double.parse(widget.transactionLimit.globalTwoFactorLimit!))) {
                                            return "${AppLocalizations.of(context).translate("must_be_least_LKR")} ${widget.transactionLimit.globalTwoFactorLimit}";
                                          } else if ((widget.transactionLimit.isTwofactorEnabble ==
                                              true) && (double.parse(twoFactorController.text.replaceAll(',', '')) >
                                              double.parse(maxPerTranController.text.replaceAll(',', '')))) {
                                            return "${AppLocalizations.of(context).translate("cannot_exceed_LKR")} ${maxPerTranController.text.replaceAll(',', '')}";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: twoFactorController,
                                        initialValue: twoFactorController.text,
                                        isCurrency: true,
                                        showCurrencySymbol: true,
                                        isInfoIconVisible: false,
                                        isReadOnly: (widget.transactionLimit
                                            .isTwofactorEnabble!)
                                            ? false
                                            : true,
                                        hint: AppLocalizations.of(context)
                                            .translate(
                                            "two_factor_authentication"),
                                        title: AppLocalizations.of(context)
                                            .translate(
                                            "two_factor_authentication"),
                                        inputType: TextInputType.number,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        superToolTipController:
                                        _toolTipController,
                                        isShowingInTheField: true,
                                        successfullyValidated: ((double.parse(
                                            twoFactorController.text.replaceAll(',', '')) <
                                            double.parse(widget.transactionLimit.globalTwoFactorLimit!)) ||
                                            (double.parse(twoFactorController.text.replaceAll(',', '')) >
                                                double.parse(maxPerTranController.text.replaceAll(',', '')))) ? false : true,
                                        infoIconText: [
                                          AppLocalizations.of(context).translate("tran_limit_tooltip_des")
                                        ],
                                        toolTipTitle: "",
                                        onTextChanged: (value) {
                                          isEdited = true;
                                          setState(() {});
                                        },
                                      ),
                                      26.verticalSpace
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isEdited == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 20).w,
                        child: Column(
                          children: [
                            AppButton(
                                buttonText: AppLocalizations.of(context)
                                    .translate("save"),
                                onTapButton: () {
                                  if(_formKey.currentState?.validate() == false){
                                    return;
                                  }
                                  // if(double.parse(maxPerTranController.text.replaceAll(',', '')) < double.parse(widget.transactionLimit.minUserAmountPerTran!)){
                                  //   setState(() {
                                  //     showAppDialog(
                                  //         title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                                  //         alertType: AlertType.WARNING,
                                  //         message: AppLocalizations.of(context).translate("tran_limit_error_msg"),
                                  //         positiveButtonText: AppLocalizations.of(context).translate("ok"),
                                  //         onPositiveCallback: () {});
                                  //   });
                                  // }
                                  // Navigator.pushNamed(context, Routes.kOtpView,
                                  //     arguments: OTPViewArgs(
                                  //         phoneNumber: AppConstants.profileData
                                  //             .mobileNo.toString(),
                                  //         appBarTitle: 'transaction_limits',
                                  //         requestOTP: true,
                                  //         otpType: 'ftr'
                                  //     )).then((value) {
                                  //   if (value is bool && value) {
                                  //     setState(() {
                                  //       bloc.add(UpdateTxnLimitEvent(
                                  //           messageType: 'txnDetailsReq',
                                  //           channelType: 'MB',
                                  //           txnLimit: [
                                  //             TransactionLimit(
                                  //               transactionType: widget.transactionLimit.transactionType,
                                  //               maxAmountPerTran: double.parse(maxPerTranController.text.replaceAll(',', '')),
                                  //               maxAmountPerDay: double.parse(maxDailyController.text.replaceAll(',', '')),
                                  //               twoFactorLimit: double.parse(twoFactorController.text.replaceAll(',', '')),
                                  //               twoFactorEnable: widget.transactionLimit.isTwofactorEnabble,
                                  //               minAmountPerTran: int.parse(widget.transactionLimit.minUserAmountPerTran ?? "")
                                  //             )
                                  //           ]
                                  //       ));
                                  //     }
                                  // );}
                                  //     });
                                  Navigator.pop(
                                      context,
                                      isEdited == true
                                          ? TransactionLimit(
                                        transactionType: widget
                                            .transactionLimit
                                            .transactionType,
                                        maxAmountPerTran: double.parse(
                                            maxPerTranController.text
                                                .replaceAll(',', '')),
                                        maxAmountPerDay: double.parse(
                                            maxDailyController.text
                                                .replaceAll(',', '')),
                                        twoFactorLimit: double.parse(
                                            twoFactorController.text
                                                .replaceAll(',', '')),
                                        twoFactorEnable: widget
                                            .transactionLimit
                                            .isTwofactorEnabble,
                                        minAmountPerTran: double.parse(widget.transactionLimit.minUserAmountPerTran?.replaceAll(',', '') ?? "")
                                      )
                                          : null);
                                }),
                            16.verticalSpace,
                            AppButton(
                              buttonColor: Colors.transparent,
                              buttonType: ButtonType.OUTLINEENABLED,
                              buttonText: AppLocalizations.of(context)
                                  .translate("reset"),
                              onTapButton: () {
                                showAppDialog(
                                    title: AppLocalizations.of(context).translate("are_you_sure?"),
                                    message:AppLocalizations.of(context).translate("restore_the_limits_des"),
                                    alertType: AlertType.INFO,
                                    onPositiveCallback: () {
                                      maxDailyController.text = widget.transactionLimit.maxUserAmountPerDay!;
                                      maxPerTranController.text = widget.transactionLimit.maxUserAmountPerTran!;
                                      twoFactorController.text = widget.transactionLimit.twoFactorLimmit.toString();
                                      // bloc.add(ResetTranLimitEvent(
                                      //   messageType: "txnDetailsReq",
                                      // ));
                                    },
                                    positiveButtonText: AppLocalizations.of(context).translate("yes"),
                                    negativeButtonText: AppLocalizations.of(context).translate("no"),
                                    onNegativeCallback: () {});
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
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
