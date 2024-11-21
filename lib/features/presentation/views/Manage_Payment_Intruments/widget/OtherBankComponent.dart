import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../domain/entities/response/get_juspay_instrument_entity.dart';

class OtherBankComponent extends StatelessWidget {
  final UserInstrumentsListEntity? manageOtherBankAccountEntity;
  final VoidCallback? onTap;
  final String? icon;
  final bool? isArrow;

  OtherBankComponent({
    this.manageOtherBankAccountEntity,
    this.onTap,
    this.icon,
    this.isArrow
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: colors(context).greyColor300!),
                ),
                child:
                icon != null ?
                Center(
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(8).r,
                    child: Image.asset(
                      icon ?? "",
                    ),
                  ) ,
                )
                    :
                Center(
                    child: Text(
                  manageOtherBankAccountEntity?.bankName.toString().getNameInitial() ??"",
                  style: TextStyle(color: Color(0xFF777D9E),fontSize: 20.sp ,fontWeight: FontWeight.w700 ),
                )),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      manageOtherBankAccountEntity?.bankName ?? "-",
                      style: size16weight700.copyWith(color: colors(context).blackColor),
                    ),
                    1.verticalSpace,
                    Text(
                      manageOtherBankAccountEntity?.accountNo ?? "-",
                      style: size14weight400.copyWith(color: colors(context).greyColor),
                    ),
                  ],
                ),
              ),
            isArrow == true ?
              PhosphorIcon(PhosphorIcons.caretRight() , color: colors(context).greyColor300,size: 24.w,): SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
