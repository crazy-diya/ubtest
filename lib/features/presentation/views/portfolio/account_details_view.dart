import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/portfolio_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/portfolio_card.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../utils/app_extensions.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_event.dart';

import 'package:union_bank_mobile/features/presentation/views/portfolio/account_statement_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/account_transaction_history.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_bottom_container.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';


import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../bloc/portfolio/portfolio_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';

class AccountDetailsArgs {
  final String? availableBalance;
  final String? actualeBalance;
  final String? accountNumber;
  final String? accountName;
  final String? accountType;
  final String? branchName;
  final String? overDraftedLimit;
  final String? unClearedBalance;
  final String? openDate;
  final String? accountStatus;
  final String? currency;
  String? nickName;
  int? instrumentId;
  String? holdBalance;
  String? effectiveInterestRate;
  int? index;

  AccountDetailsArgs({
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
    this.effectiveInterestRate,
    this.index,
    this.currency,
    this.accountType
  });
}

class PortfolioAccountDetailsView extends BaseView {
  final AccountDetailsArgs accountDetailsArgs;

  PortfolioAccountDetailsView({required this.accountDetailsArgs});

  @override
  _PortfolioAccountDetailsViewState createState() =>
      _PortfolioAccountDetailsViewState();
}

class _PortfolioAccountDetailsViewState
    extends BaseViewState<PortfolioAccountDetailsView> {

  @override
  void initState() {
    super.initState();
    holdBalance = double.parse(widget.accountDetailsArgs.holdBalance!.replaceAll(',', ''));
    unclearBalance = double.parse(widget.accountDetailsArgs.unClearedBalance!.replaceAll(',', ''));
  }
  var bloc = injection<PortfolioBloc>();
  final TextEditingController _controller = TextEditingController();
  bool toggleValueprimary = false;
  bool toggleValueAccount = false;
  bool isEdit = false;

  double? holdBalance;
  double? unclearBalance;
  String? newNickName;
  String? newNickNameSucess;
  String? newNickNameTemp;
  bool isEditingEnabled = false;
  bool isNickNameEdited = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        onBackPressed: (){
          isEdit == true ?
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.kPortfolioView , arguments: PortfolioTypeArgs(
              tabType: AccountType.ACCOUNTS), (Route<dynamic> route) =>
            route.settings.name == Routes.kHomeBaseView,
          ) : Navigator.pop(context);
        },
        actions: [
          IconButton(
              onPressed: ()async {
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
                                  newNickName = newNickNameTemp;
                                  bloc.add(
                                    EditNicknameEvent(
                                        instrumentType: "digitalOnboarding",
                                        instrumentId: widget.accountDetailsArgs.instrumentId,
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
                              initialValue: widget.accountDetailsArgs.nickName,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z ]")),
                              ],
                              hint: AppLocalizations.of(context).translate("enter_acount_nickname"),
                              title: AppLocalizations.of(context).translate("account_nickname"),
                              textCapitalization: TextCapitalization.none,
                              onTextChanged: (v){
                                isEdit = true;
                                newNickNameTemp = v;
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
              icon: PhosphorIcon(PhosphorIcons.pencilSimpleLine(PhosphorIconsStyle.bold) , size: 24.w)),
        ],
          title: AppLocalizations.of(context).translate("Account_Details")),
      body: BlocProvider<PortfolioBloc>(
        create: (context) => bloc,
        child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AccountDetailsSuccessState) {
              setState(() {});
            }
            else if (state is EditNickNameSuccessState) {
              setState(() {
                newNickNameSucess = newNickName;
                AppConstants.accountDetailsResponseDtos[
                  widget.accountDetailsArgs.index!].nickName = newNickNameSucess;
                isEditingEnabled = false;
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.SUCCESS);
              });
            }
            else if (state is EditNickNameFailState) {
              ToastUtils.showCustomToast(
                        context, state.errorMessage??"", ToastStatus.FAIL);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16).w,
                            child: PortfolioCard(
                              design: ManagePayDesign(
                                  backgroundColor: colors(context).primaryColor!,
                                  fontColor: colors(context).whiteColor!,
                                  dividerColor: colors(context).primaryColor300!
                              ),
                              nickName: isEdit == true ? newNickNameSucess : widget.accountDetailsArgs.nickName,
                              accountNumber: widget.accountDetailsArgs.accountNumber!,
                              productName: widget.accountDetailsArgs.accountName!,
                              availableBalance: widget.accountDetailsArgs.availableBalance!.replaceAll(',', ''),
                              actualBalance: widget.accountDetailsArgs.actualeBalance!.replaceAll(',', ''),
                              currency: widget.accountDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                              cardType: "Accounts",
                            ),
                          ),
                        ),
                        // UBPortfolioDetailsContainer(
                        //   // isprimary: toggleValueprimary,
                        //   title: widget.accountDetailsArgs.accountName!,
                        //   availableBalance: widget.accountDetailsArgs.availableBalance!,
                        //   actualBalance: widget.accountDetailsArgs.actualeBalance!,
                        //   subTitle: widget.accountDetailsArgs.accountNumber!,
                        // ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w,0.h,16.w,0.h),
                            child: Column(
                              children: [
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("product_title"),
                                  data: widget.accountDetailsArgs.accountName ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("account_status"),
                                  data: widget.accountDetailsArgs.accountStatus?.toTitleCase() ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("opened_date"),
                                  data: widget.accountDetailsArgs.openDate?.isDate() == true ? DateFormat('dd-MMM-yyyy').format(
                                      DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(widget.accountDetailsArgs.openDate!,)):"-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("overdraft_limit"),
                                  isCurrency: true,
                                  amount: double.parse(widget.accountDetailsArgs.overDraftedLimit!.replaceAll(',', '')),
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("hold_balance"),
                                  isCurrency: true,
                                  amount: holdBalance,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("un-cleared_balance"),
                                  isCurrency: true,
                                  amount: unclearBalance,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("branch"),
                                  data: widget.accountDetailsArgs.branchName ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("effective_interest_rate"),
                                  data: "${widget.accountDetailsArgs.effectiveInterestRate}%",
                                  isLastItem: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 10, top: 20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: AppTextField(
                        //           controller: _nickName,
                        //           isInfoIconVisible: false,
                        //           hint: AppLocalizations.of(context)
                        //               .translate("account_nickname"),
                        //           isLabel: true,
                        //                 isEnable: isEditingEnabled,
                        //                 initialValue:
                        //                     widget.accountDetailsArgs.nickName!,
                        //                 textCapitalization:
                        //                     TextCapitalization.words,
                        //                 onTextChanged: (value) {
                        //                   setState(() {
                        //                     newNickName = value;
                        //                   });
                        //                 },
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //             isEditingEnabled = true;
                        //           });
                        //         },
                        //         child: Image.asset(
                        //           AppAssets.icEditInfoIcon,
                        //           scale: 3,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Visibility(
                        //   visible: isEditingEnabled,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       InkWell(
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             color: colors(context).greyColor200,
                        //           ),
                        //           width: 120,
                        //           height: 50,
                        //           child: Center(
                        //               child: Text(
                        //             AppLocalizations.of(context)
                        //                 .translate("Cancel"),
                        //             style: TextStyle(
                        //                 color: colors(context).blackColor,
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w500),
                        //           )),
                        //         ),
                        //         onTap: () {
                        //           setState(() {
                        //             isEditingEnabled = false;
                        //           });
                        //         },
                        //       ),
                        //       InkWell(
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             color: colors(context).primaryColor,
                        //           ),
                        //           width: 120,
                        //           height: 50,
                        //           child: Center(
                        //               child: Text(
                        //             AppLocalizations.of(context)
                        //                 .translate("save"),
                        //             style: TextStyle(
                        //                 color: colors(context).whiteColor,
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w500),
                        //           )),
                        //         ),
                        //         onTap: () {
                        //           bloc.add(
                        //             EditNicknameEvent(
                        //               instrumentType: "digitalOnboarding",
                        //                 instrumentId: widget.accountDetailsArgs.instrumentId,
                        //                 nickName: newNickName,
                        //                 messageType: "userInstrumentReq"),
                        //           );
                        //
                        //         },
                        //       )
                        //     ],
                        //   ),
                        // ),
                        //
                        // UBPortfolioDetails(
                        //   title: 'Overdraft Limit',
                        //   isCurrency: true,
                        //   amount: widget.accountDetailsArgs.overDraftedLimit!.withThousandSeparator(),
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Hold Balance',
                        //   isCurrency: true,
                        //   amount: widget.accountDetailsArgs.holdBalance!.withThousandSeparator(),
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Un-cleared Balance',
                        //   isCurrency: true,
                        //   amount: widget.accountDetailsArgs.unClearedBalance!.withThousandSeparator(),
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Opened Date',
                        //   // subTitle: widget.accountDetailsArgs.openDate!,
                        //   subTitle: widget.accountDetailsArgs.openDate?.isDate() == true ? DateFormat('dd-MMM-yyyy').format(
                        //       DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(
                        //     widget.accountDetailsArgs.openDate!,
                        //   )):"0000-00-00",
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Branch',
                        //   subTitle: widget.accountDetailsArgs.branchName!,
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Effective Interest Rate',
                        //   subTitle:
                        //       widget.accountDetailsArgs.effectiveInterestRate!,
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Product Title',
                        //   subTitle: widget.accountDetailsArgs.accountName!,
                        // ),
                        // UBPortfolioDetails(
                        //   title: 'Account Status',
                        //   subTitle: widget.accountDetailsArgs.accountStatus!,
                        // ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w,0.h,16.w,0.h),
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .kPortfolioAccountTransactionHistoryView,
                                          arguments: AccountTransactionHistoryArgs(
                                              accountType:
                                                  widget.accountDetailsArgs.accountType,
                                              accNumber: widget
                                                  .accountDetailsArgs.accountNumber,
                                              title:
                                                  widget.accountDetailsArgs.accountName,
                                              balance: widget
                                                  .accountDetailsArgs.actualeBalance,
                                              accName: widget
                                                  .accountDetailsArgs.accountName,
                                            currency: widget.accountDetailsArgs.currency
                                          ));
                                    },
                                    child: UBPortfolioBottomContainer(
                                      title: AppLocalizations.of(context).translate("view_recent_transactions"),
                                        icon: PhosphorIcon(PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.bold),
                                            color: colors(context).primaryColor),
                                    )),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Routes.kPortfolioAccountStatementView,
                                          arguments: AccountStatementsArgs(
                                              accNumber: widget
                                                  .accountDetailsArgs.accountNumber,
                                              accType: widget
                                                  .accountDetailsArgs.accountType,
                                            currency: widget.accountDetailsArgs.currency
                                          ));
                                    },
                                    child: UBPortfolioBottomContainer(
                                      title: AppLocalizations.of(context)
                                          .translate("account_statements"),
                                      isLastItem: true,
                                      icon: PhosphorIcon(PhosphorIcons.files(PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
