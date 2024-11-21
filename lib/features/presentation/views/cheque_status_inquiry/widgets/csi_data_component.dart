import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';

import 'csi_summary_component.dart';

class CSIData{
  final String? chequeNumber;
  final String? accountNumber;
  final String? collectionDate;
  final String? amount;

  CSIData(
      {this.chequeNumber,
      this.accountNumber,
      this.collectionDate,
      this.amount});
}



class CSIDataComponent extends StatefulWidget {
final CSIData? csiData;


CSIDataComponent({this.csiData});

  @override
  _CSIDataComponentState createState() => _CSIDataComponentState();
}

class _CSIDataComponentState extends State<CSIDataComponent> {
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
                  data: widget.csiData?.chequeNumber ?? "-",
                  isTitle: true,
                  isFromCSI: true,
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
                  title: AppLocalizations.of(context).translate("Account_Number"),
                  data: widget.csiData?.accountNumber ?? "-",
                ),
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("collection_date"),
                  data: widget.csiData?.collectionDate ?? "-",
                ),
                CSISummeryDataComponent(
                  title: AppLocalizations.of(context).translate("amount"),
                  isCurrency: true,
                  amount: double.parse(widget.csiData!.amount!),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h,)
      ],
    );
  }
}
