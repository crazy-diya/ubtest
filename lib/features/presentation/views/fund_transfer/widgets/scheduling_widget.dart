import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';

class SchedulingWidget extends StatelessWidget {
  final String? accountName;
  final String? accountNumber;
  final String? initialName;
  final String? amount;
  final String? icon;
  final String? tranType;
  final VoidCallback? onTap;
  final double width;
  final double height;
  bool? isAmountAvailable = true;

  SchedulingWidget(
      {this.accountName,
      this.accountNumber,
      this.amount,
      this.onTap,
      this.initialName,
        this.tranType,
      this.isAmountAvailable,
      this.icon, this.width = 48 ,  this.height = 48});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).w,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width.w,
                  height: width.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: colors(context).greyColor300!)),
                  child: icon == null
                      ? Center(
                          child: Text(
                            initialName.toString().getNameInitial() ?? "",
                          style: TextStyle(color: Color(0xFF777D9E), fontSize: 24.sp),
                        ))
                      :
                  tranType == "FT" ?
                  Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8).r,
                            child: Image.asset(
                              icon ?? "",
                            ),
                          ),
                        ) :
                  CachedNetworkImage(
                    imageUrl:  icon ?? "",
                    imageBuilder: (context, imageProvider) => Padding(
                      padding: const EdgeInsets.all(4.0).w,
                      child: Container(
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>  Center(
                      child: SizedBox(height: 20.w,
                        width: 20.w,
                        child: CircularProgressIndicator(color: colors(context).primaryColor),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        accountName ?? "-",
                        style: size16weight700.copyWith(color: colors(context).blackColor),
                      ),
                      4.verticalSpace,
                      Text(
                        accountNumber ?? "-",
                        style: size14weight400.copyWith(color: colors(context).greyColor),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isAmountAvailable ?? true,
                  child: Text(
                    "- ${AppLocalizations.of(context).translate("lkr")} " + amount!,
                    style: size14weight700.copyWith(color: colors(context).negativeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
