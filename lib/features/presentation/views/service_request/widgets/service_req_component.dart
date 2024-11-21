import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';

import '../../float_inquiry/data/fi_status.dart';
import '../../float_inquiry/widgets/fi_data_component.dart';

class ServiceReqComponent extends StatefulWidget {
  final FIData? fiData;


  ServiceReqComponent({this.fiData});

  @override
  _ServiceReqComponentState createState() => _ServiceReqComponentState();
}

class _ServiceReqComponentState extends State<ServiceReqComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  border: Border.all(color: colors(context).greyColor300!)),
              child: widget.fiData?.icon,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fiData?.chequeNumber ?? "-" ,
                    style: size16weight700.copyWith(color: colors(context).blackColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.fiData?.dateRecieved ?? "-",
                        style: size12weight400.copyWith(color: colors(context).blackColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        width: 72,
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color:colors(context).greyColor200!),
                            color: getStatus(widget.fiData!.status!.toUpperCase()).color!
                        ),
                        child: Center(
                          child: Text(
                            getStatus(widget.fiData!.status!.toUpperCase()).status!,
                            style: size12weight700.copyWith(color: colors(context).whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        16.verticalSpace,
      ],
    );
    //   Column(
    //   children: [
    //     Container(
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         borderRadius: const BorderRadius.only(topLeft: Radius.circular(12) , topRight: Radius.circular(12)),
    //         color: colors(context).greyColor300,
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 25.0 , right: 25 , top: 25),
    //         child: Column(
    //           children: [
    //             CSISummeryDataComponent(
    //               title: AppLocalizations.of(context).translate("Account_Number"),
    //               data: widget.fiData?.chequeNumber ?? "-",
    //               isTitle: true,
    //               isFromCSI: false,
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12) , bottomRight: Radius.circular(12)),
    //         color: colors(context).greyColor200,
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 25.0 , right: 25 , top: 25),
    //         child: Column(
    //           children: [
    //             CSISummeryDataComponent(
    //               title: AppLocalizations.of(context).translate("date_received"),
    //               data: widget.fiData?.dateRecieved ?? "-",
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 20.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     AppLocalizations.of(context)
    //                         .translate(
    //                         "status"),
    //                     style: size18weight400.copyWith(color: colors(context).blackColor),
    //                   ),
    //                   Container(
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(5),
    //                         border: Border.all(color:colors(context).greyColor200!),
    //                         color: getStatus(widget.fiData!.status!.toUpperCase()).color!
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(4.0),
    //                       child: Text(
    //                         getStatus(widget.fiData!.status!.toUpperCase()).status!,
    //                         style: size16weight400.copyWith(color: colors(context).whiteColor),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     16.verticalSpace
    //   ],
    // );
  }

  FIStatus getStatus(String status){
    switch(status) {
      case "PENDING": {
        return FIStatus(status: AppLocalizations.of(context).translate("pending"),color: colors(context).greyColor);
      }

      case "INPROGRESS": {
        return FIStatus(status: AppLocalizations.of(context).translate("in_progress"),color: colors(context).primaryColor);
      }

      case "CLEARED": {
        return FIStatus(status: AppLocalizations.of(context).translate("cleared"),color: colors(context).positiveColor);
      }



      default: {
        return FIStatus(status: AppLocalizations.of(context).translate("unrealized"),color: colors(context).negativeColor);
      }
    }

  }
}
