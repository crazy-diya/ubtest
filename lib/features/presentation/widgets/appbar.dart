import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class UBAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? goBackEnabled;
  final IconData? backPressedIcon;
  final VoidCallback? onBackPressed;
  final bool? isTransparent;

  const UBAppBar({super.key, 
    this.title = '',
    this.actions,
    this.goBackEnabled = true,
    this.onBackPressed, 
    this.backPressedIcon = Icons.arrow_back,
    this.isTransparent = false
  })  : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom:  isTransparent!? PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox.shrink(),
      ): PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          height: 4.h,
          width: double.infinity,
          color: colors(context).secondaryColor,
        ),
      ),
      title: Text(
        title,
        
        style:size18weight700.copyWith(color: colors(context).whiteColor,),
      ),
      backgroundColor: isTransparent!?Colors.transparent:colors(context).primaryColor,
      elevation: 0,
      actions:List.generate(actions?.length??0, (index) =>Padding(padding: EdgeInsets.only(right: 8).w,child: actions?[index]??SizedBox.shrink(),) ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: goBackEnabled!
          ? InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  Navigator.pop(context);
                }
              },
              child:PhosphorIcon(PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),size: 24.w, ))
          : null,
    );
  }
}
