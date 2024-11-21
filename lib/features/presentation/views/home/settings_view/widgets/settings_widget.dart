import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/theme/theme_data.dart';

class SettingsComponent extends StatefulWidget {
  final String title;
  final PhosphorIcon icon;
  final Function onTap;
  final bool isDisable;

  SettingsComponent({
    required this.title,
    required this.icon,
    required this.onTap, 
    this.isDisable = false,
  });

  @override
  _SettingsComponentState createState() => _SettingsComponentState();
}

class _SettingsComponentState extends State<SettingsComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16).w,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon,
            8.horizontalSpace,
            Expanded(
                child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: size16weight700.copyWith(
                      color:widget.isDisable? colors(context).greyColor?.withOpacity(.5): colors(context).greyColor,
                    ),
                  ),
                ),
              ],
            )),
            PhosphorIcon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              color: widget.isDisable? colors(context).greyColor?.withOpacity(.5): colors(context).greyColor300,
            )
          ],
        ),
      ),
    );
  }
}
