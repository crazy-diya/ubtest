
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';


import '../../../../../utils/app_assets.dart';



class MailboxComponent extends StatefulWidget {
  final ViewMailData viewMailData;
  final VoidCallback? onLongPress;
  final VoidCallback? onPressed;
  final bool? isSelected;
  final int? messageType;

  const MailboxComponent(
    {super.key, 
    required this.viewMailData,
    this.onLongPress,
    this.onPressed,
    this.isSelected = false,
    this.messageType
  });

  @override
  MailboxComponentState createState() => MailboxComponentState();
}

class MailboxComponentState extends State<MailboxComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: widget.onPressed,
      child: Container(
        color: widget.isSelected == true
            ? colors(context).blackColor200
            : (widget.viewMailData.mailThreadTotalUnread != 0 &&  widget.messageType == 0)
                ? colors(context).secondaryColor50
                : Colors.transparent,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // widget.viewMailData.mailResponseDtoList?.first.userName !=
                  //             AppConstants.profileData.userName
                          
                  //     ? Container(
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //                 color: colors(context).greyColor300!)),
                  //         child: CircleAvatar(
                  //           backgroundColor: colors(context).secondaryColor100,
                  //           radius: 6.w,
                  //           child: Text(
                  //             widget.viewMailData.mailResponseDtoList?.first.userName
                  //                     ?.getNameInitial() ??
                  //                 "",
                  //             style: size20weight700.copyWith(
                  //                 color: colors(context).secondaryColor800),
                  //           ),
                  //         ),
                  //       ) : AppConstants.profileData.profileImage != null? Container(
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //                 color: colors(context).greyColor300!)),
                  //         child: CircleAvatar(
                  //           radius: 6.w,
                  //           backgroundImage: MemoryImage(
                  //               AppConstants.profileData.profileImage!),
                  //         ),
                  //       )
                  //     : Container(
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //                 color: colors(context).greyColor300!)),
                  //         child: CircleAvatar(
                  //           backgroundColor: colors(context).secondaryColor100,
                  //           radius: 6.w,
                  //           child: Text(
                  //             AppConstants.profileData.cName
                  //                     ?.getNameInitial() ??
                  //                 "",
                  //             style: size20weight700.copyWith(
                  //                 color: colors(context).secondaryColor800),
                  //           ),
                  //         ),
                  //       ),
                  Container(
                          decoration: BoxDecoration(
                            color: colors(context).whiteColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: colors(context).greyColor300!)),
                          child: CircleAvatar(
                            backgroundColor: colors(context).whiteColor,
                            radius: 24.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                              AppAssets.ubBank,
                                                        ),
                            ),
                          ),
                        ),
                  
                  10.horizontalSpace,
                  Expanded( 
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(children: [Text( widget.messageType == 1
                                    ? "${AppLocalizations.of(context).translate("to")}: ${widget.viewMailData.recipientCategoryName}"
                                    : widget.messageType == 2
                                        ? AppLocalizations.of(context).translate("draft")
                                        :widget.viewMailData.recipientCategoryName??"",
                                style:  size16weight700.copyWith(
                                  color: widget.viewMailData.mailThreadTotalUnread == 0 && widget.messageType==0 || widget.messageType==1? colors(context).primaryColor: widget.messageType == 2
                                            ? colors(context).negativeColor
                                            : colors(context).primaryColor,),
                              ),
                              if((widget.viewMailData.totalMessageCount??0)>1)  Padding(
                                padding:  EdgeInsets.only(left: 8.w),
                                child: Text("${widget.viewMailData.totalMessageCount.toString()}+",style: size12weight700.copyWith(color: colors(context).greyColor),
                                ),
                                
                              ),],),
                            ),
                            
                            Text(AppUtils.formattedDate3(widget.viewMailData.mailResponseDtoList?.first.createdDate),
                          style: size14weight400.copyWith(color:colors(context).greyColor)),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.viewMailData.subject??"",maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: size16weight700.copyWith(
                              color: colors(context).blackColor,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.viewMailData.mailResponseDtoList?.first.message??"",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: size12weight400.copyWith(color: colors(context).greyColor)),
                      ),
                    if(widget.viewMailData.mailResponseDtoList?.first.attachmentCount!= 0)  8.verticalSpace,
                    if(widget.viewMailData.mailResponseDtoList?.first.attachmentCount!= 0) Align(
                          alignment: Alignment.centerLeft,
                          child: IntrinsicWidth(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).primaryColor50,
                                  border: Border.all(color: colors(context).primaryColor300!)),
                              child: Padding(
                                padding: const EdgeInsets.all(4).w,
                                child: Row(children: [
                                 PhosphorIcon(
                                    PhosphorIcons.paperclip(PhosphorIconsStyle.bold),
                                    size: 20.w,
                                    color: colors(context).greyColor,
                                  ),
                                  4.horizontalSpace,
                                    Text(
                                      widget.viewMailData.mailResponseDtoList!
                                                  .first.attachmentCount! >
                                              1
                                          ? "${widget.viewMailData.mailResponseDtoList?.first.attachmentCount} ${AppLocalizations.of(context).translate("files_attached")}"
                                          : "${widget.viewMailData.mailResponseDtoList?.first.attachmentCount} ${AppLocalizations.of(context).translate("files_attached")}",
                                      style: size12weight400.copyWith(
                                          color: colors(context).greyColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),),
                    ],
                  )),
                  // Row(
                  //   // crossAxisAlignment: CrossAxisAlignment.end,
                  //   // mainAxisAlignment: MainAxisAlignment.end,
                  //   // mainAxisSize: MainAxisSize.min,
                  //   children:  [
                  //     Text(AppUtils.formattedDate3(widget.viewMailData.mailResponseDtoList?.first.createdDate),
                  //         style: size14weight400.copyWith(color:colors(context).greyColor)),
                  //   ],
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
