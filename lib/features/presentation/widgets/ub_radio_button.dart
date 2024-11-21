import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class UBRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  const UBRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _UBRadioState<T> createState() => _UBRadioState<T>();
}

class _UBRadioState<T> extends State<UBRadio<T>> {
  bool get selected => (widget.value == widget.groupValue);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(widget.value);
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colors(context).greyColor300!,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Container(
            height: 12.w,
            width: 12.w,
            decoration: BoxDecoration(
              color: selected ? colors(context).primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
