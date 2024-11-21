import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/request_money/data/phone_contact.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/validator.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_sizer.dart';
import '../base_view.dart';

class RequestMoneyContactListView extends BaseView {
  RequestMoneyContactListView({super.key});

  @override
  _RequestMoneyContactListViewState createState() =>
      _RequestMoneyContactListViewState();
}

class _RequestMoneyContactListViewState
    extends BaseViewState<RequestMoneyContactListView> {
  List<PhoneContact> _contacts = [];
  PhoneContact? pickedContact;
  var bloc = injection<SplashBloc>();
  bool toggleValue = false;
  Map<String, List<PhoneContact>> contactListMap = {};
  Map<String, List<PhoneContact>> searchContactListMap = {};
  List<PhoneContact> contactList = [];
  ItemScrollController scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async =>await _getContacts()) ;
  }

  Future<void> _getContacts() async {
      showProgressBar();
      await Future.delayed (const Duration(seconds: 2), () async {
      try{
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      setState(() {
        _contacts = contacts
          .where((element) => element.phones.isNotEmpty)
          .toList()
          .map((e) => PhoneContact(
              id: e.id,
              phoneNumber: (e.phones.first.number.startsWith("0") ||
                      e.phones.first.number.startsWith("("))
                  ? e.phones.first.number.replaceAll(RegExp(r'[^0-9]'), '')
                  : e.phones.first.number
                      .replaceAll(RegExp(r'^(\+94|\+094|94)'), '0')
                      .replaceAll(RegExp(r'\s+'), ''),
              isUbUser: false,
              displayName: e.displayName,
              firstLetter: getFirstEmojiOrLetter(e.displayName))) // Use the function here
          .toList();
        groupContactsByFirstLetter(_contacts);
        searchContactListMap = contactListMap;
      });
       }catch(e){
        hideProgressBar();
       }
    });
    hideProgressBar();
  }

    List<String> getAlphabets() {
    return List<String>.generate(26, (index) => String.fromCharCode(index + 65));
  }

  void scrollToLetter(String letter) {
    int index = searchContactListMap.keys.toList().indexOf(letter);
    if (index != -1) {
      scrollController.scrollTo(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut, index: index,
      );
    }
  }



@override
Widget buildView(BuildContext context) {
  return Scaffold(
    backgroundColor: colors(context).primaryColor50,
    appBar: UBAppBar(
      title: AppLocalizations.of(context).translate("contacts_list"),
    ),
    body: Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 0.w, 0.h),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20).w,
            child: SearchTextField(
              isBorder: false,
              hintText: AppLocalizations.of(context).translate("search_contact"),
              onChange: (value) {
                setState(() {
                  if (value.isEmpty || value.trim() == '') {
                    searchContactListMap = contactListMap;
                  } else {
                    searchContactListMap = filterContacts(value.toLowerCase());
                  }
                });
              },
            ),
          ),
          24.verticalSpace,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ScrollablePositionedList.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    itemScrollController: scrollController,
                    shrinkWrap: true,
                    itemCount: searchContactListMap.length,
                    padding:EdgeInsets.only(bottom: 24.h+ AppSizer.getHomeIndicatorStatus(context)),
                    itemBuilder: (context, index) {
                      String key = searchContactListMap.keys.toList()[index];
                      contactList = searchContactListMap[key]!;
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(index == 0 ? 8 : 0),
                                    topRight: Radius.circular(index == 0 ? 8 : 0),
                                    bottomLeft: Radius.circular(index == (searchContactListMap.length-1) ? 8 : 0),
                                    bottomRight: Radius.circular(index == (searchContactListMap.length-1) ? 8 : 0),
                                    )
                                .r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:16.w,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16.w),
                                child: Text(
                                  key,
                                  style: size20weight700.copyWith(
                                      color: colors(context).primaryColor),
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: contactList.length,
                                itemBuilder: (context, index2) {
                                  if (contactList.isNotEmpty && index2 < contactList.length) {
                                    PhoneContact? singleContact = contactList[index2];
                                    return InkWell(
                                      onTap: () {
                                        pickedContact = singleContact;
                                        Navigator.of(context).pop(pickedContact);
                                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 16.h, 8.w, 16.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 48.w,
                                                  height: 48.h,
                                                  decoration: BoxDecoration(
                                                    color: colors(context).secondaryColor100,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: colors(context).greyColor300!),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      singleContact.displayName?.toString().getNameInitial() ?? "",
                                                      style: size20weight700.copyWith(
                                                          color: colors(context).secondaryColor800),
                                                    ),
                                                  ),
                                                ),
                                                12.horizontalSpace,
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        singleContact.displayName ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: size16weight700.copyWith(
                                                          color: colors(context).blackColor,
                                                        ),
                                                      ),
                                                      .48.verticalSpace,
                                                      Text(
                                                        singleContact.phoneNumber,
                                                        style: size14weight400.copyWith(
                                                          color: colors(context).blackColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // 3.horizontalSpace,
                                                UBRadio<dynamic>(
                                                  value: singleContact,
                                                  groupValue: pickedContact,
                                                  onChanged: (value) {
                                                    pickedContact = value;
                                                    Navigator.of(context).pop(pickedContact);
                                                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          (searchContactListMap.length - 1 == index) &&
                                                  (contactList.length - 1 == index2)
                                              ? SizedBox.shrink()
                                              : Divider(
                                                  height: 0,
                                                  thickness: 1,
                                                  color: colors(context).greyColor100,
                                                )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  physics:NeverScrollableScrollPhysics(),
                  child: Container(
                    width: 28.w,
                    height: ScreenUtil().screenHeight-kToolbarHeight,
                    child:  Column(
                  children: getAlphabets()
                            .map((letter) => InkWell(
                                  onTap: () => scrollToLetter(letter),
                                  child:Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(4.w, 2.h, 8.w, 0.h),
                                      child: Center(
                                          child: Text(letter,
                                              style: size12weight400.copyWith(
                                                  color: searchContactListMap.keys
                                                          .any((element) =>
                                                              element == letter)
                                                      ? colors(context)
                                                          .primaryColor
                                                      : colors(context)
                                                          .greyColor200))),
                                    ),
                                  ),
                                ))
                            .toList(),
                                ),
                  ),
                ),
              ],
            ),
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

  int getTotalCount(dynamic data) {
    if (data is List) {
      return data.fold(0, (sum, item) => sum + getTotalCount(item));
    } else {
      return 0;
    }
  }

  void groupContactsByFirstLetter(List<PhoneContact> contacts) {
    contactListMap.clear();
    for (PhoneContact contact in contacts) {
      String firstLetter = contact.firstLetter?.toUpperCase() ?? "#";
      if (!contactListMap.containsKey(firstLetter)) {
        contactListMap[firstLetter] = [];
      }
      contactListMap[firstLetter]!.add(contact);
    }
  }

  Map<String, List<PhoneContact>> filterContacts(String searchTerm) {
    showProgressBar();
    Map<String, List<PhoneContact>> filteredList = {};
    contactListMap.forEach((key, value) {
      filteredList[key] = value
          .where((contact) =>
              contact.displayName
                  ?.toLowerCase()
                  .contains(searchTerm.toLowerCase()) ??
              false).toSet()
          .toList();
    });
    filteredList.removeWhere((key, value) => value.isEmpty);
    hideProgressBar();
    return filteredList;
  }
}

