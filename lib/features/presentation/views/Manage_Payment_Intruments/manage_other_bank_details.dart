import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/widget/OtherBankComponent.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../domain/entities/response/get_juspay_instrument_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/payment_instrument/payment_instrument_bloc.dart';
import '../../bloc/payment_instrument/payment_instrument_event.dart';
import '../../bloc/payment_instrument/payment_instrument_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/ft_saved_payee_compnent.dart';

class ManageOtherBankDetailArgs {
  final UserInstrumentsListEntity? otherBankDetails;
  final bool? isEditView;
  final String? icon;
  ManageOtherBankDetailArgs({
    this.isEditView = false,
    this.otherBankDetails,
    this.icon,
  });
}

class ManageOtherBankDetailsView extends BaseView {
  final ManageOtherBankDetailArgs? manageOtherBankDetailArgs;
  ManageOtherBankDetailsView({required this.manageOtherBankDetailArgs});
  @override
  _ManageOtherBankDetailsViewState createState() =>
      _ManageOtherBankDetailsViewState();
}

class _ManageOtherBankDetailsViewState
    extends BaseViewState<ManageOtherBankDetailsView> {
  List<UserInstrumentsListEntity> otherBankList = [];
  var _bloc = injection<PaymentInstrumentBloc>();
  // late final TextEditingController _controller;
  final TextEditingController _controller = TextEditingController();
  bool? isEdit = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        onBackPressed: () {
          if (isEdit! == true) {
            Navigator.of(context)..pop(true);
          } else {
            Navigator.pop(context);
          }
          ;
        },
        actions: [
          IconButton(
            onPressed: (){
              showAppDialog(
                  alertType: AlertType.DELETE,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate("delete_account"),
                  message: AppLocalizations.of(context).translate("delete_account_des"),
                  negativeButtonText: AppLocalizations.of(context).translate("no"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
                  onPositiveCallback: () {
                    _bloc.add(DeleteInstrumentEvent(
                        instrumentType: kMessageTypeDigitalOnBoarding,
                        instrumentId: widget
                            .manageOtherBankDetailArgs!.otherBankDetails!.id,
                        messageType: kDeletePaymentInstrument));
                  });
            },
            icon: PhosphorIcon(
              PhosphorIcons.trash(),
              color: colors(context).whiteColor,
            ),
          ),
        ],
        title: AppLocalizations.of(context).translate("other_bank_accounts"),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<PaymentInstrumentBloc,
            BaseState<PaymentInstrumentState>>(
          listener: (context, state) {
            if (state is InstrumentNikNameChangeSuccessState) {
              if (state.responseCode == "853") {
                isEdit = false;
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("already_added_nickname"),
                  message:
                      splitAndJoinAtBrTags(state.responseDescription ?? ""),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
              } else {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("edit_Manage_other_bank"),
                    ToastStatus.SUCCESS);
                widget.manageOtherBankDetailArgs!.otherBankDetails!.nickName =
                    _controller.text;
                isEdit = false;
                setState(() {});
              }
            }
            if (state is InstrumentNikNameChangeFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            }
            if (state is DeleteJustPayInstrumentSuccessState) {
              if(state.code == "961"){
                ToastUtils.showCustomToast(context, splitAndJoinAtBrTags(state.message ?? ""),
                    ToastStatus.FAIL);
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  onPositiveCallback: () {},
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                );
              } else {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("payment_deleted_successfully"),
                    ToastStatus.SUCCESS);
              }
              Navigator.pop(context, true);
            }
            if (state is DeleteJustPayInstrumentFailedState) {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: state.message,
                  onPositiveCallback: () {});
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: OtherBankComponent(
                        isArrow: false,
                        icon: widget.manageOtherBankDetailArgs?.icon,
                        manageOtherBankAccountEntity: UserInstrumentsListEntity(
                          bankName: widget.manageOtherBankDetailArgs
                              ?.otherBankDetails?.bankName,
                          accountNo: widget.manageOtherBankDetailArgs
                              ?.otherBankDetails?.accountNo,
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: FTSavedPayeeComponent(
                              isEditable: true,
                              field1: AppLocalizations.of(context)
                                  .translate("account_nickname"),
                              field2: widget.manageOtherBankDetailArgs!
                                      .otherBankDetails!.nickName ??
                                  "-",
                              onTap: () async {
                                await showModalBottomSheet<bool>(
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    useSafeArea: true,
                                    context: context,
                                    barrierColor: colors(context).blackColor?.withOpacity(.85),
                                    backgroundColor: Colors.transparent,
                                    builder: (
                                      context,
                                    ) =>
                                        StatefulBuilder(
                                            builder: (context, changeState) {
                                          return BottomSheetBuilder(
                                            title: AppLocalizations.of(context)
                                                .translate(
                                                    'change_account_nickname'),
                                            buttons: [
                                              Expanded(
                                                child: AppButton(
                                                  buttonType: isEdit != true
                                                      ? ButtonType.PRIMARYDISABLED
                                                      : ButtonType.PRIMARYENABLED,
                                                  buttonText:
                                                      AppLocalizations.of(context)
                                                          .translate("update"),
                                                  onTapButton: () {
                                                    _bloc.add(
                                                      InstrumentNikeNameChangeEvent(
                                                        instrumentType:
                                                            kMessageTypeDigitalOnBoarding,
                                                        instrumentId: widget
                                                            .manageOtherBankDetailArgs!
                                                            .otherBankDetails!
                                                            .id,
                                                        messageType:
                                                            "userInstrumentReq",
                                                        nickName: _controller.text
                                                            .trim(),
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              )
                                            ],
                                            children: [
                                              AppTextField(
                                                maxLength: 20,
                                                isInfoIconVisible: false,
                                                inputType: TextInputType.text,
                                                controller: _controller,
                                                initialValue: widget
                                                    .manageOtherBankDetailArgs!
                                                    .otherBankDetails!
                                                    .nickName,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp("[A-Z a-z ]")),
                                                ],
                                                hint: AppLocalizations.of(context)
                                                    .translate(
                                                        "enter_acount_nickname"),
                                                title:
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            "account_nickname"),
                                                textCapitalization:
                                                    TextCapitalization.none,
                                                onTextChanged: (value) {
                                                  isEdit = true;
                                                  setState(() {});
                                                  changeState(() {});
                                                },
                                              ),
                                            20.verticalSpace
                                            ],
                                          );
                                        }));

                                setState(() {
                                  isEdit = false;
                                });
                              }),
                        ),
                        12.verticalSpace,
                        FTSavedPayeeComponent(
                          field1: AppLocalizations.of(context)
                              .translate("Account_Number"),
                          field2: widget.manageOtherBankDetailArgs!
                                  .otherBankDetails!.accountNo ??
                              "-",
                        ),
                        12.verticalSpace,
                        FTSavedPayeeComponent(
                          isLastItem: true,
                          field1:
                              AppLocalizations.of(context).translate("bank"),
                          field2: widget.manageOtherBankDetailArgs!
                                  .otherBankDetails!.bankName ??
                              "-",
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
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
