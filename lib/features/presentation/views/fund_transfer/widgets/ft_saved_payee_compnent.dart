import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';

class FTSavedPayeeComponent extends StatelessWidget {
  final String field1;
  final String field2;
  bool? isLastItem;
  bool isEditable;
  final Function()? onTap;


  FTSavedPayeeComponent({
    required this.field1,
    required this.field2,
    this.isLastItem = false,
    this.isEditable = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w , right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 16.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                field1,
                style: size14weight700.copyWith(color: colors(context).blackColor),
              ),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        field2,
                        style: size16weight400.copyWith(color: colors(context).greyColor)
                    ),
                  ),
                  // 1.44.horizontalSpace,
                  if(isEditable)
                    InkWell(
                      onTap: () => onTap!(),
                      child: PhosphorIcon(PhosphorIcons.pencilSimpleLine(PhosphorIconsStyle.bold) ,
                        color: colors(context).blackColor,),
                    ),
                ],
              ),
            ],
          ),
          16.verticalSpace,
          isLastItem == true ?
          SizedBox.shrink() :
          Divider(
            color: colors(context).greyColor100,
            thickness: 1,
            height: 0,
          )
        ],
      ),
    );
  }
}
