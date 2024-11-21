import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/widget/payee_details_textrow.dart';

import '../../../../core/service/dependency_injection.dart';
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

class PayeeDetailsView extends BaseView {
  SavedPayeeEntity? payeeDetailsArgs;

  PayeeDetailsView({this.payeeDetailsArgs});

  @override
  _PayeeDetailsViewState createState() => _PayeeDetailsViewState();
}

class _PayeeDetailsViewState extends BaseViewState<PayeeDetailsView> {
  var _bloc = injection<PayeeManagementBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("payee_details"),
        actions: [
          widget.payeeDetailsArgs!.isFavorite ?
          IconButton(
              onPressed: null,
              icon: PhosphorIcon(
                PhosphorIcons.star(PhosphorIconsStyle.bold),
                color: colors(context).secondaryColor,
              )) : SizedBox.shrink()
        ],
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child:
            BlocListener<PayeeManagementBloc, BaseState<PayeeManagementState>>(
          listener: (context, state) {
            if (state is DeletePayeeSuccessState) {
              Navigator.pushNamed(context, Routes.kOtpView,
                  arguments: OTPViewArgs(
                    ids: state.deletePayees?.map((e) => e.id!).toList(),
                    // id:widget.payeeDetailsArgs!.id.toString(),
                    phoneNumber: AppConstants.profileData.mobileNo.toString(),
                    appBarTitle: 'otp_verification',
                    requestOTP: true,
                    action: "delete",
                    otpType: kPayeeOTPType,
                  )).then((value) {
                if (value == true) {
                  Navigator.of(context).pop(true);
                  ToastUtils.showCustomToast(
                      context,
                      state.message ??
                          AppLocalizations.of(context)
                              .translate("payee_deleted_successfully"),
                      ToastStatus.SUCCESS);
                }
              });
            }
            else if (state is DeletePayeeFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
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
                          color: colors(context).whiteColor),
                      child: Column(
                        children: [
                          DetailsField(
                            field1: AppLocalizations.of(context)
                                .translate("nickname"),
                            field2: widget.payeeDetailsArgs!.nickName ?? "-",
                            //field2: widget.payeeDetails.nickName,
                          ),
                          DetailsField(
                            field1:
                                AppLocalizations.of(context).translate("bank"),
                            field2: widget.payeeDetailsArgs!.bankName ?? "-",
                          ),
                          DetailsField(
                            field1: AppLocalizations.of(context)
                                .translate("Account_Number"),
                            field2:
                                widget.payeeDetailsArgs!.accountNumber ?? "-",
                          ),
                          DetailsField(
                            isEnableDivider:
                                widget.payeeDetailsArgs?.bankCode !=
                                        AppConstants.ubBankCode.toString()
                                    ? true
                                    : false,
                            field1: AppLocalizations.of(context)
                                .translate("account_holders_name"),
                            field2:
                                widget.payeeDetailsArgs!.accountHolderName ??
                                    "-",
                          ),
                          Visibility(
                            visible: widget.payeeDetailsArgs?.bankCode !=
                                AppConstants.ubBankCode.toString(),
                            child: DetailsField(
                              isEnableDivider: false,
                              field1: AppLocalizations.of(context)
                                  .translate("branch"),
                              field2: (widget.payeeDetailsArgs!.branchName ==
                                          null ||
                                      widget.payeeDetailsArgs!.branchName == "")
                                  ? "-"
                                  : widget.payeeDetailsArgs?.branchName ?? "",
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
                            AppLocalizations.of(context).translate("edit"),
                        onTapButton: () {
                          Navigator.pushNamed(
                                  context, Routes.kPayeeManagementEditPayeeView,
                                  arguments: widget.payeeDetailsArgs!)
                              .then((value) {
                            if (value != null) {
                              final result = value as SavedPayeeEntity;
                              if (result.accountNumber != null) {
                                widget.payeeDetailsArgs = result;
                                setState(() {});
                              }
                            }
                          });
                        }),
                    16.verticalSpace,
                    AppButton(
                      buttonColor: Colors.transparent,
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("delete"),
                      onTapButton: () {
                        showAppDialog(
                            title: AppLocalizations.of(context)
                                .translate("delete_payee"),
                            alertType: AlertType.DELETE,
                            message: AppLocalizations.of(context)
                                .translate("delete_single_payee"),
                            positiveButtonText: AppLocalizations.of(context)
                                .translate("yes_delete"),
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            onPositiveCallback: () {
                              _bloc.add(DeleteFundTransferPayeeEvent(
                                  deleteAccountList: [
                                    widget.payeeDetailsArgs!.accountNumber
                                        .toString(),
                                  ]));
                            });
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
