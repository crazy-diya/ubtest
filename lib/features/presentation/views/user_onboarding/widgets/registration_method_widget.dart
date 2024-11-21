import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';



class RegistrationMethodWidget extends StatelessWidget {
  final String title;
  final Function() onTap;

  const RegistrationMethodWidget({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          border: Border.all(
            color: colors(context).primaryColor!,
            width: 1.0,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: colors(context).blackColor,
          ),
        ),
      ),
    );
  }
}
