import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/requests/voucher_entity.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../../domain/entities/response/saved_payee_entity.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../../otp/otp_view.dart';
import '../widgets/selected_voucher_card.dart';

class RedemptionSummaryViewArgs {
  final VoucherEntity? voucher1;
  final bool voucher1selected;
  final VoucherEntity? voucher2;
  final bool voucher2selected;
  final String? maskNumber;

  RedemptionSummaryViewArgs({
    this.voucher1selected = false,
    this.voucher1,
    this.voucher2selected = false,
    this.voucher2,
    this.maskNumber
  });
}

class RedemptionSummaryView extends BaseView {
  final RedemptionSummaryViewArgs redemptionSummaryViewArgs;

  RedemptionSummaryView({
    required this.redemptionSummaryViewArgs,
  });

  @override
  State<RedemptionSummaryView> createState() => _RedemptionSummaryViewState();
}

class _RedemptionSummaryViewState extends BaseViewState<RedemptionSummaryView> {
  final bloc = injection<CreditCardManagementBloc>();
  SavedPayeeEntity savedPayeeEntity = SavedPayeeEntity();
  List<CommonDropDownResponse>? branchList = [];
  List<CommonDropDownResponse>? searchBranchList = [];
  List<CommonDropDownResponse> searchBankList = [];
  String? branchName;
  String? branchCode;
  String? branchNameTemp;
  String? branchCodeTemp;

  num totalPoints = 0;
  bool _checkbox = false;
  List<Map<String, int>> redeemOptions =[];

  @override
  void initState() {
    calculateTotal();
    redeemOptionsList();
    bloc.add(GetPayeeBankBranchEventForCard(
      bankCode: "7302",
    ));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("redemption_summary"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
      create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
      listener: (context, state) {
        if (state is GetPayeeBranchSuccessStateForCard) {
            setState(() {
             branchList = state.data;
            searchBranchList = branchList;
          });

    }else if(state is GetCardLoyaltyRedeemSuccessState){
           Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
        }else if(state is GetCardLoyaltyRedeemFailedState){
          showAppDialog(
              alertType: AlertType.WARNING,
              isSessionTimeout: true,
              title: ErrorHandler.TITLE_OOPS,
              message: state.message,
              onPositiveCallback: () {
                Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
              });

        }
  },
  child: Padding(
        padding: EdgeInsets.fromLTRB(
            20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              PhosphorIcon(
                                PhosphorIcons.ticket(PhosphorIconsStyle.bold),
                                color: colors(context).blackColor,
                              ),
                              9.horizontalSpace,
                              Text(
                                "${AppLocalizations.of(context).translate("voucher")} 1",
                                style: size14weight700.copyWith(
                                    color: colors(context).blackColor),
                              ),
                            ],
                          ),
                          widget.redemptionSummaryViewArgs.voucher1selected == true
                              ? Column(
                                  children: [
                                    16.verticalSpace,
                                    SelectedVoucherCard(
                                      costOfVouchers:
                                      widget.redemptionSummaryViewArgs.voucher1!.costOfVouchers,
                                      noOfVouchers:
                                      widget.redemptionSummaryViewArgs.voucher1!.numberOfVouchers,
                                      voucherName: widget.redemptionSummaryViewArgs.voucher1!.VoucherName,
                                    )
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),

          widget.redemptionSummaryViewArgs.voucher2selected == true
              ?  Column(
                children: [
                  16.verticalSpace,
                  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  PhosphorIcon(
                                    PhosphorIcons.ticket(PhosphorIconsStyle.bold),
                                    color: colors(context).blackColor,
                                  ),
                                  9.horizontalSpace,
                                  Text(
                                    "${AppLocalizations.of(context).translate("voucher")} 2",
                                    style: size14weight700.copyWith(
                                        color: colors(context).blackColor),
                                  ),
                                ],
                              ),
                              Column(
                                      children: [
                                        16.verticalSpace,
                                        SelectedVoucherCard(
                                          costOfVouchers:
                                          widget.redemptionSummaryViewArgs.voucher2!.costOfVouchers,
                                          noOfVouchers:
                                          widget.redemptionSummaryViewArgs.voucher2!.numberOfVouchers,
                                          voucherName: widget.redemptionSummaryViewArgs.voucher2!.VoucherName,
                                        )
                                      ],
                                    )

                            ],
                          ),
                        ),
                      ),
                ],
              ): SizedBox.shrink(),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                      child: Column(
                        children: [
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context)
                                .translate("total_points"),
                            data: totalPoints.toStringAsFixed(0),
                            isLastItem: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    AppLocalizations.of(context).translate("delivery_option"),
                    style: size14weight700.copyWith(
                        color: colors(context).blackColor),
                  ),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 8.h, 16.w, 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4).w),
                            checkColor: colors(context).whiteColor,
                            activeColor: colors(context).primaryColor,
                            value: _checkbox,
                            onChanged:branchName==null? (value) {
                              setState(() {
                                _checkbox = !_checkbox;
                              });
                            }:null,
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("delivery_option_description"),
                              style: size16weight700.copyWith(
                                  color: colors(context).greyColor),
                            ),
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    AppLocalizations.of(context)
                        .translate("collect_from_ub_branch"),
                    style: size14weight700.copyWith(
                        color: colors(context).blackColor),
                  ),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      child: AppDropDown(
                        isDisable: _checkbox,
                        label: AppLocalizations.of(context).translate("branch"),
                        labelText: AppLocalizations.of(context)
                            .translate("select_branch"),
                        onTap: () async {
                          //final result =
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
                                      isSearch: true,
                                      onSearch: (p0) {
                                        changeState(() {
                                          if (p0.isEmpty || p0 == '') {
                                            searchBranchList = branchList;
                                          } else {
                                            searchBranchList = branchList
                                                ?.where((element) => element
                                                    .description!
                                                    .toLowerCase()
                                                    .contains(p0.toLowerCase())).toSet()
                                                .toList();
                                          }
                                        });
                                      },
                                      title: AppLocalizations.of(context)
                                          .translate('select_branch'),
                                      buttons: [
                                        Expanded(
                                          child: AppButton(
                                              buttonType:
                                                  ButtonType.PRIMARYENABLED,
                                              buttonText:
                                                  AppLocalizations.of(context)
                                                      .translate("continue"),
                                              onTapButton: () {
                                                branchCode = branchCodeTemp;
                                                branchName = branchNameTemp;
                                                savedPayeeEntity.branchCode =
                                                    branchCode;
                                                savedPayeeEntity.branchName =
                                                    branchName;
                                               WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                Navigator.of(context).pop(true);
                                                changeState(() {});
                                                setState(() {});
                                              }),
                                        ),
                                      ],
                                      children: [
                                        ListView.builder(
                                          itemCount: searchBranchList?.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                branchCodeTemp =
                                                    searchBranchList![index]
                                                        .key;
                                                branchNameTemp =
                                                    searchBranchList![index]
                                                        .description;
                                                changeState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                                0,
                                                                index == 0
                                                                    ? 0
                                                                    : 20,
                                                                0,
                                                                20)
                                                            .h,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            searchBranchList![
                                                                        index]
                                                                    .description ??
                                                                "",
                                                            style:
                                                                size16weight700
                                                                    .copyWith(
                                                              color: colors(
                                                                      context)
                                                                  .blackColor,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                      right: 8)
                                                                  .w,
                                                          child:
                                                              UBRadio<dynamic>(
                                                            value:
                                                                searchBranchList![
                                                                            index]
                                                                        .key ??
                                                                    "",
                                                            groupValue:
                                                                branchCodeTemp,
                                                            onChanged: (value) {
                                                              branchCodeTemp =
                                                                  value;
                                                              branchNameTemp =
                                                                  searchBranchList![
                                                                          index]
                                                                      .description;
                                                              changeState(
                                                                  () {});
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if ((searchBranchList
                                                                  ?.length ??
                                                              0) -
                                                          1 !=
                                                      index)
                                                    Divider(
                                                      height: 0,
                                                      thickness: 1,
                                                      color: colors(context)
                                                          .greyColor100,
                                                    )
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }));

                          searchBranchList = branchList;
                          setState(() {});
                        },
                        initialValue: branchName,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Column(
              children: [
                20.verticalSpace,
                AppButton(
                  buttonText:
                      AppLocalizations.of(context).translate("continue"),
                  onTapButton:(branchName!=null || _checkbox)? () async {

                    Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                          phoneNumber: AppConstants.profileData.mobileNo
                              .toString(),
                          appBarTitle: "otp_verification",
                          requestOTP: true,
                          otpType: kloyaltypointsOtp,
                        )).then((value) {
                          if(value == true){
                            bloc.add(GetCardLoyaltyRedeemEvent(
                                maskedPrimaryCardNumber:widget.redemptionSummaryViewArgs.maskNumber ,
                                redeemPoints: totalPoints.toStringAsFixed(0),
                                sendToAddressFlag:_checkbox ,
                                collectBranch: branchCodeTemp!= null? branchCodeTemp: null,
                                redeemOptions:redeemOptions
                            ));
                          }
                        },);

                  }:(){

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

  void calculateTotal() {
    setState(() {
      if(widget.redemptionSummaryViewArgs.voucher1selected && widget.redemptionSummaryViewArgs.voucher2selected){
        totalPoints = (widget.redemptionSummaryViewArgs.voucher1!.costOfVouchers! *
            widget.redemptionSummaryViewArgs.voucher1!.numberOfVouchers!) +
            (widget.redemptionSummaryViewArgs.voucher2!.costOfVouchers! *
                widget.redemptionSummaryViewArgs.voucher2!.numberOfVouchers!);
      }else{
        totalPoints = widget.redemptionSummaryViewArgs.voucher1!.costOfVouchers! *
            widget.redemptionSummaryViewArgs.voucher1!.numberOfVouchers!;
      }


    });
  }

  void redeemOptionsList() {
    setState(() {
      redeemOptions.clear();
      if(widget.redemptionSummaryViewArgs.voucher1selected && widget.redemptionSummaryViewArgs.voucher2selected){
        redeemOptions.add({
          "loyaltyId": widget.redemptionSummaryViewArgs.voucher1?.voucherId??0,
          "qty": widget.redemptionSummaryViewArgs.voucher1?.numberOfVouchers?.toInt()??0,
        });
        redeemOptions.add({
          "loyaltyId": widget.redemptionSummaryViewArgs.voucher2?.voucherId??0,
          "qty": widget.redemptionSummaryViewArgs.voucher2?.numberOfVouchers?.toInt()??0,
        });
      }else{
        redeemOptions.add({
          "loyaltyId": widget.redemptionSummaryViewArgs.voucher1?.voucherId??0,
          "qty": widget.redemptionSummaryViewArgs.voucher1?.numberOfVouchers?.toInt()??0,
        });
      }
    });

   
  }
}
