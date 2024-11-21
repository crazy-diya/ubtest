import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' ;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/account_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/response/saved_payee_entity.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

class AppCarouselWidget extends StatefulWidget {
  final List<AccountEntity>? accountList;
  final List<SavedPayeeEntity>? savedPayees;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final Function(bool)? onPageInSaved;
  final Function()? onTap;
  final bool? isCornerNotRound;
  final bool? isSavedPayee;
  final ValueNotifier<bool>? isSavedPayeeSelected;
  final CarouselSliderController? carouselController;
  final int? savedPayeLength;

  AppCarouselWidget({
    Key? key,
    this.accountList,
    required this.onPageChanged,
    this.onPageInSaved,
    this.isCornerNotRound = false,
    this.isSavedPayee = false,
    this.isSavedPayeeSelected,
    this.onTap,
    this.savedPayees,
    this.carouselController,
    this.savedPayeLength = 0,
  });

  @override
  State<AppCarouselWidget> createState() => _AppCarouselWidgetState();
}

class _AppCarouselWidgetState extends State<AppCarouselWidget> {
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
        padding: const EdgeInsets.fromLTRB(16,16,16,16,).w,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap: widget.isSavedPayee == true
                        ? _savedCurrent == 0
                        ? null
                        : () {
                      _carouselController.previousPage();
                    }
                        : _current == 0
                        ? null
                        : () {
                      _carouselController.previousPage();
                    },
                    child: PhosphorIcon(
                        PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                        color: widget.isSavedPayee == true
                            ? _savedCurrent == 0
                            ? colors(context).greyColor300
                            : colors(context).greyColor
                            : _current == 0
                            ? colors(context).greyColor300
                            : colors(context).greyColor
                      // (_current == 0 && _savedCurrent == 0) ? colors(context).greyColor300 : colors(context).greyColor,
                    )),
                12.horizontalSpace,
                widget.isSavedPayee == true
                    ? Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.savedPayeLength,
                    itemBuilder: (BuildContext context, int index,
                        int realIndex) =>
                    widget.savedPayeLength! - 1 == index
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
                                      PhosphorIcons.users(
                                          PhosphorIconsStyle
                                              .bold),
                                      color: colors(context)
                                          .primaryColor,
                                    ),
                                  ),
                                  2.horizontalSpace,
                                  Text(
                                    widget.isSavedPayeeSelected
                                        ?.value ==
                                        true
                                        ? AppLocalizations.of(
                                        context)
                                        .translate(
                                        "change_payee")
                                        : AppLocalizations.of(
                                        context)
                                        .translate(
                                        "select_payee"),
                                    style: size16weight700
                                        .copyWith(
                                        color: colors(
                                            context)
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
                              Container(
                                width: 64.w,
                                height: 64.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8)
                                        .r,
                                    border: Border.all(
                                      strokeAlign: BorderSide.strokeAlignInside,
                                        color: colors(context)
                                            .greyColor300!)),
                                child: (widget
                                    .savedPayees?[index]
                                    .payeeImageUrl ==
                                    null)
                                    ? Center(
                                  child: Text(
                                    widget
                                        .savedPayees?[
                                    index]
                                        .nickName
                                        ?.toString()
                                        .getNameInitial() ??
                                        "",
                                    style: size20weight700
                                        .copyWith(
                                        color: colors(
                                            context)
                                            .primaryColor),
                                  ),
                                )
                                    : Center(
                                  child: ClipRRect(
                                     borderRadius:
                                    BorderRadius.circular(8)
                                        .r,
                                    child: Image.asset(
                                      widget
                                          .savedPayees?[
                                      index]
                                          .payeeImageUrl ??
                                          "",
                                          fit: BoxFit.cover,
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
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    2.verticalSpace,
                                    SizedBox(
                                    width: (MediaQuery.of(context).size.width/2),
                                      child: Text(
                                          widget.savedPayees?[index]
                                              .nickName ??
                                              "",
                                              overflow: TextOverflow.ellipsis,
                                          //AppConstants.accountDetailsResponseDtos[index].productName!,
                                          style: size16weight700
                                              .copyWith(
                                              color: colors(
                                                  context)
                                                  .blackColor)),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                        widget.savedPayees?[index]
                                            .accountNumber ??
                                            "",
                                        // AppConstants.accountDetailsResponseDtos[index].accountNumber!,
                                        style: size14weight400
                                            .copyWith(
                                            color: colors(
                                                context)
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
                      height: 64.h,
                      // padEnds: widget.savedPayees?.isEmpty ??true,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        widget.onPageInSaved?.call(
                            (widget.savedPayeLength! - 1) == index);
                        if ((widget.savedPayeLength! - 1) != index) {
                          widget.onPageChanged.call(index, reason);
                        }
                        _savedCurrent = index;
                        setState(() {});
                      },
                    ),
                  ),
                )
                    : Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.accountList?.length,
                    itemBuilder: (BuildContext context, int index,
                        int realIndex) =>
                        Row(
                          children: [
                            Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8).r,
                                  border: Border.all(
                                      color: colors(context)
                                          .greyColor300!)),
                              child: (widget.accountList?[index].icon ==
                                  null)
                                  ? Center(
                                child: Text(
                                  widget.accountList?[index]
                                      .nickName
                                      ?.toString()
                                      .getNameInitial() ??
                                      "",
                                  style: size20weight700.copyWith(
                                      color: colors(context)
                                          .primaryColor),
                                ),
                              )
                                  : Center(
                                child: ClipRRect(
                                     borderRadius:
                                    BorderRadius.circular(8)
                                        .r,
                                  child: Image.asset(
                                    widget.accountList?[index]
                                        .icon ??
                                        "",
                                  ),
                                ),
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  8.verticalSpace,
                                 SizedBox(
                                  width: (MediaQuery.of(context).size.width/2),
                                    child: Text(
                                        widget.accountList?[index]
                                            .nickName ??
                                            "",
                                            overflow: TextOverflow.ellipsis,
                                        //AppConstants.accountDetailsResponseDtos[index].productName!,
                                        style: size16weight700.copyWith(
                                            color: colors(context)
                                                .blackColor)),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                      widget.accountList![index]
                                          .accountNumber ??
                                          "",
                                      // AppConstants.accountDetailsResponseDtos[index].accountNumber!,
                                      style: size14weight400.copyWith(
                                          color: colors(context)
                                              .blackColor)),
                                  8.verticalSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 64.w,
                      padEnds: widget.accountList?.isEmpty ?? true,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        widget.onPageChanged.call(index, reason);
                        _current = index;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                12.horizontalSpace,
                InkWell(
                    onTap: widget.isSavedPayee == true
                        ? _savedCurrent == 3
                        ? null
                        : () {
                      _carouselController.nextPage();
                      setState(() {});
                    }
                        : _current + 1 == widget.accountList?.length
                        ? null
                        : () {
                      _carouselController.nextPage();
                      setState(() {});
                    },
                    child: PhosphorIcon(
                        PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                        color: widget.isSavedPayee == true
                            ? _savedCurrent == 3
                            ? colors(context).greyColor300
                            : colors(context).greyColor
                            : _current + 1 == widget.accountList?.length
                            ? colors(context).greyColor300
                            : colors(context).greyColor))
                // (_current +1 == widget.accountList?.length || _savedCurrent  == 4 ) ? colors(context).greyColor300 : colors(context).greyColor,)),
              ],
            ),
            widget.isSavedPayee == true
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                  child: Column(
                                children: [
                  16.verticalSpace,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          widget.savedPayeLength!,
                              (index) => GestureDetector(
                            onTap: () => _carouselController
                                .animateToPage(index),
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4)
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
                          )).toList()
                    //   widget.savedPayees!
                    //     .asMap()
                    //     .entries
                    //     .map((entry) {
                    //   return GestureDetector(
                    //     onTap: () => _carouselController.animateToPage(widget.savedPayees?.length ==_savedCurrent?entry.key+1:entry.key),
                    //     child: Container(
                    //       width: 2.w,
                    //       height: 2.w,
                    //       margin:
                    //       const EdgeInsets.symmetric(horizontal: 1.0).w,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color:widget.savedPayees?.length == _savedCurrent ?colors(context)
                    //             .secondaryColor!
                    //             .withOpacity(
                    //             _savedCurrent == entry.key+1 ? 0.9 : 0.4):colors(context)
                    //             .secondaryColor!
                    //             .withOpacity(
                    //             _savedCurrent == entry.key ? 0.9 : 0.4),
                    //       ),
                    //     ),
                    //   );
                    // }).toList(),
                  ),
                                ],
                              ),
                )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                  child: Column(
                                children: [
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    widget.accountList!.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 4).w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? colors(context).secondaryColor
                                : colors(context)
                                .secondaryColor800
                                ?.withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                                ],
                              ),
                ),
          ],
        ),
      ),
    );
  }
}
