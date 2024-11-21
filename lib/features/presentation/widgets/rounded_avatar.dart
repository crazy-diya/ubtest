import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';



class RoundedAvatarView extends StatelessWidget {
  final bool isOnline;
  final Uint8List? image;
  final String? name;
  final double size;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color forgroundColor;
  final double borderSize;

  RoundedAvatarView(
      {super.key,
      required this.isOnline,
      required this.image,
      this.size = 40,
      required this.onPressed,
      required this.name,
      required this.backgroundColor,
      required this.forgroundColor, this.borderSize = 2 });
// greyColor400
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: backgroundColor,
                width: borderSize,
              ),
            ),
            child: 
             CircleAvatar(
              radius: size,
              backgroundColor:  forgroundColor,
              backgroundImage: image!=null? MemoryImage(image!):null,
              child:image==null? Text(
                    name?.getNameInitial()??"",
                    style: size20weight700.copyWith(
                                color: colors(context).secondaryColor800),
                  ):SizedBox.shrink(),
            ) 
                ,
          ),
        //  if(isOnline) Positioned(
        //     top: 0,
        //     right: 0,
        //     child: Container(
        //       width: 20.0,
        //       height: 20.0,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: isOnline ? colors(context).positiveColor : Colors.transparent,
        //         border: Border.all(
        //           color: isOnline ? colors(context).whiteColor! : Colors.transparent,
        //           width: 4.0,
        //         ),
        //       ),
        //     ),
        //   ),
        ],
      ),
    );
  }
}
