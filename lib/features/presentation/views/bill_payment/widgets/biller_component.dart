import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/saved_biller_entity.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../core/theme/text_styles.dart';



class BillerComponent extends StatefulWidget {
  SavedBillerEntity? savedBillerEntity;
  final VoidCallback? onLongPress;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final bool? isSelected;
  final Function(int isFav)? onFavorite;

  BillerComponent({
    this.savedBillerEntity,
    required this.onLongPress,
    this.onPressed,
    this.isSelected,
    this.onFavorite,
    this.onTap,
  });

  @override
  State<BillerComponent> createState() => _BillerComponentState();
}

class _BillerComponentState extends State<BillerComponent> {
  // bool _isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16).w,
        child: Row(
          children: [
            Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: colors(context).greyColor300!)
                    ),
                    child:  widget.savedBillerEntity?.serviceProvider?.billerImage == null
                          ? Center(
                            child: Text(widget.savedBillerEntity?.serviceProvider?.billerName?.toString().getNameInitial()??"" ,
                                style: size20weight700.copyWith(
                                    color: colors(context).primaryColor),
                              ),
                          )
                          : CachedNetworkImage(
                      imageUrl:  widget.savedBillerEntity!.serviceProvider!.billerImage!,
                      imageBuilder: (context, imageProvider) => Container(
                        
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,),
                        ),
                      ),
                      placeholder: (context, url) =>  Center(
                        child: SizedBox(height: 20.w,
                          width: 20.w,
                          child: CircularProgressIndicator(color: colors(context).primaryColor),
                        ),
                      ),
                      errorWidget: (context, url, error) => PhosphorIcon(
                                  PhosphorIcons.warningCircle(
                                      PhosphorIconsStyle.bold),
                                ),
                    )
                  ),
                  12.horizontalSpace,
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.savedBillerEntity!.nickName ?? "-",
                        style: size16weight700.copyWith(
                            color: colors(context).blackColor),
                      ),
                      4.verticalSpace,
                      Text(widget.savedBillerEntity!.value ?? "-",
                          style: size14weight400.copyWith(
                              color: colors(context).blackColor))
                    ],
                  ),
                  const Spacer(),
                  InkWell(
              onTap: () =>
                widget.onFavorite!(widget.savedBillerEntity!.id!),
              child: PhosphorIcon(PhosphorIcons.star(PhosphorIconsStyle.bold) ,
                color:  widget.savedBillerEntity!.isFavorite == true ? colors(context).secondaryColor : colors(context).greyColor300,),
            ),
            12.horizontalSpace,
            PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
              color: colors(context).greyColor300,)
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../../utils/app_images.dart';
// 
// import '../../../../domain/entities/response/saved_biller_entity.dart';
//
// class BillerComponent extends StatelessWidget {
//   final SavedBillerEntity? savedBillerEntity;
//   final VoidCallback? onTap;
//   final VoidCallback? onLongTap;
//   final Function onDeleteItem;
//   final bool isDeleteAvailable;
//
//   BillerComponent({
//     this.savedBillerEntity,
//     required this.onDeleteItem,
//     required this.isDeleteAvailable,
//     this.onTap,
//     this.onLongTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       onLongPress: onLongTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: isDeleteAvailable && savedBillerEntity!.isSelected
//               ? colors(context).primaryColor!.withOpacity(0.12)
//               : colors(context).whiteColor,
//           border: Border.all(
//             width: isDeleteAvailable && savedBillerEntity!.isSelected ? 2 : 0.5,
//             color: isDeleteAvailable && savedBillerEntity!.isSelected
//                 ? Color(0xFF324294)
//                 : Color(0xFF5D5D5D),
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(6)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     if (isDeleteAvailable)
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               // Toggle selection
//                               onDeleteItem(savedBillerEntity!);
//                             },
//                             child: savedBillerEntity!.isSelected
//                                 ? SvgPicture.asset(AppImages.icCircleChecked)
//                                 : SizedBox.shrink(),
//                           ),
//                           const SizedBox(width: 8),
//                         ],
//                       )
//                     else
//                       const SizedBox.shrink(),
//                     Image.network(
//                       savedBillerEntity!.serviceProvider!.billerImage ?? '',
//                       width: 30,
//                       height: 30,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           savedBillerEntity!.nickName ?? "xxxx",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           savedBillerEntity!.customFieldEntityList!.isNotEmpty
//                               ? savedBillerEntity!.customFieldEntityList![0].customFieldValue!
//                               : savedBillerEntity!.mobileNumber ?? "",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w300,
//                             fontSize: 12,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               savedBillerEntity!.isFavorite == true
//                   ? const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Icon(
//                   Icons.favorite,
//                   color: Color(0xFFFF9F46),
//                 ),
//               )
//                   : const SizedBox.shrink(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
