// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_process_view.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';

class SaveBillerArgs {
  final String? billerCatogory;
  final String? serviceProvider;
  final String? accNumber;
  final int serviceProviderId;
  final String route;
  final BillPaymentViewArgs? billPaymentViewArgs;

  SaveBillerArgs({
    this.billerCatogory,
    this.serviceProvider,
    this.accNumber,
    required this.serviceProviderId,
    required this.route,
    this.billPaymentViewArgs,
  });
}

class SaveBillerView extends BaseView {
  final SaveBillerArgs? saveBillerArgs;

  SaveBillerView({this.saveBillerArgs});

  @override
  _SaveBillerViewState createState() => _SaveBillerViewState();
}

class _SaveBillerViewState extends BaseViewState<SaveBillerView> {
  var _bloc = injection<BillerManagementBloc>();
  bool toggleValue = false;
  String? nickName;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("save_biller"),
        goBackEnabled: true,
      ),
      body: BlocProvider<BillerManagementBloc>(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is AddBillerSuccessState) {
              if (state.responseCode == "843") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("already_added_nickname"),
                  message: splitAndJoinAtBrTags(state.responseDes ?? ""),
                  positiveButtonText:
                  AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
              }
              else if (state.responseCode == "842") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("account_already_exists"),
                  // message: splitAndJoinAtBrTags(state.responseDes ?? ""),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: splitAndJoinAtBrTags(
                                    extractTextWithinTags(
                                        input: state.responseDes ?? "")[0]),
                                style: size14weight400.copyWith(
                                    color: colors(context).greyColor)),
                            TextSpan(
                                text:
                                " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.responseDes ?? "")[1])}",
                                style: size14weight700.copyWith(
                                    color: colors(context).greyColor)),
                          ]))
                    ],
                  ),
                  positiveButtonText:
                  AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
              } else {showAppDialog(
                  title: AppLocalizations.of(context)
                      .translate("biller_added_successfully_save"),
                  alertType: AlertType.SUCCESS,
                  message: AppLocalizations.of(context)
                      .translate("new_biller_was_added_successfully"),
                  positiveButtonText:
                  AppLocalizations.of(context).translate("done"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeBaseView,
                          (Route<dynamic> route) => false,
                    );
                  });}
            }
            if (state is AddBillerFailedState) {
              showAppDialog(
                  title: AppLocalizations.of(context).translate("try_again"),
                  alertType: AlertType.FAIL,
                  message: state.message,
                  positiveButtonText:
                      AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {});
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20.w,
                40.h,
                20.w,
                20.h + AppSizer.getHomeIndicatorStatus(context),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding: const EdgeInsets.all(16).w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("biller_category"),
                                            style: size14weight700.copyWith(
                                                color:
                                                    colors(context).blackColor),
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            widget.saveBillerArgs!
                                                    .billerCatogory ??
                                                "",
                                            style: size14weight400.copyWith(
                                                color:
                                                    colors(context).greyColor),
                                          ),
                                        ],
                                      ),
                                      12.verticalSpace,
                                      Divider(
                                        height: 0,
                                        color: colors(context).greyColor100,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                  12.verticalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("service_provider"),
                                            style: size14weight700.copyWith(
                                                color:
                                                    colors(context).blackColor),
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            widget.saveBillerArgs!
                                                    .serviceProvider ??
                                                "",
                                            style: size14weight400.copyWith(
                                                color:
                                                    colors(context).greyColor),
                                          ),
                                        ],
                                      ),
                                      12.verticalSpace,
                                      Divider(
                                        height: 0,
                                        color: colors(context).greyColor100,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                  12.verticalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget
                                            .saveBillerArgs!
                                            .billPaymentViewArgs!
                                            .referenceSample!,
                                        style: size14weight700.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        widget.saveBillerArgs!.accNumber ?? "",
                                        style: size14weight400.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                  // BillPaymentDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("biller_category"),
                                  //   data: widget.saveBillerArgs!.billerCatogory ?? "",
                                  // ),
                                  // BillPaymentDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("service_provider"),
                                  //   data: widget.saveBillerArgs!.serviceProvider ?? "",
                                  // ),
                                  // BillPaymentDataComponent(
                                  //   isLastItem: true,
                                  //   title: widget.saveBillerArgs!.billPaymentViewArgs!.referenceSample!,
                                  //   data: widget.saveBillerArgs!.accNumber ?? "",
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding: const EdgeInsets.all(16).w,
                              child: Column(
                                children: [
                                  AppTextField(
                                    hint: AppLocalizations.of(context)
                                        .translate("nickname"),
                                    title: AppLocalizations.of(context)
                                        .translate("nickname"),
                                    inputType: TextInputType.text,
                                    // inputFormatter: [
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp("[A-Z a-z ]")),
                                    // ],
                                    key: const Key("keyNickName"),
                                    initialValue: '',
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 16)
                                        .w,
                                    child: Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: colors(context).greyColor100,
                                    ),
                                  ),
                                  24.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("add_favorite"),
                                        style: size16weight700.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                      Spacer(),
                                      CupertinoSwitch(
                                        value: toggleValue,
                                        trackColor: colors(context)
                                            .greyColor
                                            ?.withOpacity(.65),
                                        activeColor:
                                            colors(context).primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            toggleValue = value;
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Column(
                    children: [
                      AppButton(
                        buttonText:
                            AppLocalizations.of(context).translate("save"),
                        onTapButton: () {
                          if (_formKey.currentState?.validate() == false) {
                            return;
                          }
                          _bloc.add(AddBillerEvent(
                            verified: true,
                            isFavorite: toggleValue,
                            nickName: nickName,
                            serviceProviderId:
                                widget.saveBillerArgs!.serviceProviderId,
                            billerNo: widget.saveBillerArgs!.accNumber,
                          ));
                        },
                      ),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText:
                            AppLocalizations.of(context).translate("home"),
                        onTapButton: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.kHomeBaseView,
                            (Route<dynamic> route) => false,
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
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
