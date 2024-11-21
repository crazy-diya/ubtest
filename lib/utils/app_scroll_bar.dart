
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


class AppScrollView extends StatelessWidget {
  final Widget? child;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final bool isInsideMarginAvailable;

  const AppScrollView({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.physics,
    this.controller,
    this.child,
    this.isInsideMarginAvailable = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: controller,
      thumbColor: colors(context).primaryColor,
      radius: const Radius.circular(10.0),
      thickness: 6,
      child: SingleChildScrollView(
        padding: padding,
        physics: physics,
        key: key,
        clipBehavior: clipBehavior,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: child,
        ),
      ),
    );
  }
}
