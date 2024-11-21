import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../utils/app_sizer.dart';



class BottomSheetBuilder extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final List<Widget>? buttons;
  final bool? isSearch;
  final void Function(String)? onSearch;
  final bool isAttachmentSheet;
  final bool isTwoButton;
  const BottomSheetBuilder({
    Key? key,
    required this.title,
    required this.children,
    this.buttons, 
    this.isSearch = false, 
    this.onSearch,
    this.isAttachmentSheet = false,
    this.isTwoButton = false,
  }) : super(key: key);

  @override
  State<BottomSheetBuilder> createState() => _BottomSheetBuilderState();
}

class _BottomSheetBuilderState extends State<BottomSheetBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Container(
        decoration: BoxDecoration(
          color:  colors(context).whiteColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                    // 20.w, 0, 20.w,widget.isAttachmentSheet ? 49.h : widget.isTwoButton ? 48.h : 28.h),
                      20, 20, 20,28+ AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).greyColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: PhosphorIcon(
                              PhosphorIcons.xCircle(PhosphorIconsStyle.bold),
                              color: colors(context).greyColor300,size: 24,
                            )),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 widget.title==''|| widget.title.isEmpty?SizedBox.shrink():20.verticalSpace,
                  widget.title==''|| widget.title.isEmpty?SizedBox.shrink(): Text(
                  widget.title,
                  style:size20weight700.copyWith(
                    color: colors(context).primaryColor,),
                ),
               if (widget.isSearch == true) 12.verticalSpace,
                if (widget.isSearch == true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SearchTextField(
                        hintText: AppLocalizations.of(context).translate("search"),
                        onChange: widget.onSearch ?? (value) { },
                      ),
                    ),
                   if (widget.isSearch == false && !widget.isAttachmentSheet)  20.verticalSpace,
                   if(widget.isAttachmentSheet) 32.verticalSpace
                  
                ],
                ),
        
                Flexible(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...widget.children,
                        ],
                      ),
                    ),
                ),
                // widget.buttons!=null?  3.64.verticalSpace:3.64.verticalSpace,
               20.verticalSpace,
                
                
                Row(children: widget.buttons ?? [],),
              ]
            ),
          )),
        ),
      ),
    );
  }
}
