import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../../../../../utils/app_localizations.dart';

class HomeStatistic extends StatefulWidget {
  @override
  State<HomeStatistic> createState() => _HomeStatisticState();
}

class _HomeStatisticState extends State<HomeStatistic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, right: 25, left: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).translate("statistics"),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colors(context).blackColor,
                  )),
              Text(AppLocalizations.of(context).translate("view_more"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors(context).secondaryColor,
                  )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: colors(context).whiteColor,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            height: 211,
            width: 342,
          )
        ],
      ),
    );
  }
}
