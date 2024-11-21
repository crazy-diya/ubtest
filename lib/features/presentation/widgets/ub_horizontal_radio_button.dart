import 'package:flutter/material.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
class RadioButtonModel {
  String? label;
  String value;

  RadioButtonModel({required this.label, required this.value});
}

class UbCustomRadioButton extends StatefulWidget {
  UbCustomRadioButton({
    Key? key,
    required this.radioButtonDataList,
    this.isVertical = false,
    this.onChange,
    required this.activeColor,
    this.radioLabel,
    this.initialValue,
    this.isInfoIcon = false,
    this.onTapIcon,
    this.widgetInMiddle,
    this.isReadOnly = false,
    this.inforWindowMinHeight,
    this.inforWindowText,
  }): super(key: key);

  final List<RadioButtonModel> radioButtonDataList;
  final bool isVertical;
  final Function? onChange;
  final Color activeColor;
  final String? radioLabel;
  final String? initialValue;
  final bool isInfoIcon;
  final Function? onTapIcon;
  final Widget? widgetInMiddle;
  final String? inforWindowText;
  final double? inforWindowMinHeight;
  final bool isReadOnly;

  @override
  _UbCustomRadioButtonState createState() => _UbCustomRadioButtonState();
}

class _UbCustomRadioButtonState extends State<UbCustomRadioButton> {
  String? id;

  @override
  void initState() {
    if (widget.initialValue != null) {
      id = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.radioLabel!,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    //color: colors(context).greyColor,
                  )
              ),
            ),
            const SizedBox(
              width: 20,
            ),

          ],
        ),
        _body(),
      ],
    );
  }



  List<Widget> _getMiddleWidgetBody() {
    List<Widget> widgetList = [];
    widget.radioButtonDataList.forEach((element) {
      widgetList.add(RadioButtonData(
        label: element.label,
        groupValue: id,
        value: element.value,
        activeColor: widget.activeColor,
        onChange: (value) {
          if (!widget.isReadOnly) {
            setState(() {
              if (widget.isReadOnly) id = value;
              widget.onChange!(value);
            });
          }
        },
      ));

      if (element.value == id) {
        widgetList.add(widget.widgetInMiddle!);
      }
    });

    return widgetList;
  }

  Widget _body() {
    if (widget.widgetInMiddle != null) {
      return Column(
        children: _getMiddleWidgetBody(),
      );
    } else {
      if (widget.isVertical) {
        return Column(
            children: widget.radioButtonDataList
                .map(
                  (e) => RadioButtonData(
                    label: e.label,
                    groupValue: id,
                    value: e.value,
                    activeColor: widget.activeColor,
                    onChange: (value) {
                      if (!widget.isReadOnly) {
                        setState(() {
                          id = value;
                          widget.onChange!(value);
                        });
                      }
                    },
                  ),
                )
                .toList());
      } else {
        return Row(
          children: widget.radioButtonDataList
              .map(
                (e) => RadioButtonData(
                  label: e.label,
                  groupValue: id,
                  value: e.value,
                  activeColor: widget.activeColor,
                  onChange: (value) {
                    if (!widget.isReadOnly) {
                      setState(() {
                        id = value;
                        widget.onChange!(value);
                      });
                    }
                  },
                ),
              )
              .toList(),
        );
      }
    }
  }
}

class RadioButtonData extends StatelessWidget {
  const RadioButtonData(
      {Key? key,
      this.label,
      this.groupValue,
      this.activeColor,
      this.value,
      this.onChange})
      : super(key: key);

  final String? label;
  final String? groupValue;
  final Color? activeColor;
  final String? value;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UBRadio<dynamic>(
          onChanged:(value){
onChange?.call(value);
          } ,
          value: value,
          groupValue: groupValue,
        ),
        Text(
          label ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
