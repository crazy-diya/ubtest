import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_search_text_field.dart';
import '../widgets/credit_card_details_card.dart';
import 'data/credit_card_entity.dart';
import 'data/select_credit_card_view_args.dart';

class SelectCreditCardView extends BaseView {
  final SelectCreditCardViewArgs selectCreditCardViewArgs;

  SelectCreditCardView({
    required this.selectCreditCardViewArgs,
  });

  @override
  State<SelectCreditCardView> createState() => _SelectCreditCardViewState();
}

class _SelectCreditCardViewState extends BaseViewState<SelectCreditCardView> {
  final bloc = injection<CreditCardManagementBloc>();
  final searchController = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();

  bool isDeleteAvailable = false;
  String _searchString = '';
  List<CreditCardDetailsCard> creditCardList = [];
  List<CreditCardDetailsCard> searchCreditCardList = [];

  CreditCardEntity? selectedCard;

  bool isMarked = false;
  int current = 0;

  List<String> deleteMultipleAccount = [];

  @override
  void initState() {
    super.initState();
    creditCardList.addAll(widget.selectCreditCardViewArgs.cardList);
    searchCreditCardList.addAll(widget.selectCreditCardViewArgs.cardList);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("select_credit_card"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20).w,
        child: Column(
          children: [
            SearchTextField(
              isBorder: false,
              hintText: AppLocalizations.of(context).translate("search"),
              textEditingController: searchController,
              focusNode: _focusNodeSearch,
              onChange: (p0) {
                setState(() {
                  searchFromCreditCardList(p0);
                });
              },
            ),
            24.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                key: Key("o"),
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.h +
                          ((isDeleteAvailable == true &&
                                  deleteMultipleAccount.length != 0)
                              ? 0
                              : AppSizer.getHomeIndicatorStatus(context))),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16).w,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchCreditCardList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            Navigator.pop(context, searchCreditCardList[index]);
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16.0)
                                          .w,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 6.0)
                                            .h,
                                        child: Container(
                                          width: 64.w,
                                          height: 64.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8).r,
                                              border: Border.all(
                                                  strokeAlign: BorderSide
                                                      .strokeAlignInside,
                                                  color: colors(context)
                                                      .greyColor300!)),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8).r,
                                              child: Image.asset(
                                                AppAssets.ubBank,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      12.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          2.verticalSpace,
                                          Text(
                                              searchCreditCardList[index]
                                                      .cardType ??
                                                  "",
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          4.verticalSpace,
                                          Text(
                                              searchCreditCardList[index]
                                                      .availableBalance
                                                      .toString() ??
                                                  "",
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          4.verticalSpace,
                                          Text(
                                              searchCreditCardList[index]
                                                      .maskedCardNumber ??
                                                  "",
                                              style: size14weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor)),
                                          2.verticalSpace,
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (searchCreditCardList.length - 1 != index)
                                  Divider(
                                    thickness: 1,
                                    height: 0,
                                    color: colors(context).greyColor100,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchFromCreditCardList(String message) {
    if (message.trim().isEmpty) {
      searchCreditCardList = creditCardList;
    } else {
      searchCreditCardList = creditCardList
          .where((element) =>
              element.cardType!.toLowerCase().contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
