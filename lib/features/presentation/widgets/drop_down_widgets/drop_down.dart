import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown(
      {Key? key,
        this.initialValue,
        this.labelText,
        this.label,
        this.onTap,
        this.isFirstItem = false,
        // this.isPrefixIcon = false,
        this.isDisable = false,
        this.validator,
      })
      : super(key: key);

  final String? initialValue;
  final String? labelText;
  final String? label;
  final void Function()? onTap;
  final bool isFirstItem;
  // final bool isPrefixIcon;
  final bool isDisable;
  final String? Function(String?)? validator;

  @override
  _AppDropDownState createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        builder: (formFieldState){
          return Column(
            children: [
              IgnorePointer(
                ignoring: widget.isDisable,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.label ?? "",
                      style:  size14weight700.copyWith(color:formFieldState.hasError ? colors(context).negativeColor : widget.initialValue != null ? colors(context).blackColor300:colors(context).blackColor),

                    ),
                    // widget.initialValue != null
                    //     ? Column(
                    //   children: [
                    //     if(widget.isPrefixIcon==false)
                    //
                    //       Text(widget.labelText!,
                    //       style: size14weight700.copyWith(color: colors(context).greyColor),
                    //     ),
                    //     1.44.verticalSpace,
                    //   ],
                    // ) : widget.isFirstItem ? 0.verticalSpace : 3.verticalSpace,
                    12.verticalSpace,
                    InkWell(
                      onTap: (){
                        widget.onTap?.call();
                        formFieldState.didChange(widget.initialValue);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: widget.initialValue != null
                                        ? Row(
                                      children: [
                                       
                                        Text(
                                         widget.initialValue?? "${widget.labelText!} : ${widget.initialValue}",
                                          style:
                                          // widget.isDisable ?
                                          // size16weight700.copyWith(color: colors(context).greyColor) :
                                          // widget.initialValue == null ?
                                          // size16weight700.copyWith(color: colors(context).greyColor) :
                                          size16weight700.copyWith(color: colors(context).greyColor),
          // TextStyle(
          //                                   fontSize: 4.5.sp,
          //                                   fontWeight: FontWeight.w600,
          //                                   color: widget.isDisable?colors(context).greyColor:colors(context).blackColor,
          //                                 ),
                                        ),
                                      ],
                                    )
                                        : Text(
                                      widget.labelText!,
                                      style: size16weight400.copyWith(color: colors(context).greyColor)
                                      // TextStyle(
                                      //   fontSize: 4.5.sp,
                                      //   fontWeight: FontWeight.w600,
                                      //   color: colors(context).greyColor,
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              PhosphorIcon(
                                PhosphorIcons.caretDown(
                                    PhosphorIconsStyle.bold),
                                color: colors(context).blackColor,size: 24.w,
                              ),
                            ],
                          ),
                         4.verticalSpace,
                        Container(
                          height: (widget.initialValue==null && formFieldState.hasError) ? 2.w: 1.w,
                          width: double.infinity,
                          color: formFieldState.hasError ? colors(context).negativeColor :  widget.initialValue!=null 
                            ? colors(context).blackColor300!
                            : colors(context).blackColor!,
                        ),
                        ],
                      ),
                    ),
                if(formFieldState.hasError && widget.initialValue==null)
                Padding(
                  padding: const EdgeInsets.only(top:12).h,
                  child: Text(formFieldState.errorText??"",style:size14weight400.copyWith(
                  color: colors(context).negativeColor),),
                )
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}