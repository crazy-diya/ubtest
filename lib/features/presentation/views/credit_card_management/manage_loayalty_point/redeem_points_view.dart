
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/manage_loayalty_point/redemtion_summary_view.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/models/requests/voucher_entity.dart';
import '../../../../data/models/responses/card_management/card_list_response.dart';
import '../../../../data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import '../../../../domain/entities/request/card_management/loyalty_points/card_details_entity.dart';
import '../../../../domain/entities/request/card_management/loyalty_points/select_voucher_entity.dart';
import '../../../../domain/entities/request/credit_card_mngmt_request_entity.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../widgets/selected_voucher_card.dart';

class RedeemPointsView extends BaseView {
  CardDetailsEntity? cardDetailsEntity;
   RedeemPointsView({super.key,
     required this.cardDetailsEntity,
   });

  @override
  State<RedeemPointsView> createState() => _RedeemPointsViewState();
}

class _RedeemPointsViewState extends BaseViewState<RedeemPointsView> {
  final bloc = injection<CreditCardManagementBloc>();

  CreditCardMngmtRequestEntity? tempSelectedCreditCard;

  CardResPrimaryCardDetail? selectedCardDetails;
  List<CardResPrimaryCardDetail> primaryCardDetailsList = [];
  List<CardLoyaltyList>? cardLoyaltyList = [];
  VoucherEntity? voucher1;
  bool voucher1selected = false;
  VoucherEntity? voucher2;
  bool voucher2selected = false;
  String? totalVaucherPoints1;
  String? totalVaucherPoints2;
  String? totalAvailablePoints;
  String? totalAvailablePointsToShow;
  int? minLoyaltyPoints;
  int? minLoyaltyPointsForVoucher;

  @override
  void initState() {
    setValues();
    super.initState();
    bloc.add(GetCardLoyaltyVouchersEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("loyalty_management"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
      create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
      listener: (context, state) {
        if(state is GetCardDetailsSuccessState){
          setState(() {
            if(state.cardDetailsResponse!=null){
              tempSelectedCreditCard = CreditCardMngmtRequestEntity(
                title: selectedCardDetails?.resCardTypeWithDesc ?? "",
                cardNo: selectedCardDetails
                    ?.resMaskedPrimaryCardNumber ?? "",
                availablePoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints??"",
                pointsAboutToExpire: state.cardDetailsResponse?.resPointsToBeExpire??"",
              );
              totalAvailablePoints = state.cardDetailsResponse?.resLoyaltyAvailablePoints??"";
              totalAvailablePointsToShow = state.cardDetailsResponse?.resLoyaltyAvailablePoints??"";
              totalAvailablePoint();
            }
          });
        }
        if(state is GetCardLoyaltyVouchersLoadedState){
          setState(() {
            cardLoyaltyList = state.cardLoyaltyVouchersResponse?.cardLoyaltyList;
            minLoyaltyPointsForVoucher = state.cardLoyaltyVouchersResponse?.minLoyaltyPoints;
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
                  Text(
                    AppLocalizations.of(context)
                        .translate("select_your_credit_card"),
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
                      padding: const EdgeInsets.all(16).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              final result = await showModalBottomSheet<bool>(
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
                                                  'select_your_credit_card'),
                                              buttons: [
                                                Expanded(
                                                  child: AppButton(
                                                      buttonType:
                                                      ButtonType.PRIMARYENABLED,
                                                      buttonText: AppLocalizations
                                                          .of(context)
                                                          .translate("continue"),
                                                      onTapButton: () {
                                                        setState(() {
                                                          bloc.add(GetCardDetailsEvent(
                                                              maskedPrimaryCardNumber: selectedCardDetails?.resMaskedPrimaryCardNumber
                                                          ));
                                                        });
                                                       WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                        Navigator.of(context)
                                                            .pop(true);
                                                        changeState(() {});
                                                        setState(() {});
                                                      }),
                                                ),
                                              ],
                                              children: [
                                                ListView.builder(
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  itemCount: primaryCardDetailsList.length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                          onTap: () {
                                                            selectedCardDetails =
                                                                primaryCardDetailsList[
                                                                    index];
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
                                                                    : 24.h,
                                                                0,
                                                                24.h),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                          width:
                                                                          48,
                                                                          height:
                                                                          48,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8)
                                                                                  .r,
                                                                              border:
                                                                              Border.all(color: colors(context).greyColor300!)),
                                                                          child: Center(
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8).r,
                                                                              child: Image
                                                                                  .asset(
                                                                                fit: BoxFit.cover,
                                                                                bankIcons
                                                                                    .firstWhere(
                                                                                      (element) => element.bankCode == "7302",
                                                                                )
                                                                                    .icon ??
                                                                                    "",
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      12.horizontalSpace,
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Text(
                                                                            primaryCardDetailsList[index].resCardTypeWithDesc ??
                                                                                "-",
                                                                            style: size16weight700.copyWith(
                                                                                color:
                                                                                colors(context).blackColor),
                                                                          ),
                                                                          4.verticalSpace,
                                                                          Text(
                                                                            primaryCardDetailsList[index].resMaskedPrimaryCardNumber ??
                                                                                "-",
                                                                            style: size14weight400.copyWith(
                                                                                color:
                                                                                colors(context).greyColor),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      8.w),
                                                                  child: UBRadio<
                                                                      dynamic>(
                                                                    value:
                                                                    primaryCardDetailsList[
                                                                    index],
                                                                    groupValue:selectedCardDetails,
                                                                    onChanged:
                                                                        (value) {
                                                                      selectedCardDetails = value;
                                                                      changeState(
                                                                              () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (primaryCardDetailsList
                                                              .length -
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
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8).r,
                                        border: Border.all(
                                            color: colors(context)
                                                .greyColor300!)),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8).r,
                                      child: Center(
                                          child: Image.asset(
                                            width: 44,
                                            height: 44,
                                            bankIcons
                                                .firstWhere(
                                                  (element) =>
                                              element.bankCode == "7302",
                                            )
                                                .icon!,
                                          )),
                                    ),
                                  ),
                                  24.horizontalSpace,
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(tempSelectedCreditCard?.title??"",
                                              overflow: TextOverflow.ellipsis,
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          8.verticalSpace,
                                          Text(tempSelectedCreditCard?.cardNo??"",
                                              style: size14weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  PhosphorIcon(
                                    PhosphorIcons.caretRight(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).greyColor300,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                .translate("available_points"),
                            data: totalAvailablePoint(),
                            // voucher1selected == true ?
                            // voucher2selected == true ?
                            //     ((int.parse(tempSelectedCreditCard?.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0")+double.parse(totalVaucherPoints2 ?? "0"))).toString() :
                            // ((int.parse(tempSelectedCreditCard?.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0"))).toString() :
                            // tempSelectedCreditCard?.availablePoints ??
                            //     "-",
                            isLastItem: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  InkWell(
                    onTap: () async {
                      setState(() {
                        AppConstants.selectedVoucherId = voucher1selected == true?voucher1?.voucherId.toString():null;
                      });
                      Navigator.pushNamed(context, Routes.kSelectVouchersView,
                          arguments: voucher1selected == true?
                      SelectVoucherEntity(
                        cardLoyaltyList: cardLoyaltyList,
                          minLoyaltyPoints: minLoyaltyPointsForVoucher,
                          availablePoints: num.parse(tempSelectedCreditCard?.availablePoints??"0"),
                          noVouchers:voucher1?.numberOfVouchers?.toInt() ,
                          voucherId: voucher1?.voucherId??null):
                          SelectVoucherEntity(
                            cardLoyaltyList: cardLoyaltyList,
                            minLoyaltyPoints: minLoyaltyPointsForVoucher,
                            availablePoints: num.parse(tempSelectedCreditCard?.availablePoints??"0"), ))
                          .then((value) {
                        if (value != null) {
                          voucher1 = value as VoucherEntity;
                          voucher1selected = true;
                          totalVaucherPoints1 = ((voucher1!.costOfVouchers??0)*(voucher1!.numberOfVouchers??0)).toString();
                          minLoyaltyPoints = voucher1?.minLoyaltyPoints;
                          if(voucher1?.voucherId == voucher2?.voucherId){
                            voucher2 = null;
                            voucher2selected = false;
                          }
                          totalAvailablePoint();
                          setState(() {});
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    PhosphorIcon(
                                      PhosphorIcons.ticket(
                                          PhosphorIconsStyle.bold),
                                      color: colors(context).blackColor,
                                    ),
                                    9.horizontalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("select_voucher_1"),
                                      style: size14weight700.copyWith(
                                          color: colors(context).blackColor),
                                    ),
                                  ],
                                ),
                                PhosphorIcon(
                                  PhosphorIcons.caretRight(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,
                                )
                              ],
                            ),
                            voucher1selected == true
                                ? Column(
                                    children: [
                                      16.verticalSpace,
                                      SelectedVoucherCard(
                                        costOfVouchers:
                                            voucher1!.costOfVouchers,
                                        noOfVouchers:
                                            voucher1!.numberOfVouchers,
                                        voucherName: voucher1!.VoucherName,
                                      )
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  voucher1selected == true
                      ? InkWell(
                    onTap: () async {
                      setState(() {
                        setState(() {
                          AppConstants.selectedVoucherId =voucher2selected == true? voucher2?.voucherId.toString():null;
                        });
                      });
                      Navigator.pushNamed(context, Routes.kSelectVouchersView, arguments:
                      voucher2selected == true?
                      SelectVoucherEntity(
                          cardLoyaltyList: cardLoyaltyList?.where((e) => e.id != voucher1?.voucherId).toList(),
                          minLoyaltyPoints: minLoyaltyPointsForVoucher,
                        availablePoints: num.parse(tempSelectedCreditCard?.availablePoints??"0"),
                          noVouchers:voucher2?.numberOfVouchers?.toInt() ,
                          voucherId: voucher2?.voucherId??null)
                          :SelectVoucherEntity(
                        cardLoyaltyList: cardLoyaltyList?.where((e) => e.id != voucher1?.voucherId).toList(),
                        minLoyaltyPoints: minLoyaltyPointsForVoucher,
                        availablePoints: num.parse(tempSelectedCreditCard?.availablePoints??"0"),))
                          .then((value) {
                        if (value != null) {
                          voucher2 = value as VoucherEntity;
                          voucher2selected = true;
                          totalVaucherPoints2 = ((voucher2!.costOfVouchers??0)*(voucher2!.numberOfVouchers??0)).toString();
                          totalAvailablePoint();
                          setState(() {});
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    PhosphorIcon(
                                      PhosphorIcons.ticket(
                                          PhosphorIconsStyle.bold),
                                      color: colors(context).blackColor,
                                    ),
                                    9.horizontalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("select_voucher_2"),
                                      style: size14weight700.copyWith(
                                          color: colors(context).blackColor),
                                    ),
                                  ],
                                ),
                                PhosphorIcon(
                                  PhosphorIcons.caretRight(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,
                                )
                              ],
                            ),
                            voucher2selected == true
                                ? Column(
                                    children: [
                                      16.verticalSpace,
                                      SelectedVoucherCard(
                                        costOfVouchers:
                                            voucher2!.costOfVouchers,
                                        noOfVouchers:
                                            voucher2!.numberOfVouchers,
                                        voucherName: voucher2!.VoucherName,
                                      )
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  )
                  :SizedBox.shrink(),
                ],
              ),
            )),
            Column(
              children: [
                20.verticalSpace,
                (voucher1selected || voucher2selected)?
                AppButton(
                  buttonText:
                      AppLocalizations.of(context).translate("continue"),
                  onTapButton: () async {
                    voucher1selected == true ?
                    voucher2selected == true ?
                    totalAvailablePoints = ((int.parse(tempSelectedCreditCard!.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0")+double.parse(totalVaucherPoints2 ?? "0"))).toString() :
                    totalAvailablePoints = ((int.parse(tempSelectedCreditCard!.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0"))).toString() :
                    totalAvailablePoints;
                    if((double.parse(totalVaucherPoints1 ?? "0") + double.parse(totalVaucherPoints2 ?? "0")) < minLoyaltyPoints!){
                      showAppDialog(
                          title: AppLocalizations.of(context).translate("increase_redeem_point"),
                          alertType: AlertType.WARNING,
                          message: AppLocalizations.of(context).translate("increase_redeem_point_des"),
                          positiveButtonText: AppLocalizations.of(context).translate("ok"),
                          onPositiveCallback: () {});
                    } else if(double.parse(totalAvailablePoints ?? "0")<0){
                      showAppDialog(
                                title: AppLocalizations.of(context).translate("less_available_points"),
                                alertType: AlertType.WARNING,
                                message: AppLocalizations.of(context).translate("less_available_points_des"),
                                positiveButtonText: AppLocalizations.of(context).translate("ok"),
                                onPositiveCallback: () {});
                    } else {
                      Navigator.pushNamed(context, Routes.kRedemptionSummaryView,
                          arguments: RedemptionSummaryViewArgs(
                            maskNumber: selectedCardDetails?.resMaskedPrimaryCardNumber,
                              voucher1: voucher1,
                              voucher1selected: voucher1selected,
                              voucher2: voucher2,
                              voucher2selected: voucher2selected));
                    }
                  },
                ):SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
),
),
    );
  }

  totalAvailablePoint(){
    voucher1selected == true ?
    voucher2selected == true ?
    totalAvailablePointsToShow = ((int.parse(tempSelectedCreditCard?.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0")+double.parse(totalVaucherPoints2 ?? "0"))).toString() :
    totalAvailablePointsToShow = ((int.parse(tempSelectedCreditCard?.availablePoints ?? "0")) - (double.parse(totalVaucherPoints1 ?? "0"))).toString() :
    totalAvailablePointsToShow = tempSelectedCreditCard?.availablePoints ?? "-";
    if(double.parse(totalAvailablePointsToShow ?? "0")<0){
      totalAvailablePointsToShow = "0";
    } else {
      totalAvailablePointsToShow = totalAvailablePointsToShow?.replaceAll('.0', '');
    }
    return totalAvailablePointsToShow?.replaceAll('.0', '');
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }

  void setValues() {
    setState(() {
      AppConstants.selectedVoucherId = null;
      primaryCardDetailsList = widget.cardDetailsEntity?.primaryCardDetailsList??[];
      tempSelectedCreditCard = widget.cardDetailsEntity?.tempSelectedCreditCard;
      selectedCardDetails = widget.cardDetailsEntity?.selectedCardDetails;
    });
  }
}
