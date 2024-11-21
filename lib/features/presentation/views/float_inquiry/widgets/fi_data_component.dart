import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';

import '../../cheque_status_inquiry/widgets/csi_summary_component.dart';
import '../data/fi_status.dart';

class FIData{
  final String? status;
  final String? type;
  final String? dateRecieved;
  final String? amount;
  final String? chequeNumber;
  final String? collectionMethod;
  final String? branch;
  final String? noOfLeaves;
  final String? serviceCharge;
  final String? deliveryCharge;
  final String? address;
  final PhosphorIcon? icon;
  final DateTime? fromDate;
  final DateTime? toDate;

  FIData(
      {this.status,
      this.type,
      this.dateRecieved,
      this.amount,
      this.chequeNumber,
      this.collectionMethod,
      this.branch,
      this.noOfLeaves,
      this.serviceCharge,
      this.deliveryCharge,
      this.fromDate,
      this.address,
      this.icon,
      this.toDate});
}



class FIDataComponent extends StatefulWidget {
  final FIData? fiData;


  FIDataComponent({this.fiData});

  @override
  _FIDataComponentState createState() => _FIDataComponentState();
}

class _FIDataComponentState extends State<FIDataComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12) , topRight: Radius.circular(12)),
            color: colors(context).greyColor300,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0 , right: 25 , top: 25),
            child: Column(
              children: [
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("cheque_number"),
                  data: widget.fiData?.chequeNumber ?? "-",
                  isTitle: true,
                  isFromCSI: false,
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12) , bottomRight: Radius.circular(12)),
            color: colors(context).greyColor200,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0 , right: 25 , top: 25),
            child: Column(
              children: [
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("date_received"),
                  data: widget.fiData?.dateRecieved ?? "-",
                ),
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("amount"),
                  isCurrency: true,
                  amount: double.parse(widget.fiData!.amount!),
                ),
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("type"),
                  data: widget.fiData?.type ?? "-",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate(
                            "status"),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: colors(context).blackColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color:colors(context).greyColor200!),
                            color: getStatus(widget.fiData!.status!.toUpperCase()).color!
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.fiData?.status ??"-",
                            // getStatus(widget.fiData!.status!.toUpperCase()).status!,
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
        SizedBox(height: 3.h,)
      ],
    );
  }

  FIStatus getStatus(String status){
    switch(status) {
      case "PENDING": {
        return FIStatus(status: AppLocalizations.of(context).translate("pending"),color: colors(context).greyColor);
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
