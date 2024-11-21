
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';


import '../../../../core/service/platform_services.dart';
import '../../../../utils/enums.dart';
import '../../widgets/app_button.dart';

class SecurityFailureView extends StatefulWidget {
  final SecurityFailureType securityFailureType;

  const SecurityFailureView({super.key, required this.securityFailureType});

  @override
  State<SecurityFailureView> createState() => _SecurityFailureViewState();
}

class _SecurityFailureViewState extends State<SecurityFailureView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(color: colors(context).primaryColor50),
        child: Padding(
           padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
          child: Stack(
            children: [
              Center(
                child: Text(
                  decodeMessageBase64(getSecurityFailureMessage(),3),
                  style:size24weight700,
                  textAlign: TextAlign.center,
                ),
              ),
              widget.securityFailureType == SecurityFailureType.ADB
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: AppButton(
                        onTapButton: () {
                          PlatformServices.disableADB();
                        },
                        buttonText: decodeMessageBase64("VWtkc2VsbFhTbk5hVTBKV1ZUQkpaMUpIVm1sa1YyUnVZVmMxYmc9PQ==",3),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      )),
    );
    
  }

  String getSecurityFailureMessage() {
     switch (widget.securityFailureType) {
      case SecurityFailureType.ADB:
        return "VlVkNGJGbFlUbXhKUlZKd1l6SkdhV0pIVldkV1ZrNURTVVZTYkZsdVZtNWFNbXgxV25sQ2FHSnRVV2RWYlZaNlpFZEdlV1JEUWpCaFIxVm5VVmhDZDJKSGJHcFpXRkp3WWpJMFBRPT0=";
      case SecurityFailureType.ROOT:
        return "VWtkV01tRlhUbXhKUjJ4NlNVWktkbUl6VW14YVFUMDk=";
        case SecurityFailureType.JAILBROKEN:
        return "VWtkV01tRlhUbXhKUjJ4NlNVVndhR0ZYZDJkUmJrcDJZVEpXZFE9PQ==";
      case SecurityFailureType.EMU:
        return "VVZoQ2QwbEhiSHBKU0VveFltMDFjR0p0WTJkaU1qUm5XVmMwWjFKWE1URmlSMFl3WWpOSlBRPT0=";
      case SecurityFailureType.SECURE:
        return "";
      case SecurityFailureType.SOURCE:
        return "VlRJNU1XTnRUbXhKUmxwc1kyMXNiV0ZYVG1oa1IyeDJZbWxDUjFsWGJITmFWMUU5";
      case SecurityFailureType.HOOK:
        return "VTBjNWRtRXliSFZhZVVKcldsaFNiRmt6VW14YVFUMDk=";
      case SecurityFailureType.DEBUGGER:
        return "VWtkV2FXUlhaRzVhV0VsbldrZFdNRnBYVGpCYVYxRTk=";
      case SecurityFailureType.OBFUSCATION:
        return "VkRKS2JXUllUbXBaV0ZKd1lqSTBaMXBIVmpCYVYwNHdXbGRSUFE9PQ==";
      case SecurityFailureType.BINDING:
        return "VVcxc2RWcEhiSFZhZVVKcldsaFNiRmt6VW14YVFUMDk=";
    }
  }
}



