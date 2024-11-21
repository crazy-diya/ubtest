import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../data/models/responses/common_check_box_response.dart';

class ReusableCheckboxList extends StatefulWidget {
  final List<CommonCheckBoxResponse> options;
  final List<CommonCheckBoxResponse> selectedOptions;
  final Function(List<CommonCheckBoxResponse>) onChanged;

  const ReusableCheckboxList({
    Key? key,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ReusableCheckboxListState createState() => _ReusableCheckboxListState();
}

class _ReusableCheckboxListState extends State<ReusableCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.options.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Transform.scale(
                    scale: 1.1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: widget.selectedOptions
                                  .contains(widget.options[index])
                              ? colors(context).blackColor!
                              : Colors.transparent,
                          width: 2.0,
                        ),
                        color: widget.selectedOptions
                                .contains(widget.options[index])
                            ? colors(context).whiteColor
                            : null,
                      ),
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        checkColor: colors(context).blackColor,
                        visualDensity: VisualDensity.compact,
                        activeColor: Colors.transparent,
                        value: widget.selectedOptions
                            .contains(widget.options[index]),
                        onChanged: (isChecked) {
                          setState(() {
                            if (isChecked!) {
                              widget.selectedOptions.add(widget.options[index]);
                            } else {
                              widget.selectedOptions
                                  .remove(widget.options[index]);
                            }
                            widget.onChanged(widget.selectedOptions);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    widget.options[index].description!,
                    style:
                        widget.selectedOptions.contains(widget.options[index])
                            ? TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colors(context).blackColor,
                              )
                            : TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colors(context).greyColor,
                              ),
                  ),
                ),
              ],
            ),
            index == widget.options.length - 1
                ? const SizedBox.shrink()
                : const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
