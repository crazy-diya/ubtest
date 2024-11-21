import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';


class TimePicker extends StatefulWidget {
  const TimePicker(
      {Key? key,
      required this.onChange,
      this.labelText,
      this.initialValue,
      this.isFirstItem = false,
      this.suffixIcon})
      : super(key: key);

  final Function onChange;
  final String? labelText;
  final String? initialValue;
  final bool isFirstItem;
  final Icon? suffixIcon;

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;
  TextStyle? labelStyle;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (selectedTime != null) {
      labelStyle = TextStyle(
        color: colors(context).greyColor200!,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
    } else {
      labelStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        // color: Appcolors(context).blackColorColor,
      );
    }

    if (widget.initialValue != null) {
      textEditingController.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
                data: ThemeData(
                  useMaterial3: false,
                  colorScheme: ColorScheme.dark(
                    primary: colors(context).secondaryColor!,
                    onPrimary: colors(context).whiteColor!,
                    surface: colors(context).secondaryColor!,
                    // onBackground: colors(context).secondaryColor!,
                    secondary: colors(context).secondaryColor!,
                    onSecondary: colors(context).secondaryColor!,
                    onSurface: colors(context).blackColor!,
                  ),
                  dialogBackgroundColor: colors(context).whiteColor,
                ),
                child: child!,
              );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        labelStyle = TextStyle(
          color: colors(context).greyColor200!,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        );
      });
      selectedTime = picked;
      final DateFormat dateFormat = DateFormat('hh:mm a');
      final String formattedTime = dateFormat.format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          selectedTime!.hour,
          selectedTime!.minute));
      widget.onChange(formattedTime);
      textEditingController.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _selectDate(context);
      },
      child: AppTextField(
        isInfoIconVisible: false,
        controller: textEditingController,
        hint: AppLocalizations.of(context).translate('pick_a_time'),
        textCapitalization: TextCapitalization.none,
        isLabel: true,
        isEnable: false,
        isReadOnly: true,
        isFirstItem: widget.isFirstItem,
        action: widget.suffixIcon,
        onTextChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
