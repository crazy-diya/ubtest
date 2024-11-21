import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/secure_storage.dart';

import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../utils/navigation_routes.dart';

class SettingsLanguageComponent extends StatefulWidget {
  final String title;
  final PhosphorIcon icon;

  SettingsLanguageComponent({
    required this.title,
    required this.icon,
  });

  @override
  _SettingsLanguageComponentState createState() =>
      _SettingsLanguageComponentState();
}

class _SettingsLanguageComponentState extends State<SettingsLanguageComponent> {
  final _secureStorage = injection<SecureStorage>();
  String? selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getLang());
  }

  void getLang() async {
    final result = await _secureStorage.getData(SELECTED_LANGUAGE);
    if (result == 'si') {
      selectedLanguage = 'සිංහල';
    } else if (result == 'ta') {
      selectedLanguage = 'தமிழ்';
    } else {
      selectedLanguage = 'English';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).w,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.kLanguageSelectionView,
                  arguments: false)
              .then((value) => setState(() {
                    getLang();
                  }));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon,
            8.horizontalSpace,
            Expanded(
                child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.title,
                      style: size16weight700.copyWith(
                        color: colors(context).greyColor,
                      )),
                ),
              ],
            )),
            Text(selectedLanguage!,
                style: size16weight700.copyWith(
                  color: colors(context).greyColor,
                )),
            8.horizontalSpace,
            PhosphorIcon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              color: colors(context).greyColor300,
            )
          ],
        ),
      ),
    );
  }
}
