import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';


class PayBillsComponent extends StatelessWidget {
  final BillerCategoryEntity? billerCategoryEntity;
  final VoidCallback? onTap;

  const PayBillsComponent({this.billerCategoryEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16).w,
        child: Row(
          children: [
           Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: colors(context).greyColor300!)
                    ),
                    child:  billerCategoryEntity?.logoUrl == null
                          ? Center(
                            child: Text(billerCategoryEntity?.categoryName?.toString().getNameInitial()??"" ,
                                style: size20weight700.copyWith(
                                    color: colors(context).primaryColor),
                              ),
                          )
                          : CachedNetworkImage(
                      imageUrl:  billerCategoryEntity!.logoUrl!,
                      imageBuilder: (context, imageProvider) => Container(
                        
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6).r,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,),
                        ),
                      ),
                      placeholder: (context, url) =>  Center(
                        child: SizedBox(height: 20.w,
                          width: 20.w,
                          child: CircularProgressIndicator(color: colors(context).primaryColor),
                        ),
                      ),
                      errorWidget: (context, url, error) => PhosphorIcon(
                                  PhosphorIcons.warningCircle(
                                      PhosphorIconsStyle.bold),
                                ),
                    )
                  ),
                   12.horizontalSpace,
            Expanded(
              child: Row(
                children: [
                  Text(
                    billerCategoryEntity!.categoryName ?? "",
                    style: size16weight700.copyWith(color: colors(context).greyColor)),
                  const Spacer(),
                  PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
                    color: colors(context).greyColor300,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
