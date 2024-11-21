import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../domain/entities/response/saved_payee_entity.dart';

class SavedPayeeComponent extends StatelessWidget {
  final SavedPayeeEntity? savedPayeeEntity;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final Function onDeleteItem;
  final Function(bool isFav)? onFavorite;
  final bool isDeleteAvailable;
  final bool? isLastItem;

  SavedPayeeComponent(
      {this.savedPayeeEntity,
      this.onTap,
      this.onLongTap,
      this.onFavorite,
      required this.onDeleteItem,
      required this.isDeleteAvailable,
      this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16).w,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (isDeleteAvailable)
                    Padding(
                      padding: const EdgeInsets.only(right: 12).w,
                      child: SizedBox(
                        width: 36.w,
                        height: 36.w,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1).w),
                          checkColor: colors(context).whiteColor,
                          activeColor: colors(context).primaryColor,
                          value: savedPayeeEntity?.isSelected,
                          onChanged: (value) {
                            onTap?.call();
                          },
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        border:
                            Border.all(color: colors(context).greyColor300!)),
                    child: (savedPayeeEntity?.payeeImageUrl == null)
                        ? Center(
                            child: Text(
                              savedPayeeEntity?.nickName
                                      ?.toString()
                                      .getNameInitial() ??
                                  "",
                              style: size20weight700.copyWith(
                                  color: colors(context).primaryColor),
                            ),
                          )
                        : Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8).r,
                              child: Image.asset(
                                savedPayeeEntity?.payeeImageUrl ?? "",
                              ),
                            ),
                          ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(savedPayeeEntity!.nickName ?? "-",
                            style: size16weight700.copyWith(
                                color: colors(context).blackColor)),
                        4.verticalSpace,
                        Text(
                                savedPayeeEntity?.accountNumber ?? "-",
                            // savedPayeeEntity!.accountNumber ?? "-",
                            style: size14weight400.copyWith(
                                color: colors(context).blackColor)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            12.horizontalSpace,
            if (!isDeleteAvailable)
              InkWell(
                  onTap: () => onFavorite!(savedPayeeEntity!.isFavorite),
                  child: savedPayeeEntity!.isFavorite
                      ? PhosphorIcon(
                          PhosphorIcons.star(PhosphorIconsStyle.bold),
                          color: colors(context).secondaryColor,
                        )
                      : PhosphorIcon(
                          PhosphorIcons.star(PhosphorIconsStyle.bold),
                          color: colors(context).greyColor300,
                        )),
            if (!isDeleteAvailable) 12.horizontalSpace,
            if (!isDeleteAvailable)
              InkWell(
                child: PhosphorIcon(
                  PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                  color: colors(context).greyColor400,
                ),
              ),
          ],
        ),
      ),
    );
  }

//   String formatSubData(String accountNumber) {
//     if (accountNumber.isEmpty) {
//       return '';
//     }

//     bool isNumeric =
//         accountNumber.codeUnits.every((unit) => unit >= 48 && unit <= 57);

//     if (!isNumeric) {
//       return accountNumber;
//     }

//     List<String> chunks = [];
//     for (int i = 0; i < accountNumber.length; i += 4) {
//       int end = (i + 4 < accountNumber.length) ? i + 4 : accountNumber.length;
//       chunks.add(accountNumber.substring(i, end));
//     }

//     return chunks.join(' ');
//   }
}
