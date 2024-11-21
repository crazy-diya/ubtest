import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../../../utils/navigation_routes.dart';
import '../../../../bloc/settings/settings_bloc.dart';
import '../../../../bloc/settings/settings_state.dart';
import '../../../../widgets/appbar.dart';
import '../../../base_view.dart';

class ProfileDetailsView extends BaseView {
  const ProfileDetailsView({super.key});

  @override
  _ProfileDetailsViewState createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends BaseViewState<ProfileDetailsView> {
  final _bloc = injection<SettingsBloc>();
  TextEditingController? _cName;
  TextEditingController? _uName;
  TextEditingController? _name;
  TextEditingController? _mobileNum;
  TextEditingController? _email;
  TextEditingController? _nic;

  @override
  void initState() {
    super.initState();
    _cName = TextEditingController(text: (AppConstants.profileData.cName != null ||
                AppConstants.profileData.cName != "")
            ? AppConstants.profileData.cName
            : AppConstants.profileData.fName);
    _uName = TextEditingController(text: AppConstants.profileData.userName);
    _name = TextEditingController(text: AppConstants.profileData.name);
    _mobileNum = TextEditingController(
        text: AppConstants.profileData.mobileNo!.length == 9 && AppConstants.profileData.mobileNo!.startsWith("07")
            ? "0${AppConstants.profileData.mobileNo}"
            : AppConstants.profileData.mobileNo);
    _email = TextEditingController(text: AppConstants.profileData.email);
    _nic = TextEditingController(text: AppConstants.profileData.nic);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, Routes.kProfileSettingsHomeView)
                  .then((value) {
                setState(() {});
              });
            },
            icon: PhosphorIcon(
              PhosphorIcons.pencilSimpleLine(),
              color: colors(context).whiteColor,
            ),
          ),
        ],
        title: AppLocalizations.of(context).translate("profile"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,0,20.w,0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizer.verticalSpacing(24.h),
                          AppConstants.profileData.profileImage != null
                              ? Center(
                                  child: CircleAvatar(
                                    radius: 36.h,
                                    backgroundImage: MemoryImage(
                                        AppConstants.profileData.profileImage!),
                                  ),
                                )
                              : Center(
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFCEE5D4),
                                    radius: 36.h,
                                    child: Text(

                                      (AppConstants.profileData.cName??
                                          AppConstants.profileData.fName??"").getNameInitial() ??
                                          "",
                                      style:  size24weight400.copyWith(
                                        color: colors(context).greyColor200,fontSize: 40
                                      )
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16).w,
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              // width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("nickname"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      _cName!.text,
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Divider(
                                      color: colors(context).greyColor,
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("username"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      _uName!.text,
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Divider(
                                      color: colors(context).greyColor,
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("Full_Name"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      _name!.text,
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Divider(
                                      color: colors(context).greyColor,
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("NIC_number"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      _nic!.text,
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Divider(
                                      color: colors(context).greyColor,
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("Mobile_Number"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      formatMobileNumber(_mobileNum!.text),
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Divider(
                                      color: colors(context).greyColor,
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("Email"),
                                      style: size14weight700.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      _email!.text,
                                      style: size16weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
