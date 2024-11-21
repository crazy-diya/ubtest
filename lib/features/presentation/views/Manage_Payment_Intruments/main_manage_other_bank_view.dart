import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/data/manage_pay_design.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/widget/OtherBankComponent.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/widget/ub_card.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/sliding_segmented_bar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/model/bank_icons.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../../data/models/responses/portfolio_userfd_details_response.dart';
import '../../../domain/entities/response/get_juspay_instrument_entity.dart';
import '../../bloc/payment_instrument/payment_instrument_bloc.dart';
import '../../bloc/payment_instrument/payment_instrument_event.dart';
import '../../bloc/payment_instrument/payment_instrument_state.dart';
import '../../widgets/appbar.dart';
import 'edit_union_bank_account.dart';
import 'manage_other_bank_details.dart';

class MainOtherBankAccountView extends BaseView {
  MainOtherBankAccountView({
    super.key,
  });

  @override
  _MainOtherBankAccountViewState createState() =>
      _MainOtherBankAccountViewState();
}

class _MainOtherBankAccountViewState
    extends BaseViewState<MainOtherBankAccountView> {

  var bloc = injection<PaymentInstrumentBloc>();
  bool isDeleteAvailable = false;
  List<String> deleteMultipleAccount = [];
  List<FdDetailsResponseDtoList> invList = [];
  List<AccountDetailsResponseDto> accList = [];
  List<UserInstrumentsListEntity> justpayInstrumentList = [];
  List<UserInstrumentsListEntity> selectedList = [];
  bool isAll = true;
  bool isSavedSelected = true;
  bool isOtherBankTabSelected = true;
  String accountTotal = '';
  // List<String> tabs = [
  //   "Union Bank",
  //   "Other Bank",
  // ];
  int current = 1;
  double totalAccBalance = 0;

  @override
  void initState() {
    super.initState();
    bloc.add(GetJustpayInstrumentEvent(
      requestType: RequestTypes.ACTIVE.name,
    ));
    bloc.add(GetManageAccDetailsEvent());
    accList.addAll(AppConstants.accountDetailsResponseDtos);
  }




  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("manage_other_account"),
      ),
      body: BlocProvider<PaymentInstrumentBloc>(
          create: (_) => bloc,
          child: BlocListener<PaymentInstrumentBloc,
              BaseState<PaymentInstrumentState>>(
            listener: (context, state) {
              if (state is ManageAccountDetailsSuccessState) {
                  if (state.accDetails!.accountDetailsResponseDtos!.length >=
                          1) {
                    accList = state.accDetails!.accountDetailsResponseDtos!;
                    accList =accList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
                    state.accDetails!.accountDetailsResponseDtos!
                        .forEach((element) {
                      totalAccBalance +=
                          double.parse(element.convertedActualBalance!);
                    });
                  }
                  setState(() {
                    AppConstants.totalAccountBalance = totalAccBalance;
                    AppConstants.accountDetailsResponseDtos = state.accDetails!.accountDetailsResponseDtos!;
                  });
                }
              if (state is ManageAccountDetailFailState) {
                ToastUtils.showCustomToast(
                    context,
                    state.errorMessage ?? AppLocalizations.of(context).translate("something_went_wrong"),
                    ToastStatus.FAIL);
              }
              if (state is GetPaymentInstrumentSuccessState) {
                if (state.getUserInstList != null) {
                    justpayInstrumentList.clear();
                    // state.getUserInstList
                    //     ?.sort((a, b) => a.bankName!.compareTo(b.bankName!));
                    justpayInstrumentList.addAll(
                      [
                        ...state
                            .getUserInstList!
                            .map(
                          (e) => UserInstrumentsListEntity(
                            // image: base64.decode(e.image),
                            accountNo: e.accountNo,
                            nickName: e.nickName,
                            id: e.id,
                            accType: e.accType,
                            bankCode: e.bankCode,
                            bankName: e.bankName,
                            status: e.status,
                            isPrimary: e.isPrimary,
                            icon: bankIcons.firstWhere((element) => element.bankCode == (e.bankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
                            accountBalance: e.accountBalance,
                            alert: e.alert,
                          ),
                        )
                      ],
                    );
                    justpayInstrumentList =  justpayInstrumentList.where((element) => element.bankCode != AppConstants.ubBankCode.toString()).toList();
                  setState(() {});
                }
                // log(justpayInstrumentList.toString());
                // justpayInstrumentList.forEach((element) {
                //   if (element.isSelected == true) selectedList.add(element);
                // });
              }
              if (state is GetPaymentInstrumentFailedState) {
              }
              if (state is DeleteJustPayInstrumentSuccessState) {
                setState(() {
                  Navigator.pushReplacementNamed(
                      context, Routes.kMainOtherBankView);;
                });
              }
              if (state is AddPaymentInstrumentSuccessState) {
                setState(() {
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("success"),
                    positiveButtonText:
                        AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.kMainOtherBankView);
                    },
                  );
                });
              }
            },
            child: Stack(
              children: [
               justpayInstrumentList.isEmpty && isOtherBankTabSelected
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors(context).secondaryColor300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14).w,
                                child: PhosphorIcon(
                                  PhosphorIcons.bank(),
                                  color: colors(context).whiteColor,
                                  size: 28.w,
                                ),
                              )),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate("no_other_bank_accounts"),
                            style: size18weight700.copyWith(
                                color: colors(context).blackColor),
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate("no_other_bank_accounts_des"),
                            textAlign: TextAlign.center,
                            style: size14weight400.copyWith(
                                color: colors(context).blackColor),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              accList.isEmpty && !isOtherBankTabSelected
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors(context).secondaryColor300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14).w,
                                child: PhosphorIcon(
                                  PhosphorIcons.bank(),
                                  color: colors(context).whiteColor,
                                  size: 28.w,
                                ),
                              )),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate("no_union_bank_accounts"),
                            style: size18weight700.copyWith(
                                color: colors(context).blackColor),
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate("no_union_bank_accounts_des"),
                            textAlign: TextAlign.center,
                            style: size14weight400.copyWith(
                                color: colors(context).blackColor),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 0.h),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: SlidingSegmentedBar(
                        selectedTextStyle: size14weight700.copyWith(
                            color: colors(context).whiteColor),
                        textStyle: size14weight700.copyWith(
                            color: colors(context).blackColor),
                        backgroundColor: colors(context).whiteColor,
                        onChanged: (int value) {
                          if(value==0){
                            isOtherBankTabSelected = false;
                          }
                          if(value==1){
                            isOtherBankTabSelected = true;

                          }
                          setState(() {
                            current = value;
                          });
                        },
                        selectedIndex: current,
                        children: [ AppLocalizations.of(context).translate("union_bank"),AppLocalizations.of(context).translate("other_bank")],
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: colors(context).whiteColor
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               isOtherBankTabSelected = false;
                    //             });
                    //           },
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8).r,
                    //               color: isOtherBankTabSelected
                    //                   ? Colors.white
                    //                   : colors(context).primaryColor,
                    //             ),
                    //             padding: const EdgeInsets.only(top: 12,bottom: 12),
                    //             child: Center(
                    //               child: Text(
                    //                 AppLocalizations.of(context).translate("union_bank"),
                    //                 style: isOtherBankTabSelected ? size14weight700.copyWith(color: colors(context).blackColor) : size14weight700.copyWith(color: colors(context).whiteColor),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(
                    //           onTap: () {
                    //             setState(() {
                    //               isOtherBankTabSelected = true;
                    //             });
                    //           },
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8),
                    //               color: isOtherBankTabSelected
                    //                   ? colors(context).primaryColor
                    //                   : Colors.white,
                    //             ),
                    //             padding: const EdgeInsets.only(top: 12,bottom: 12),
                    //             child: Center(
                    //               child: Text(
                    //                 AppLocalizations.of(context).translate("other_bank"),
                    //                 style: isOtherBankTabSelected ? size14weight700.copyWith(color: colors(context).whiteColor) : size14weight700.copyWith(color: colors(context).blackColor),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if(isOtherBankTabSelected)
                      Expanded(
                          child:justpayInstrumentList.isNotEmpty? _otherBankList() :SizedBox.shrink() // Placeholder for "Union Bank" tab
                      ),
                    if(!isOtherBankTabSelected)
                      Expanded(child: _UbBankList()),

                  ],),
                ),
                  Visibility(
                    visible: isOtherBankTabSelected,
                    child: Positioned(
                      bottom: 64 + AppSizer.getHomeIndicatorStatus(context),
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  Routes.kManageOtherBankForm,
                                ).then((value) {
                                  if (value != null && value is bool && value) {
                                    if(value==true)
                                    {bloc.add(GetJustpayInstrumentEvent(
                                      requestType: RequestTypes.ACTIVE.name,
                                    ));}
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:  colors(context).primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14).w,
                                  child: PhosphorIcon(PhosphorIcons.plus(PhosphorIconsStyle.bold) , color: colors(context).whiteColor,size: 28.w,),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
              ]
            ),
          )
      ),
    );
  }

  Widget _otherBankList() {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: SingleChildScrollView(
        key: Key("p"),
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).w,
              color: colors(context).whiteColor,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: justpayInstrumentList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
                    child: OtherBankComponent(
                      isArrow: true,
                      icon: justpayInstrumentList[index].icon,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.kManageOtherBankDetails,
                          arguments: ManageOtherBankDetailArgs(
                            icon: justpayInstrumentList[index].icon,
                            isEditView: true,
                            otherBankDetails: justpayInstrumentList[index],
                          ),
                        ).then((value){
                          if (value != null && value is bool && value) {
                        if(value==true)
                        {bloc.add(GetJustpayInstrumentEvent(
                          requestType: RequestTypes.ACTIVE.name,
                        ));}
                      }
                        });
                      },
                      manageOtherBankAccountEntity: justpayInstrumentList[index],
                    ),
                  ),
                  // 2.verticalSpace,
                  if(justpayInstrumentList.length-1 != index)
                    Padding(
                      padding: const EdgeInsets.only(left: 16 , right: 16).w,
                      child: Divider(
                        thickness: 1,
                        height: 0,
                        color: colors(context).greyColor100,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _UbBankList() {
    return Padding(
      padding: const EdgeInsets.only(top: 24).h,
      child: SingleChildScrollView(
        key: Key("o"),
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).w,
              color: colors(context).whiteColor,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: accList.length,
                physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                 Column(
                   children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 16 , right: 16).w,                       child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.kUnionBankEditView,
                                arguments: unionBankAccountDetailsArgs(
                                  managePayDesign: getManagePayDesign.first,
                                  availableBalance: accList[index].availableBalance!,
                                  actualeBalance: accList[index].actualBalance,
                                  instrumentId: accList[index].instrumentId ?? 0,
                                  accountNumber: accList[index].accountNumber!,
                                  accountName: accList[index].productName!,
                                  overDraftedLimit: accList[index].overDraftedLimit ?? "",
                                  unClearedBalance: accList[index].unclearedBalance!,
                                  openDate: accList[index].openedDate,
                                  accountStatus: accList[index].status ?? "",
                                  nickName: accList[index].nickName ?? "",
                                  branchName: accList[index].branchName ?? "",
                                  holdBalance: accList[index].holdBalance ?? "",
                                  productName: accList[index].productName??"",
                                  effectiveInterestRate:
                                      accList[index].effectiveInterestRate ?? "",
                                  currency: accList[index].cfcurr ?? AppLocalizations.of(context).translate("lkr"),
                                )).then((value) {
                            if (value != null && value is bool && value) {
                              if(value==true)
                              {
                                  bloc.add(GetManageAccDetailsEvent());
                                }
                              }
                          });
                          },
                          child: UbCard(
                                  accountNumber: accList[index].accountNumber ?? "-",
                                  actualBalance: accList[index].actualBalance,
                                  availableBalance: accList[index].availableBalance,
                                  productName: accList[index].productName.toString().toTitleCase(),
                                  nickName: accList[index].nickName,
                                //  design: getManagePayDesign[index % getManagePayDesign.length],
                                design: getManagePayDesign.first,
                                currency: accList[index].cfcurr ?? AppLocalizations.of(context).translate("lkr"),
                              ),
                          // UBPortfolioContainerMain(
                          //   // isPrimary: true,
                          //   title: accList[index].productName!,
                          //   subTitle: accList[index].accountNumber!,
                          //   availableAmount: accList[index]
                          //       .availableBalance!
                          //       .toString()
                          //       .withThousandSeparator(),
                          //   actualAmount: accList[index]
                          //       .unclearedBalance!
                          //       .toString()
                          //       .withThousandSeparator(),
                          // ),
                                       ),
                       ),
                       if(accList.length-1 != index)
                         Padding(
                           padding: const EdgeInsets.only(left:16 , right: 16).w,
                           child: Divider(
                            thickness: 1,
                             height: 0,
                             color: colors(context).greyColor100,
                           ),
                         ),
                     ],
                 )
            ),
          ),
        ),
      ),
    );
  }

    List<ManagePayDesign> get getManagePayDesign=>
     [
      ManagePayDesign(
          backgroundColor: colors(context).primaryColor!,
          fontColor: colors(context).whiteColor!,
          dividerColor: colors(context).primaryColor300!),
           ManagePayDesign(
          backgroundColor: colors(context).secondaryColor!,
          fontColor: colors(context).blackColor!,
          dividerColor: colors(context).secondaryColor800!),
           ManagePayDesign(
          backgroundColor: colors(context).primaryColor200!,
          fontColor: colors(context).blackColor!,
          dividerColor: colors(context).primaryColor300!),
           ManagePayDesign(
          backgroundColor: colors(context).blackColor!,
          fontColor: colors(context).whiteColor!,
          dividerColor: colors(context).blackColor400!),
           ManagePayDesign(
          backgroundColor: colors(context).greyColor!,
          fontColor: colors(context).whiteColor!,
          dividerColor: colors(context).greyColor300!)
    ];
  
    
  // void updateValues() {
  //   setState(() {
  //     accountTotal = AppConstants.totalAccountBalance.toStringAsFixed(2);
  //     accList.addAll(AppConstants.accountDetailsResponseDtos);
  //   });
  // }



  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
