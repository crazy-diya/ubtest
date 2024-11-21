

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';



class ServiceCarouselContainer extends StatelessWidget {
  final String? nickName;
  final String? bankCode;
  final String? acctNmbr;
  final bool? carouselValue;


  ServiceCarouselContainer({this.nickName , this.carouselValue , this.bankCode , this.acctNmbr});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 73,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(color: carouselValue == true ? colors(context).greyColor200 ?? colors(context).blackColor! : Colors.transparent),
          color: colors(context)
              .blackColor200,
        ),
        child: Padding(
          padding:
          const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(bankCode == "7302")
                // Image.asset(
                //   AppAssets.icUB,
                //   scale: 3,
                // ),
              if(bankCode == "7302")
                SizedBox(width: 4.w,),
              Expanded(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .start,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    SizedBox(
                      width: ScreenUtil().screenWidth/1.5,
                      child: Text(
                        nickName ?? "-",
                        //AppConstants.accountDetailsResponseDtos[index].productName!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .w700,overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                        height: 6),
                    Text(
                      acctNmbr ?? "-",
                      // AppConstants.accountDetailsResponseDtos[index].accountNumber!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w400),
                    )
                  ],
                ),
              ),
              //const Spacer(),
              // Column(children: [
              //   AppConstants.accountDetailsResponseDtos[index].status!
              //       ? Container(
              //       height: 21,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         borderRadius:
              //         BorderRadius.circular(4),
              //         color: colors(context).blackColor,
              //       ),
              //       child: const Center(
              //           child: Text(
              //             "primary",
              //             style: TextStyle(
              //                 fontSize: 10,
              //                 fontWeight: FontWeight.w400,
              //                 color: colors(context).whiteColor),
              //           )))
              //       : const SizedBox(),
              // ]),
            ],
          ),
        ));
  }
}



