import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/theme/theme_data.dart';
import '../../../../../../utils/app_assets.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../widgets/credit_card_details_card.dart';

class CardCarouselWidget extends StatefulWidget {
  final List<CreditCardDetailsCard>? cardList;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final Function(bool)? onPageInSelectCreditCard;
  final Function()? onTap;
  final bool? isCornerNotRound;
  final ValueNotifier<bool>? isSelectedCreditCard;
  final CarouselSliderController? carouselController;
  final int? creditCardsLength;

  CardCarouselWidget({
    Key? key,
    this.cardList,
    required this.onPageChanged,
    this.onPageInSelectCreditCard,
    this.isCornerNotRound = false,
    this.isSelectedCreditCard,
    this.onTap,
    this.carouselController,
    this.creditCardsLength = 0,
  });

  @override
  State<CardCarouselWidget> createState() => _CardCarouselWidgetState();
}

class _CardCarouselWidgetState extends State<CardCarouselWidget> {
  late CarouselSliderController _carouselController;
  int _current = 0;
  int _savedCurrent = 0;

  @override
  void initState() {
    _carouselController = widget.carouselController ?? CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.isCornerNotRound == false
            ? BorderRadius.circular(8).r
            : BorderRadius.only(
                bottomLeft: Radius.circular(8).r,
                bottomRight: Radius.circular(8).r),
        color: colors(context).whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16,
        ).w,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap: _savedCurrent == 0
                        ? null
                        : () {
                            _carouselController.previousPage();
                          },
                    child: PhosphorIcon(
                        PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                        color: _current == 0
                            ? colors(context).greyColor300
                            : colors(context).greyColor
                        // (_current == 0 && _savedCurrent == 0) ? colors(context).greyColor300 : colors(context).greyColor,
                        )),
                12.horizontalSpace,
                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.creditCardsLength,
                    itemBuilder: (BuildContext context, int index,
                            int realIndex) =>
                        widget.creditCardsLength! - 1 == index
                            ? InkWell(
                                onTap: widget.onTap,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 318.w,
                                        height: 64.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8).r,
                                            border: Border.all(
                                                color: colors(context)
                                                    .primaryColor!)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: PhosphorIcon(
                                                PhosphorIcons.cardholder(
                                                    PhosphorIconsStyle.bold),
                                                color: colors(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            8.horizontalSpace,
                                            Text(
                                              widget.isSelectedCreditCard
                                                          ?.value ==
                                                      true
                                                  ? AppLocalizations.of(context)
                                                      .translate(
                                                          "change_credit_card")
                                                  : AppLocalizations.of(context)
                                                      .translate(
                                                          "select_a_credit_card"),
                                              style: size16weight700.copyWith(
                                                  color: colors(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              2.verticalSpace,
                                              Text(
                                                  widget.cardList?[index]
                                                          .creditCardName ??
                                                      "",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: size16weight700.copyWith(
                                                      color: colors(context)
                                                          .blackColor)),
                                              4.verticalSpace,
                                              Text(
                                                  "LKR ${
                                                        widget.cardList?[index]
                                                            .crdPaymentAvailableBalance
                                                            .toString().withThousandSeparator()
                                                      }",
                                                  style: size16weight700.copyWith(
                                                      color: colors(context)
                                                          .blackColor)),
                                              4.verticalSpace,
                                              Text(
                                                  widget.cardList?[index]
                                                          .maskedCardNumber ??
                                                      "",
                                                  style: size14weight400.copyWith(
                                                      color: colors(context)
                                                          .blackColor)),
                                              2.verticalSpace,
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 76.h,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        widget.onPageInSelectCreditCard
                            ?.call((widget.creditCardsLength! - 1) == index);
                        if ((widget.creditCardsLength! - 1) != index) {
                          widget.onPageChanged.call(index, reason);
                        }
                        _savedCurrent = index;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                12.horizontalSpace,
                InkWell(
                  onTap: _savedCurrent == 3
                      ? null
                      : () {
                          _carouselController.nextPage();
                          setState(() {});
                        },
                  child: PhosphorIcon(
                      PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                      color: _savedCurrent == 3
                          ? colors(context).greyColor300
                          : colors(context).greyColor),
                )
                // (_current +1 == widget.accountList?.length || _savedCurrent  == 4 ) ? colors(context).greyColor300 : colors(context).greyColor,)),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  16.verticalSpace,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          widget.creditCardsLength!,
                          (index) => GestureDetector(
                                onTap: () =>
                                    _carouselController.animateToPage(index),
                                child: Container(
                                  width: 8.w,
                                  height: 8.w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4)
                                          .w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _savedCurrent == index
                                        ? colors(context).secondaryColor
                                        : colors(context)
                                            .secondaryColor800
                                            ?.withOpacity(0.4),
                                  ),
                                ),
                              )).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
