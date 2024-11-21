import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class DropDownListItem extends StatelessWidget {
  const DropDownListItem({required this.title, required this.onTap});

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 45,
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colors(context).blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
