import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/personalization_setting/data/quick_access_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';

class QuickAccessTile extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  final bool isCurrent;
  final QuickAccessData quickAccessData;
  final bool isFirstItem;
  final bool isLastItem;

  const QuickAccessTile({
    super.key,
    required this.index,
    required this.quickAccessData,
    required this.onTap,
    required this.isCurrent,
    this.isFirstItem = false,
    this.isLastItem = false,
  });

  @override
  State<QuickAccessTile> createState() => _QuickAccessTileState();
}

class _QuickAccessTileState extends State<QuickAccessTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:widget.isFirstItem ? 0 : 10,bottom: widget.isLastItem ? 0 :  10),
      decoration: BoxDecoration(
        color: colors(context).whiteColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            children: [
              InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: widget.onTap,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        color: widget.isCurrent
                            ? colors(context).negativeColor100
                            : colors(context).positiveColor100,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: widget.isCurrent
                          ? PhosphorIcon(
                              PhosphorIcons.minus(PhosphorIconsStyle.bold),
                              color: colors(context).negativeColor,
                              size: 16,
                            )
                          : PhosphorIcon(
                              PhosphorIcons.plus(PhosphorIconsStyle.bold),
                              color: colors(context).positiveColor,
                              size: 16,
                            ),
                    ),
                  )),
               AppSizer.horizontalSpacing(12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.5),
                    border: Border.all(color: colors(context).greyColor300!)),
                child: Center(
                  child: widget.quickAccessData.icon != null
                      ? PhosphorIcon(
                          widget.quickAccessData.icon!,
                          color: colors(context).primaryColor,
                          size: 16,
                        )
                      :  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                            widget.quickAccessData.imageIcon!,
                            fit: BoxFit.fitWidth,
                                            color: colors(context).primaryColor,
                            // scale: 16,
                            // height: 16,
                            // width: 5,
                            // color: colors(context).primaryColor,
                          ),
                      ),
                ),
              ),
              AppSizer.horizontalSpacing(12),
              Text(
                  AppLocalizations.of(context)
                      .translate(widget.quickAccessData.title),
                  style: size14weight700.copyWith(
                      color: colors(context).blackColor)),
              if (widget.isCurrent) const Spacer(),
              if (widget.isCurrent)
                ReorderableDragStartListener(
                  key: ValueKey(widget.index),
                  index: widget.index,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        color: colors(context).primaryColor100,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: PhosphorIcon(
                        PhosphorIcons.list(PhosphorIconsStyle.bold),
                        color: colors(context).primaryColor,
                        size: 16,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
