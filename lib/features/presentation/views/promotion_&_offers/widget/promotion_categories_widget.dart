import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../../../domain/entities/response/promo_and_offers_category_entity.dart';

class PromoCategories extends StatefulWidget {
  final PromoAndOffersCategoryEntity offerDetails;
  const PromoCategories(this.offerDetails);
  @override
  State<PromoCategories> createState() => _PromoCategoriesState();
}

class _PromoCategoriesState extends State<PromoCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.offerDetails.isSelected
            ? colors(context).primaryColor!
            : null,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8).w,
          child: Text(
            widget.offerDetails.label!,
            style: size14weight700.copyWith(
              color: widget.offerDetails.isSelected
                  ? colors(context).whiteColor
                  : colors(context).blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
