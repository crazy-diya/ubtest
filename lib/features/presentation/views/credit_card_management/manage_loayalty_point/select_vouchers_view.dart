import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/data/models/requests/voucher_entity.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import '../../../../domain/entities/request/card_management/loyalty_points/select_voucher_entity.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/appbar.dart';
import '../../base_view.dart';
import '../widgets/voucher_selector_card.dart';

class SelectVouchersView extends BaseView {
  SelectVoucherEntity? selectVoucherEntity;
   SelectVouchersView({super.key,
     this.selectVoucherEntity});

  @override
  State<SelectVouchersView> createState() => _SelectVouchersViewState();
}

class _SelectVouchersViewState extends BaseViewState<SelectVouchersView> {
  final bloc = injection<CreditCardManagementBloc>();
  ScrollController _scrollController = ScrollController();
  int? count;
  int? voucherId;
  int? minLoyaltyPoints;
  List<CardLoyaltyList>? cardLoyaltyList = [];

  @override
  void initState() {
    super.initState();
    // bloc.add(GetCardLoyaltyVouchersEvent());
    cardLoyaltyList = widget.selectVoucherEntity?.cardLoyaltyList;
    minLoyaltyPoints = widget.selectVoucherEntity?.minLoyaltyPoints;
    count = widget.selectVoucherEntity?.noVouchers??0;
    voucherId = widget.selectVoucherEntity?.voucherId;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("vouchers"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
          listener: (context, state) {
            // if(state is GetCardLoyaltyVouchersLoadedState){
            //   setState(() {
            //     cardLoyaltyList = state.cardLoyaltyVouchersResponse?.cardLoyaltyList;
            //     minLoyaltyPoints = state.cardLoyaltyVouchersResponse?.minLoyaltyPoints;
            //
            //   });
            // }
          },
          child: Stack(
            children: [
              if(cardLoyaltyList?.length == 0)
                Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors(context).secondaryColor300,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: PhosphorIcon(
                          PhosphorIcons.ticket(PhosphorIconsStyle.bold),
                          color: colors(context).whiteColor,
                          size: 28,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      AppLocalizations.of(context)
                          .translate("no_vouchers"),
                      style: size18weight700.copyWith(
                          color: colors(context).blackColor),
                      textAlign: TextAlign.center,
                    ),
                    4.verticalSpace,
                    Text(
                      AppLocalizations.of(context)
                          .translate("no_vouchers_des"),
                      textAlign: TextAlign.center,
                      style: size14weight400.copyWith(
                          color: colors(context).greyColor300),

                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardLoyaltyList != null
                                ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: cardLoyaltyList?.length,
                                controller: _scrollController,
                                // scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(
                                    bottom: 20.h +
                                        AppSizer.getHomeIndicatorStatus(context)),
                                itemBuilder: (context, index) {
                                  return VoucherSelectorCard(
                                    availablePoints: widget.selectVoucherEntity?.availablePoints,
                                    voucherId: cardLoyaltyList?[index].id,
                                    qtyAvailable: cardLoyaltyList?[index].qtyAvailable?.toInt(),
                                    noOfVouchers:count!=0?(cardLoyaltyList?[index].id == voucherId?count:null):null,
                                    costOfVouchers: cardLoyaltyList?[index].pointValue,
                                    voucherName: cardLoyaltyList?[index].mbDescription,
                                    onTapSelected: (value) {
                                      setState(() {
                                        AppConstants.selectedVoucherId = null;
                                      });
                                      Navigator.pop(
                                          context,
                                          VoucherEntity(
                                            voucherId: cardLoyaltyList?[index].id,
                                            voucherCode: cardLoyaltyList?[index].code,
                                            costOfVouchers: cardLoyaltyList?[index].pointValue,
                                            numberOfVouchers: value,
                                            minLoyaltyPoints: minLoyaltyPoints,
                                            VoucherName: cardLoyaltyList?[index].mbDescription,));
                                    },
                                  );
                                })
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
