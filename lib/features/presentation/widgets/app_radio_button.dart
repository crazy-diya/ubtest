import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/theme/theme_data.dart';
import 'info_icon_view.dart';

class RadioButtonModel {
  final String label;
  final String value;

  RadioButtonModel({required this.label, required this.value});
}

class CustomRadioButtonGroup extends StatefulWidget {
  final List<RadioButtonModel> options;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? title;
  final void Function()? onTapInfo;
  final bool isInfoIcon;
  final List<String>? infoIconText;
  final String? Function(String?)? validator;
  final bool? isDivider;
  final bool? haveMorePadding;
  SuperTooltipController? superToolTipController;

  CustomRadioButtonGroup({
    Key? key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.onTapInfo,
    this.infoIconText,
    this.validator,
    this.isInfoIcon = false,
    this.title,
    this.superToolTipController,
    this.isDivider = false,
    this.haveMorePadding = false,
  }) : super(key: key);

  @override
  _CustomRadioButtonGroupState createState() => _CustomRadioButtonGroupState();
}

class _CustomRadioButtonGroupState extends State<CustomRadioButtonGroup> {
  late String? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomRadioButtonGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    _groupValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(widget.title!,
                          style: formFieldState.hasError ? size14weight700.copyWith(
                            color: colors(context).negativeColor,
                          ) : size14weight700.copyWith(
                            color: colors(context).blackColor,
                          )),
                    ),
                    widget.isInfoIcon
                        ?
                    Row(
                      children: [
                        5.horizontalSpace,
                        CommonToolTips(
                          isTextFieldEmpty :(formFieldState.value != null)? false:true,
                          controller: widget.superToolTipController,
                          // hasFocus: _hasFocus,
                          // rightPadding: widget.toolTipRightPadding,
                          title: "",
                          content:  widget.infoIconText ?? [],
                          successfullyValidated:
                          formFieldState.hasError &&
                              (formFieldState.value != null || formFieldState.value != "")
                              ? true
                              : false,
                        ),
                      ],
                    )
                    // Row(
                    //         children: [
                    //           5.horizontalSpace,
                    //           PhosphorIcon(PhosphorIcons.info(PhosphorIconsStyle.bold), size: 16, color: colors(context).blackColor300,),
                    //         ],
                    //       )
                        : const SizedBox.shrink(),
                  ],
                ),
                widget.haveMorePadding == true
                    ? 15.verticalSpace
                    : 12.verticalSpace,
              ],
              ListView.builder(
                  itemCount: widget.options.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        widget.haveMorePadding == true
                            ? 1.90.verticalSpace
                            : 0.8.verticalSpace,
                        CustomRadioButton<String>(
                          value: widget.options[index].value,
                          groupValue: _groupValue,
                          label: widget.options[index].label,
                          labelColor: _groupValue == widget.options[index].value
                              ? colors(context).blackColor!
                              : colors(context).blackColor!,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                            widget.onChanged?.call(value);
                            formFieldState.didChange(value);
                          },
                        ),
                        if(index < widget.options.length - 1)
                          16.verticalSpace,
                        if (index < widget.options.length - 1 &&
                            widget.isDivider == true)
                          Divider(
                            thickness: 1,
                            height: 0,
                            color: colors(context).greyColor100,
                          )
                      ],
                    );
                  }),
              if (formFieldState.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 6).h,
                  child: Text(
                    formFieldState.errorText ?? "",
                    style: size14weight400.copyWith(
                      color: colors(context).negativeColor,
                    ),
                  ),
                )
            ],
          );
        });
  }
}

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?>? onChanged;
  final Color labelColor;

  CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(value);
      },
      child: Row(
        children: [
          5.horizontalSpace,
          UBRadio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          10.horizontalSpace,
          Text(
            label,
            style: size16weight400.copyWith(
              color: colors(context).blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
