import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/loyalty_points/card_details_entity.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/card_management/card_list_response.dart';
import '../../../../domain/entities/request/credit_card_mngmt_request_entity.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../base_view.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';

class LoyaltyManagementView extends BaseView {
  const LoyaltyManagementView({super.key});

  @override
  State<LoyaltyManagementView> createState() => _LoyaltyManagementViewState();
}

class _LoyaltyManagementViewState extends BaseViewState<LoyaltyManagementView> {
  final bloc = injection<CreditCardManagementBloc>();

  CreditCardMngmtRequestEntity? tempSelectedCreditCard;

  CardResPrimaryCardDetail? selectedCardDetails;
  List<CardResPrimaryCardDetail> primaryCardDetailsList = [];

  @override
  void initState() {
    super.initState();
    bloc.add(GetCardListEvent());
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
               if(state is GetCardListLoadedState){
                 setState(() {
                   primaryCardDetailsList = state.cardListResponse!.resPrimaryCardDetails??[];
                   primaryCardDetailsList = primaryCardDetailsList.where((element) => (element.displayFlag?.toUpperCase() == "Y")).toList();
                   primaryCardDetailsList = primaryCardDetailsList.where((element) => (extractFirstSixDigits(element.resMaskedPrimaryCardNumber ?? "") == "428767") ||
                       (extractFirstSixDigits(element.resMaskedPrimaryCardNumber ?? "") == "428770") || (extractFirstSixDigits(element.resMaskedPrimaryCardNumber ?? "") == "433333") || ((extractFirstSixDigits(element.resMaskedPrimaryCardNumber ?? "") == "422222"))).toList();
                   // primaryCardDetailsList = primaryCardDetailsList.where((element) => (element.resCardTypeWithDesc?.toUpperCase() == "24300-UB SIGNATURE CARD")).toList();
                   // primaryCardDetailsList = primaryCardDetailsList.where((element) => (element.resCardTypeWithDesc?.toUpperCase() == "24210-UB PLATINUM STAFF")).toList();
                   // primaryCardDetailsList = primaryCardDetailsList.where((element) => (element.resCardTypeWithDesc?.toUpperCase() == "24200-UB PLATINUM CARD")).toList();
                   selectedCardDetails = primaryCardDetailsList.first;
                 });
                   if(state.cardListResponse!.resPrimaryCardDetails!= null) {
                     bloc.add(GetCardDetailsEvent(
                         maskedPrimaryCardNumber: selectedCardDetails?.resMaskedPrimaryCardNumber
                     ));
                   }
               }else  if(state is GetCardDetailsSuccessState){
                 setState(() {
                   if(state.cardDetailsResponse!=null){
                     tempSelectedCreditCard = CreditCardMngmtRequestEntity(
                         title: selectedCardDetails?.resCardTypeWithDesc ?? "",
                         cardNo: selectedCardDetails
                             ?.resMaskedPrimaryCardNumber ?? "",
                       availablePoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints??"",
                       pointsAboutToExpire: state.cardDetailsResponse?.resPointsToBeExpire??"",
                     );
                   }
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
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                            data: tempSelectedCreditCard?.availablePoints ??
                                "-",
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 16.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  "points_about_to_expire"),
                                          style: size14weight700.copyWith(
                                            color: colors(context).blackColor,
                                          )),
                                      Text(
                                        "(${AppLocalizations.of(context).translate("in_the_next_three_months")})",
                                        style: size14weight400.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    tempSelectedCreditCard?.pointsAboutToExpire ??
                                        "-",
                                    style: size14weight400.copyWith(
                                      color: colors(context).greyColor,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                      AppLocalizations.of(context).translate("redeem_points"),
                  onTapButton: () async {
                    Navigator.pushNamed(
                        context, Routes.kRedeemPointsView , arguments: CardDetailsEntity(
                        selectedCardDetails: selectedCardDetails, primaryCardDetailsList: primaryCardDetailsList,
                      tempSelectedCreditCard: tempSelectedCreditCard
                    ));
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

  // String? extractFirstSixDigits(String input) {
  //   RegExp regExp = RegExp(r'^\d{6}');
  //   Match? match = regExp.firstMatch(input);
  //
  //   if (match != null) {
  //     return match.group(0);
  //   } else {
  //     return "";
  //   }
  //   // final RegExp regex = RegExp(r'^\d+');
  //   // final RegExpMatch? match = regex.firstMatch(input);
  //   //
  //   // if (match != null) {
  //   //   return match.group(0); // Returns the matched number as a string
  //   // } else {
  //   //   return null; // No match found
  //   // }
  // }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
