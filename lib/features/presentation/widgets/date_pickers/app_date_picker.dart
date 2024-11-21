



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../utils/app_constants.dart';


class AppDatePicker extends StatefulWidget {
   AppDatePicker({
    this.firstDate,
    required this.onChange,
    required this.initialDate,
    this.labelText,
    this.initialValue,
    this.isFirstItem = false,
    this.isFromDateSelected = false,
    this.validator, 
    this.lastDate, 
    this.dateFormat, 
  });

  final Function(String) onChange;
  final String? labelText;
  final ValueNotifier<String?>? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime initialDate;
  final bool isFirstItem;
  final bool isFromDateSelected;
  final String? Function(String?)? validator;
  final DateFormat? dateFormat;

  @override
  _AppDatePickerState createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {



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
                  if(widget.isFromDateSelected){
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      locale: const Locale('en', 'IN'),
                       initialDate: widget.initialDate,
                      firstDate: widget.firstDate ?? DateTime(1955),
                      lastDate: widget.lastDate ?? DateTime(3000),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData(
                            fontFamily: AppConstants.kFontFamily,
                            useMaterial3: false,
                            colorScheme: ColorScheme.light(
                              primary: colors(context).primaryColor!,
                              onPrimary: colors(context).whiteColor!,
                              surface: colors(context).primaryColor!,
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
                    if (picked != null) {
                      setState(() {
                        final DateFormat dateFormat = widget.dateFormat ?? DateFormat('yyyy-MM-dd');
                        final String formattedDate = dateFormat.format(picked);
                        formFieldState.didChange(formattedDate);
                        widget.onChange(formattedDate);

                        widget.initialValue?.value = DateFormat('dd-MMM-yyyy').format( DateTime.parse(formattedDate));
                      });
                    }
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText!,
                      style:size14weight700.copyWith(color:formFieldState.hasError ? colors(context).negativeColor : widget.initialValue?.value!=null? colors(context).blackColor300:colors(context).blackColor) ,
                    ),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.initialValue?.value == null
                            ? Text(
                          AppLocalizations.of(context).translate("select_date"),
                          style: size16weight400.copyWith(
                            color:widget.initialValue?.value == null ? colors(context).greyColor : colors(context).blackColor,
                          ),
                        ):
                        Text(
                          widget.initialValue?.value??"",
                          style: size16weight700.copyWith(color: colors(context).blackColor,
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
                      color: formFieldState.hasError ? colors(context).negativeColor :  widget.initialValue?.value!=null 
                        ? colors(context).blackColor300!
                        : colors(context).blackColor!,
                    ),
                  ],
                )
              ),
              if(formFieldState.hasError)
                Padding(
                    padding: const EdgeInsets.only(top:12).h,
                  child: Text(formFieldState.errorText!,style: size14weight400.copyWith(
                    color: colors(context).negativeColor,

                  ),),
                )
            ],
          );
        }
      ,
    );
    
  }
}