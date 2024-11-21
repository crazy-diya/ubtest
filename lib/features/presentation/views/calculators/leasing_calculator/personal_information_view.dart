
import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/calculators/leasing_calculator/widgets/image_capture.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/drop_down/drop_down_bloc.dart';
import '../../../bloc/splash/splash_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../base_view.dart';

class LeasingPersonalInformationView extends BaseView {

  @override
  _PersonalInformationViewState createState() => _PersonalInformationViewState();
}

class _PersonalInformationViewState extends BaseViewState<LeasingPersonalInformationView> {
  var bloc = injection<SplashBloc>();

  String? selectedMaritalStatus;
  String? _selectedGender;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("leasing_calculator"),
        goBackEnabled: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24,right: 24,bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("personal_info"),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      AppLocalizations.of(context).translate("please_confirm_your_personal_info"),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      AppLocalizations.of(context).translate("please_make_necessary_changes"),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Title',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'First Name',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Last Name',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'NIC Number',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Address',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Mobile Number',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppDropDown(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kDropDownView,
                            arguments: DropDownViewScreenArgs(
                              isSearchable: true,
                              pageTitle: 'Marital Status',
                              dropDownEvent: GetLMaritalStatusEvent(),
                            )).then((value) {
                          if (value != null &&
                              value is CommonDropDownResponse) {
                            setState(() {
                              selectedMaritalStatus = value.description;
                            });
                          }
                        });
                      },
                      labelText: 'Marital Status',
                      initialValue: selectedMaritalStatus,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomRadioButtonGroup(
                      options: [
                        RadioButtonModel(
                            label: AppLocalizations.of(context)
                                .translate("male"),
                            value: '1'),
                        RadioButtonModel(
                            label: AppLocalizations.of(context)
                                .translate("female"),
                            value: '2'),
                      ],
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      title: AppLocalizations.of(context).translate("gender"),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("employment_details"),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Employer Name',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Designation',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Monthly Income',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Telephone Number',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("vehicle_details"),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Vehicle Type',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Make and Model',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Year of Manufacture',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: 'Registration Number',
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("documents_verification"),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("please_upload_copy_of_NIC"),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    Row(
                      children: [
                        ImageSelectionContainer(title: 'Front of ID', title2: 'Capture or upload ', description: 'Max image size : 20MB Supports: JPG, JPEG, PNG', width: MediaQuery.of(context).size.width*0.39,),
                        const SizedBox(
                          width: 24,
                        ),
                        ImageSelectionContainer(title: 'Back of ID', title2: 'Capture or upload ', description: 'Max image size : 20MB Supports: JPG, JPEG, PNG', width: MediaQuery.of(context).size.width*0.39,),
                      ],
                    ),

                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("upload_latest_bank_statements"),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        ImageSelectionContainer(title: 'Statement 01', title2: 'Capture or upload ', description: 'Max image size : 20MB Supports: JPG, JPEG, PNG', width: MediaQuery.of(context).size.width*0.39,),
                        const SizedBox(
                          width: 24,
                        ),
                        ImageSelectionContainer(title: 'Statement 02', title2: 'Capture or upload ', description: 'Max image size : 20MB Supports: JPG, JPEG, PNG', width: MediaQuery.of(context).size.width*0.39,),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("upload_salary_confirmation_letter"),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: colors(context).blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ImageSelectionContainer(title: 'Salary Confirmation Letter', title2: 'Capture or upload ', description: 'Max image size : 20MB Supports: JPG, JPEG, PNG', width: MediaQuery.of(context).size.width,),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),




            const SizedBox(
              height: 24,
            ),
            AppButton(
              buttonText:
              AppLocalizations.of(context).translate("submit"),
              onTapButton: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}







