import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';


class FTDatePicker extends StatefulWidget {
  FTDatePicker({
     Key? key,
    this.text = '',
    this.firstDate,
    required this.onChange,
    required this.initialDate,
    this.labelText,
    this.initialValue,
    this.isFirstItem = false,
    this.isStartDateSelected = false,
    this.validator,
    this.title,
  });

  final Function(String) onChange;
  final String? labelText;
  final String? title;
  final String? initialValue;
  final DateTime? firstDate;
  final DateTime initialDate;
  final bool isFirstItem;
  final bool isStartDateSelected;
  final String? Function(String?)? validator;
  String? text;

  @override
  _FTDatePickerState createState() => _FTDatePickerState();
}

class _FTDatePickerState extends State<FTDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      widget.text = widget.initialValue!;
    }
  }

  Future<void> _selectDate(BuildContext context) async {

  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  if(widget.isStartDateSelected){
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      locale: const Locale('en', 'IN'),
                      initialDate: widget.initialDate,
                      firstDate: widget.firstDate ?? DateTime(1955),
                      lastDate: DateTime(3000),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData(
                            // textTheme: TextTheme(
                            //   headlineSmall: size14weight400, // Selected Date landscape
                            //   titleLarge: size14weight400, // Selected Date portrait
                            //   labelSmall: size12weight400,// Title - SELECT DATE
                            //   bodyLarge: size14weight400, // year gridbview picker
                            //   titleMedium: size14weight400, // input
                            //   titleSmall: size14weight400, // month/year picker
                            //   bodySmall: size14weight400, // days
                            // ),
                            // textButtonTheme: TextButtonThemeData(
                            //   style: TextButton.styleFrom(
                            //     textStyle: size14weight400,
                            //   ),
                            // ),
                            // inputDecorationTheme: InputDecorationTheme(
                            //   labelStyle: size14weight400, // Input label
                            // ),
                            fontFamily: AppConstants.kFontFamily,
                            useMaterial3: false,
                            colorScheme: ColorScheme.light(
                              primary: colors(context).primaryColor!,
                              onPrimary: colors(context).whiteColor!,
                              surface: colors(context).primaryColor!,
                              // onBackground: colors(context).secondaryColor!,
                              secondary: colors(context).primaryColor!,
                              onSecondary: colors(context).primaryColor!,
                              onSurface: colors(context).blackColor!,
                            ),
                            dialogBackgroundColor: colors(context).whiteColor,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        // selectedDate = picked;
                        final DateFormat dateFormat = DateFormat('d MMMM yyyy');
                        final String formattedDate = dateFormat.format(picked);
                        formFieldState.didChange(formattedDate);
                        widget.onChange(formattedDate);

                        widget.text =  DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(formattedDate));
                      });
                    }
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title??"",
                      style: size14weight700.copyWith(color:formFieldState.hasError ? colors(context).negativeColor : widget.text!=null? colors(context).blackColor300:colors(context).blackColor)
                    ),
                    12.verticalSpace,
                    // widget.initialValue != null || widget.text != ""
                    //     ? Column(
                    //   children: [
                    //     // widget.text == '' ?
                    //     Visibility(
                    //       visible: widget.text != null,
                    //       child: Text(
                    //         widget.labelText!,
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //           color: colors(context).greyColor,
                    //         ),
                    //       ),
                    //     ),
                    //         // :Text(""),
                    //     const SizedBox(height: 12.0),
                    //   ],
                    // )
                    //     : SizedBox(height: widget.isFirstItem ? 0 : 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.text != ""
                            ? Text(
                          widget.text ?? widget.labelText!,
                          style:widget.text ==null? size16weight400.copyWith(color: colors(context).greyColor):size16weight700.copyWith(color: colors(context).greyColor)
                        )
                            : widget.initialValue != null
                            ? Text(
                          widget.initialValue!,
                          style: size16weight700.copyWith(color: colors(context).greyColor)
                        )
                            :
                        Text(
                          widget.labelText!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors(context).greyColor,
                          ),
                        ),
                       PhosphorIcon(
                                    PhosphorIcons.calendarBlank(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).blackColor,size: 24.w,
                                  ),
                      ],
                    ),
                    4.verticalSpace,
                    Container(
                      height: (widget.initialValue==null && formFieldState.hasError) ? 2.w: 1.w,
                      width: double.infinity,
                      color: formFieldState.hasError ? colors(context).negativeColor :  widget.text!=null 
                        ? colors(context).blackColor300!
                        : colors(context).blackColor!,
                    ),
                  ],
                ),
              ),
              if(formFieldState.hasError)
                Column(
                  children: [
                    8.verticalSpace,
                    Text(formFieldState.errorText??"",style:size14weight400.copyWith(
                    color: colors(context).negativeColor),),
                  ],
                )
            ],
          );
        }
      ,
    );
  }
}
