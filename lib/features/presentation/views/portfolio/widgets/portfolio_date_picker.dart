// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// 

// class PortfolioDatePicker extends StatefulWidget {
//    PortfolioDatePicker({super.key,
//      this.text = "",
//     this.firstDate,
//       this.lastDate,
//       required this.onChange,
//       this.labelText,
//       this.initialValue,
//       this.initialDate,
//       this.isFirstItem = false,
//       this.isFromDateSelected = false,
//       this.validator});

//   final Function(String) onChange;
//   final String? labelText;
//   final String? initialValue;
//   final DateTime? initialDate;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final bool isFirstItem;
//   final bool isFromDateSelected;
//   final String? Function(String?)? validator;
//   String? text;

//   @override
//   _PortfolioDatePickerState createState() => _PortfolioDatePickerState();
// }

// class _PortfolioDatePickerState extends State<PortfolioDatePicker> {
//   DateTime? selectedDate;


//   void clearDate() {
//     setState(() {
//       selectedDate = null;
//       widget.text = ''; // Clear the text field as well
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialValue != null) {
//       widget.text = widget.initialValue!;
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {}

//   @override
//   Widget build(BuildContext context) {
//     return FormField<String>(
//         validator: widget.validator,
//         builder: (formFieldState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () async {
//                   if (widget.isFromDateSelected) {
//                     final DateTime? picked = await showDatePicker(
//                       context: context,
//                       locale: const Locale('en', 'IN'),
//                       initialDate: DateTime.now(),
//                       firstDate: widget.firstDate ?? DateTime(1955),
//                       lastDate: widget.lastDate ?? DateTime(3000),
//                       initialEntryMode: DatePickerEntryMode.calendarOnly,
//                       builder: (BuildContext context, Widget? child) {
//                         return Theme(
//                           data: ThemeData(
//                             useMaterial3: false,
//                             colorScheme: ColorScheme.dark(
//                               primaryColor: colors(context).secondaryColor!,
//                               onprimaryColor: colors(context).whiteColor!,
//                               surface: colors(context).secondaryColor!,
//                               background: colors(context).secondaryColor!,
//                               // onBackground: colors(context).secondaryColor!,
//                               secondary: colors(context).secondaryColor!,
//                               onSecondary: colors(context).secondaryColor!,
//                               onSurface: colors(context).blackColor!,
//                             ),
//                             dialogBackgroundColor: colors(context).whiteColor,
//                           ),
//                           child: child!,
//                         );
//                       },
//                     );

//                     if (picked != null && picked != selectedDate) {
//                       setState(() {
//                         selectedDate = picked;
//                         final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//                         final String formattedDate =
//                             dateFormat.format(selectedDate!);
//                         formFieldState.didChange(formattedDate);
//                         widget.onChange(formattedDate);

//                         // widget.onChange(formattedDate);
//                         widget.text = formattedDate;
//                       });
//                     }
//                   }
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     widget.initialValue != null || widget.text != null
//                         ? Column(
//                             children: [
//                               Visibility(
//                                 visible: widget.text != null,
//                                 child: Text(
//                                   widget.labelText!,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: colors(context).greyColor,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12.0),
//                             ],
//                           )
//                         : SizedBox(height: widget.isFirstItem ? 0 : 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         widget.text != null
//                             ? Text(
//                                 widget.text!,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: colors(context).blackColor,
//                                 ),
//                               )
//                             : widget.initialValue != null
//                                 ? Text(
//                                     widget.initialValue!,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: colors(context).blackColor,
//                                     ),
//                                   )
//                                 : Text(
//                                     widget.labelText!,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: colors(context).greyColor,
//                                     ),
//                                   ),
//                         Icon(
//                           Icons.calendar_month_outlined,
//                           color: colors(context).blackColor!,
//                           size: 18,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6.0),
//                     Container(
//                       height: 1.0,
//                       width: double.infinity,
//                       color: colors(context).greyColor!,
//                     ),
//                   ],
//                 ),
//               ),
//               if (formFieldState.hasError)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Text(
//                     formFieldState.errorText!,
//                     style: TextStyle(
//                       fontStyle: FontStyle.normal,
//                       fontSize: 12,
//                       color: colors(context).negativeColor,
//                     ),
//                   ),
//                 )
//             ],
//           );
//         });
//   }
// }
