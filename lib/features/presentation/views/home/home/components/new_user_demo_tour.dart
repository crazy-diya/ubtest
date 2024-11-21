
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';


class NewUserDemoTour extends StatefulWidget {


  const NewUserDemoTour({
    super.key,
  });

  @override
  State<NewUserDemoTour> createState() => _NewUserDemoTourState();
}



class _NewUserDemoTourState extends State<NewUserDemoTour> {
  final localDataSource = injection<LocalDataSource>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors(context).secondaryColor50,
         borderRadius: BorderRadius.circular(8).r
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.w,top: 11.92.h,),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () async {
                     await localDataSource.setNewUserDemoTour(false);
                    },
                    child: PhosphorIcon(
                      PhosphorIcons.xCircle(PhosphorIconsStyle.bold),size: 24.w,
                      color: colors(context).secondaryColor800,
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding:  EdgeInsets.only(top: 20.h),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: colors(context)
                                  .secondaryColor,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(11).w,
                            child: PhosphorIcon(
                              PhosphorIcons.confetti(
                                  PhosphorIconsStyle.bold),size: 22.w,
                              color:
                                  colors(context).whiteColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
         
          Padding(
            padding: EdgeInsets.only(left: 16.w,right: 16,top: 18,bottom: 26),
            child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate(
                            'new_user_demo_tour_title'),
                            textAlign: TextAlign.center,
                    style: size18weight700.copyWith(
                        color:
                            colors(context).blackColor),
                  ),
                  12.verticalSpace,
                  Text(
                    AppLocalizations.of(context)
                        .translate(
                            'new_user_demo_tour_description'),
                            textAlign: TextAlign.center,
                    style: size14weight400.copyWith(
                        color:
                            colors(context).greyColor),
                  ),
                  18.verticalSpace,
                 AppButton(
                  buttonHeight: 44,
                    // buttonType:(_subjectController.text.isEmpty || _messageController.text.isEmpty || initialRecipient.isEmpty)? ButtonType.DISABLED: ButtonType.ENABLED,
                    buttonType: ButtonType.PRIMARYENABLED,
                    buttonText: AppLocalizations.of(context).translate("demo_tour"),
                    onTapButton: () {
                      Navigator.pushNamed(context, Routes.kDemoTourView);
                    
                    },
                  )
                ],
              ),
          ),
        ],
      ),
    ) ;
  }
}


