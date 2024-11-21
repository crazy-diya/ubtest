import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_event.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/data/manage_pay_design.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/widget/ub_card.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/ft_saved_payee_compnent.dart';

class unionBankAccountDetailsArgs {
  final String? availableBalance;
  final String? actualeBalance;
  final String? accountNumber;
  final String? accountName;
  final String? branchName;
  final String? overDraftedLimit;
  final String? unClearedBalance;
  final String? openDate;
  final String? accountStatus;
  String? nickName;
  int? instrumentId;
  String? holdBalance;
  String? effectiveInterestRate;
  String? productName;
  final ManagePayDesign managePayDesign;
  final String? currency;

  unionBankAccountDetailsArgs({
    this.availableBalance,
    this.actualeBalance,
    this.accountNumber,
    this.accountName,
    this.branchName,
    this.overDraftedLimit,
    this.unClearedBalance,
    this.openDate,
    this.accountStatus,
    this.nickName,
    this.instrumentId,
    this.holdBalance,
    this.productName,
    this.effectiveInterestRate,required this.managePayDesign,this.currency
  });
}

class unionBankAccountDetailsView extends BaseView {
  final unionBankAccountDetailsArgs unionBankEditArgs;

  unionBankAccountDetailsView({required this.unionBankEditArgs});

  @override
  _unionBankAccountDetailsViewState createState() =>
      _unionBankAccountDetailsViewState();
}

class _unionBankAccountDetailsViewState
    extends BaseViewState<unionBankAccountDetailsView> {
  var bloc = injection<PortfolioBloc>();
  bool toggleValuePrimary = false;
  bool toggleValueAccount = false;
  String? newNickName;
  bool isEditingEnabled = false;
  final TextEditingController _controller = TextEditingController();
  bool? isEdit = false;
  bool? refreshData = false;

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
      if(refreshData! == true){
                Navigator.of(context)..pop(refreshData);
              } else {
                Navigator.pop(context,false);
              }
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
            onBackPressed: (){
              if(refreshData! == true){
                Navigator.of(context)..pop(refreshData);
              } else {
                Navigator.pop(context,false);
              };
            },
            title: AppLocalizations.of(context).translate("union_bank_accounts")),
        body: BlocProvider<PortfolioBloc>(
          create: (context) => bloc,
          child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
            bloc: bloc,
            listener: (context, state) {
              if (state is AccountDetailsSuccessState) {
                setState(() {});
              }
              if (state is EditNickNameSuccessState) {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("edit_Manage_other_bank"),
                    ToastStatus.SUCCESS);
                 widget.unionBankEditArgs.nickName = _controller.text;
                isEdit = false;
                refreshData = true;
                 setState(() {});
              }
              if (state is EditNickNameFailState) {
                isEdit = false;
                ToastUtils.showCustomToast(
                    context, state.errorMessage ?? "", ToastStatus.FAIL);
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,40.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).w,
                                color: colors(context).whiteColor
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16.w,0.h,16.w,0.h),
                              child: UbCard(
                                nickName: widget.unionBankEditArgs.nickName,
                                productName: widget.unionBankEditArgs.productName.toString().toTitleCase(),
                                accountNumber: widget.unionBankEditArgs.accountNumber,
                                actualBalance: widget.unionBankEditArgs.actualeBalance,
                                availableBalance: widget.unionBankEditArgs.availableBalance,
                                design: widget.unionBankEditArgs.managePayDesign,
                                 currency: widget.unionBankEditArgs.currency 
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
                                    field1: AppLocalizations.of(context)
                                        .translate("account_nickname"),
                                    field2: widget.unionBankEditArgs.nickName ??
                                        "-",
                                    isLastItem: true,
                                    isEditable: true,
                                    onTap:()async {
                                      final result = await showModalBottomSheet<bool>(
                                          isScrollControlled: true,
                                          useRootNavigator: true,
                                          useSafeArea: true,
                                          context: context,
                                          barrierColor: colors(context).blackColor?.withOpacity(.85),
                                           backgroundColor: Colors.transparent,
                                          builder: (context,) => StatefulBuilder(
                                              builder: (context,changeState) {
                                                return BottomSheetBuilder(
                                                  title: AppLocalizations.of(context).translate('change_account_nickname'),
                                                  buttons: [
                                                    Expanded(
                                                      child: AppButton(
                                                        buttonType: isEdit == true
                                                            ? ButtonType.PRIMARYENABLED
                                                            : ButtonType.PRIMARYDISABLED,
                                                        buttonText: AppLocalizations.of(context)
                                                            .translate("update"),
                                                        onTapButton: () {
                                                          bloc.add(
                                                            EditNicknameEvent(
                                                                instrumentType: kMessageTypeDigitalOnBoarding,
                                                                instrumentId:
                                                                widget.unionBankEditArgs.instrumentId,
                                                                nickName: _controller.text,
                                                                messageType: "userInstrumentReq"),
                                                          );
                                                          Navigator.pop(context);
                                                        },
                                                      ),)
                                                  ],
                                                  children: [
                                                    AppTextField(
                                                      maxLength: 20,
                                                      isInfoIconVisible: false,
                                                      inputType: TextInputType.text,
                                                      controller: _controller,
                                                      initialValue: widget.unionBankEditArgs.nickName,
                                                      inputFormatter: [
                                                        FilteringTextInputFormatter.allow(
                                                            RegExp("[A-Z a-z ]")),
                                                      ],
                                                      hint: AppLocalizations.of(context)
                                                          .translate("enter_acount_nickname"),
                                                      title: AppLocalizations.of(context)
                                                          .translate("account_nickname"),
                                                      textCapitalization: TextCapitalization.none,
                                                      onTextChanged: (v){
                                                        isEdit = true;
                                                        setState(() {});
                                                        changeState(() {});
                                                      },
                                                    ),
                                                    20.verticalSpace
                                                  ],
                                                );
                                              }
                                          ));
                                      if (result == null) {
                                        setState(() {

                                        });
                                      }
                                      isEdit == false;
                                    },
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
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
    return bloc;
  }
}
