import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/widget/OtherBankComponent.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/enums.dart';
import '../../../domain/entities/response/get_juspay_instrument_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../bloc/payment_instrument/payment_instrument_bloc.dart';
import '../../bloc/payment_instrument/payment_instrument_event.dart';
import '../../bloc/payment_instrument/payment_instrument_state.dart';
import '../../widgets/app_button.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class ManageOtherBankEditArgs {
  final UserInstrumentsListEntity? otherBankDetails;
  final bool? isEditView;
  ManageOtherBankEditArgs({
    this.isEditView = false,
    this.otherBankDetails,
  });
}

class ManageOtherBankEditView extends BaseView {
  final ManageOtherBankEditArgs? manageOtherBankEditArgs;
  ManageOtherBankEditView({required this.manageOtherBankEditArgs});

  @override
  _ManageOtherBankEditViewState createState() =>
      _ManageOtherBankEditViewState();
}

class _ManageOtherBankEditViewState
    extends BaseViewState<ManageOtherBankEditView> {
  bool isEditingEnabled = false;
  var nickNameController = TextEditingController();
  var accountNuController = TextEditingController();
  String? accountNu, nickName1;
  List<UserInstrumentsListEntity> otherBankList = [];
   final _formKey = GlobalKey<FormState>();
  var _bloc = injection<PaymentInstrumentBloc>();

  @override
  void initState() {
    super.initState();
    nickNameController = TextEditingController(text: widget.manageOtherBankEditArgs?.otherBankDetails?.nickName);
   accountNuController = TextEditingController(text: widget.manageOtherBankEditArgs?.otherBankDetails?.accountNo);

  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("manage_other_account"),
      ),
      body: BlocProvider<PaymentInstrumentBloc>(
        create: (context) => _bloc,
        child: BlocListener<PaymentInstrumentBloc,
            BaseState<PaymentInstrumentState>>(
          listener: (context, state) {
            if (state is InstrumentNikNameChangeSuccessState) {
              if (state.baseResponse!.responseCode == "836"){
                setState(() {});
                widget.manageOtherBankEditArgs!.otherBankDetails!.nickName =
                    nickName1;
                showAppDialog(
                  title: AppLocalizations.of(context).translate(
                      "Change_Nickname"),
                  alertType: AlertType.SUCCESS,
                  message: AppLocalizations.of(context)
                      .translate("edit_manage_other_bank_account_success_message"),
                  positiveButtonText:
                  AppLocalizations.of(context).translate("ok"),

                  onPositiveCallback: () {
                    Navigator.of(context)..pop()..pop(true);
                  },
                );

              }else  {
                ToastUtils.showCustomToast(
                    context, state.baseResponse!.errorDescription!, ToastStatus.FAIL);
              }

            }
            if (state is InstrumentNikNameChangeFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            } else if (state is DeletePayeeSuccessState) {
              Navigator.pop(context, true);
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w,24.h,20.h,20.w),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  OtherBankComponent(
                    manageOtherBankAccountEntity:
                        widget.manageOtherBankEditArgs?.otherBankDetails,
                  ),
                   SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                             validator: (value) {
                              if (value == null || value == "") {
                                return AppLocalizations.of(context).translate("nick_name_required");
                              } else {
                                return null;
                              }
                            },
                            inputType: TextInputType.text,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[A-Z a-z ]")),
                            ],
                            controller: nickNameController,
                            isInfoIconVisible: false,
                            hint: '',
                            textCapitalization: TextCapitalization.none,
                            isLabel: true,
                            isEnable: true,
                            initialValue: widget.manageOtherBankEditArgs!
                                .otherBankDetails!.nickName,
                            onTextChanged: (value) {
                              setState(() {
                                nickName1 = value;
                              });
                              // validateFields();
                            },
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          AppTextField(
                            isEnable:false,
                            isReadOnly: true,
                            controller: accountNuController,
                            isInfoIconVisible: false,
                            inputType: TextInputType.number,
                            hint: '',
                            textCapitalization: TextCapitalization.none,
                            isLabel: true,
                            onTextChanged: (value) {
                              setState(() {
                                widget.manageOtherBankEditArgs!.otherBankDetails!
                                    .accountNo = value;
                              });
                              // validateFields();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      AppButton(
                        buttonText: AppLocalizations.of(context)
                            .translate("Change_Nickname"),
                        onTapButton: () {
                           if (_formKey.currentState?.validate() == false) { return;}
                          _bloc.add(
                            InstrumentNikeNameChangeEvent(
                              instrumentType: kMessageTypeDigitalOnBoarding,
                              instrumentId: widget.manageOtherBankEditArgs!
                                  .otherBankDetails!.id,
                              messageType: "userInstrumentReq",
                              nickName: nickNameController.text.trim(),
                            ),
                          );
            
                        },
                      ),
                      AppButton(
                         buttonType: ButtonType.OUTLINEENABLED,
                        buttonText:
                            AppLocalizations.of(context).translate("cancel"),
                       
                        onTapButton: () {
                          Navigator.pop(context, true);
                          // Navigator.pushNamed(
                          //     context, Routes.kFundTransferView);
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
