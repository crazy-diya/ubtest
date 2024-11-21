import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';



class AppSwitch extends StatefulWidget {
  Function(bool)? onChanged;
  final List<Widget>? switchItems;
  final String title;
  final bool value;
  final bool? addExtraPadding;


  AppSwitch({
    Key? key,
    this.onChanged,
    this.switchItems,
    required this.title,
    required this.value,
    this.addExtraPadding = true,
  }) : super(key: key);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  final CarouselSliderController _carouselController = CarouselSliderController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        color: colors(context).whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16).w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                style: size16weight700.copyWith(color: colors(context).greyColor),
                ),
                CupertinoSwitch(
                  value: widget.value,
                  onChanged: widget.onChanged,
                  activeColor: colors(context).primaryColor,
                  trackColor: colors(context).greyColor400,
                ),
              ]
            ),
            if(widget.value == true)
              Column(
                children: [
                  if(widget.addExtraPadding == true)
                    24.verticalSpace,
                  ...widget.switchItems ?? []
                ],
              )
              // ...widget.switchItems ?? []
          ],
        ),
      ),
    );
  }
}
