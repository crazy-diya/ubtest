import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/widgets/request_call_data_component.dart';
import '../../../../../utils/app_localizations.dart';

import '../data/request_status.dart';

class RCData {
  final String? prefTimeSlot;
  final String? reqDate;
  final String? status;

  RCData({
    this.prefTimeSlot,
    this.reqDate,
    this.status,
  });
}

class RequestCallComponent extends StatefulWidget {
  final RCData? rcData;

  RequestCallComponent({this.rcData});

  @override
  _RequestCallComponentState createState() => _RequestCallComponentState();
}

class _RequestCallComponentState extends State<RequestCallComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: colors(context).greyColor300,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
            child: Column(
              children: [
                RequestCallDataComponent(
                  title: AppLocalizations.of(context).translate("card_center"),
                  isTitle: true,
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: colors(context).greyColor200,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
            child: Column(
              children: [
                RequestCallDataComponent(
                  title: AppLocalizations.of(context)
                      .translate("prefer_time_slot"),
                  data: widget.rcData?.prefTimeSlot ?? "-",
                ),
                RequestCallDataComponent(
                  title: AppLocalizations.of(context).translate("request_date"),
                  data: widget.rcData?.reqDate ?? "-",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("status"),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: colors(context).blackColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: colors(context).greyColor200!),
                            color: getStatus(widget.rcData!.status!,context).color!),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            getStatus(widget.rcData!.status!,context).status!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colors(context).whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }


}
