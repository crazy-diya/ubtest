import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';


class TransactionHistoryComponent extends StatelessWidget {
  final String title;
  final String data;
  final DateTime? subData;
  final String? isCR;
  final String? txnType;
  final String? txnDescription;
  final String? logo;
  final bool? isLastItem;

  TransactionHistoryComponent({
    this.title = '',
    this.data = '',
    this.subData,
    this.isCR = '', 
    this.txnType, this.logo, 
    this.isLastItem, this.txnDescription,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16).h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: colors(context).greyColor300!)
                    ),
                    child: txnType == "BILLPAY"
                      ? logo == null
                          ? Center(
                            child: Text( AppLocalizations.of(context).translate(getType(txnType ?? "")).getNameInitial()??"" ,
                                style: size20weight700.copyWith(
                                    color: colors(context).primaryColor),
                              ),
                          )
                          : CachedNetworkImage(
                      imageUrl: logo!,
                      imageBuilder: (context, imageProvider) => Container(
                        
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
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
                                      PhosphorIconsStyle.bold),size: 24.w,
                                ),
                    ):PhosphorIcon(
                          isCR == "CR"
                              ? PhosphorIcons.caretDoubleDown(PhosphorIconsStyle.bold)
                              : PhosphorIcons.caretDoubleUp(PhosphorIconsStyle.bold),size: 24.w,
                          color: colors(context).primaryColor,
                        )
                      // : Image.asset(
                      //     logo??"",
                      //     scale: 3,
                      //     color: colors(context).primaryColor,
                      //   ),
                  ),
                  12.horizontalSpace,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            txnDescription??"",
                            style: size14weight700.copyWith(color: colors(context).blackColor)
                          ),
                        ),
                         4.horizontalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Text("${isCR == "CR"?"+":"-"} ${AppLocalizations.of(context)
                                            .translate("lkr")} ${data.withThousandSeparator()}",
                              style:size14weight700.copyWith(color: isCR == "CR"
                                    ? colors(context).positiveColor
                                    : colors(context).negativeColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(AppLocalizations.of(context).translate(getType(txnType ?? "")),
                            style:  size12weight400.copyWith(color: colors(context).blackColor),
                          ),
                        ),
                         4.horizontalSpace,
                        Text(
                          DateFormat('dd-MMM-yyyy HH:mm').format(subData??DateTime.now()),
                          style: size12weight400.copyWith(color: colors(context).blackColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      isLastItem == true? SizedBox.shrink(): Divider(
              height: 0,
              color: colors(context).greyColor100,
              thickness: 1,
            )
      ],
    );
  }

String getType(String type) {
    switch (type) {
      case "BILLPAY":
        return "bill_payment";
      case "LQR":
        return "qr_payment";
      default:
        return "fund_transfer";
    }
  }
}
