import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/views/request_money/widgets/ub_request_money_data_component.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/request_money/request_money_bloc.dart';
import '../../widgets/app_button.dart';

import '../base_view.dart';
import '../fund_transfer/data/fund_transfer_args.dart';

class RequestMoneySummaryArgs {
  final String remarkText;

  RequestMoneySummaryArgs({required this.remarkText});
}

class RequestMoneySummaryView extends BaseView {
  final FundTransferArgs fundTransferArgs;

  RequestMoneySummaryView({required this.fundTransferArgs});

  @override
  _RequestMoneySummaryViewState createState() =>
      _RequestMoneySummaryViewState();
}

class _RequestMoneySummaryViewState
    extends BaseViewState<RequestMoneySummaryView> {
  var bloc = injection<RequestMoneyBloc>();
  bool toggleValue = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("request_money_summary"),
      ),
      body: BlocProvider<RequestMoneyBloc>(
        create: (context) => bloc,
        child: BlocListener<RequestMoneyBloc, BaseState<RequestMoneyState>>(
          bloc: bloc,
          listener: (context, state) {
            if (state is RequestMoneySuccessState) {
              showAppDialog(
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                  message:
                      splitAndJoinAtBrTags(state.responseDescription ?? ""),
                  alertType: AlertType.SUCCESS,
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.kRequestMoneyView,
                        (route) =>
                            route.settings.name == Routes.kQuickAccessCarousel);
                    // Navigator.of(context)..pop()..pop(true);
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                  positiveButtonText:
                      AppLocalizations.of(context).translate("done"));
            }
            if (state is RequestMoneyFailState) {
              showAppDialog(
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                  message: state.message,
                  alertType: AlertType.FAIL,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("close"));
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UBRequestMoneyDataComponent(
                            title: AppLocalizations.of(context)
                                .translate("to_account"),
                            data: widget.fundTransferArgs.fundTransferEntity
                                    .payFromName ??
                                "-",
                            subData: widget.fundTransferArgs.fundTransferEntity
                                    .payFromNum ??
                                "-",
                          ),
                          UBRequestMoneyDataComponent(
                            title: AppLocalizations.of(context)
                                .translate("request_form"),
                            data: widget.fundTransferArgs.fundTransferEntity.isFromContacts == true ?
                            widget.fundTransferArgs.fundTransferEntity.name  ?? "" :
                            formatMobileNumber(widget.fundTransferArgs.fundTransferEntity.beneficiaryMobile ?? "-"),
                            subData: widget.fundTransferArgs.fundTransferEntity.isFromContacts == true ?
                            formatMobileNumber(widget.fundTransferArgs.fundTransferEntity.beneficiaryMobile ?? "-") : "",
                          ),
                          UBRequestMoneyDataComponent(
                            title: AppLocalizations.of(context)
                                .translate("amount"),
                            amount: widget.fundTransferArgs.fundTransferEntity
                                    .amount ??
                                0,
                            isCurrency: true,
                          ),
                          UBRequestMoneyDataComponent(
                            title: AppLocalizations.of(context)
                                .translate("remarks"),
                            isLastItem: true,
                            data:
                                // 'Medical',
                                widget.fundTransferArgs.fundTransferEntity
                                        .remark ??
                                    "-",
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                        buttonText:
                            AppLocalizations.of(context).translate("confirm"),
                        onTapButton: () {
                          bloc.add(RequestMoneyRequestEvent(
                            messageType: "requestMoney",
                            mobileNumber: widget.fundTransferArgs
                                .fundTransferEntity.beneficiaryMobile,
                            toAccountNumber: widget
                                .fundTransferArgs.fundTransferEntity.payFromNum,
                            amount: widget
                                .fundTransferArgs.fundTransferEntity.amount
                                .toString(),
                            remarks: widget.fundTransferArgs.fundTransferEntity
                                    .remark ??
                                "-",
                          ));
                        }),
                    16.verticalSpace,
                    AppButton(
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                            title: AppLocalizations.of(context).translate("cancel_the_request"),
                            message: AppLocalizations.of(context).translate("cancel_the_request_des"),
                            alertType: AlertType.TRANSFER,
                            onPositiveCallback: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                            negativeButtonText: AppLocalizations.of(context).translate("no"),
                            onNegativeCallback: () {});
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
    return bloc;
  }
}
