import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';

// ignore: must_be_immutable
class InstrumentsDetailsField extends StatelessWidget {
  final String field1;
  final String field2;
  bool? isEditable;
  bool? isEnableDivider;
  final Function()? onTap;

  InstrumentsDetailsField({
    required this.field1,
    required this.field2,
    this.isEditable = false,
    this.isEnableDivider = true,
    this.onTap,
  });
  // String formatSubData(String field2) {
  //   if (field2.isEmpty) {
  //     return '';
  //   }

  //   bool isNumeric = field2.codeUnits.every((unit) => unit >= 48 && unit <= 57);

  //   if (!isNumeric) {
  //     return field2;
  //   }

  //   List<String> chunks = [];
  //   for (int i = 0; i < field2.length; i += 4) {
  //     int end = (i + 4 < field2.length) ? i + 4 : field2.length;
  //     chunks.add(field2.substring(i, end));
  //   }

  //   return chunks.join(' ');
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          1.90.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field1,
                style:
                    size14weight700.copyWith(color: colors(context).blackColor),
              ),
              1.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(field2,
                      textAlign: TextAlign.right,
                      style: size16weight400.copyWith(
                          color: colors(context).greyColor)),
                  if (isEditable!)
                    InkWell(
                      onTap: () => onTap!(),
                      child: PhosphorIcon(
                        PhosphorIcons.pencilSimpleLine(PhosphorIconsStyle.bold),
                        color: colors(context).blackColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          0.96.verticalSpace,
          isEnableDivider!
              ? Divider(
                  color: colors(context).greyColor100,
                )
              : 1.90.verticalSpace
        ],
      ),
    );
  }
}
