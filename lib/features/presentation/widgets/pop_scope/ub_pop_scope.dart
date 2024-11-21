import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UBPopScope extends StatefulWidget {
  final Widget child;
  final Future<bool> Function()? onPopInvoked;

  const UBPopScope({
    super.key,
    required this.child,
    this.onPopInvoked,
  });

  @override
  State<UBPopScope> createState() => _UBPopScopeState();
}

class _UBPopScopeState extends State<UBPopScope> with SingleTickerProviderStateMixin {
  final double? swipeWidth = ScreenUtil().screenWidth;
  final double? swipeThreshold = ScreenUtil().screenWidth / 2;
  late final _marginLeftNotifier = ValueNotifier(0.0);

  bool initialLeft = false;

  double get _currentMarginLeft => _marginLeftNotifier.value;
  double get _swipeWidth => swipeWidth ?? ScreenUtil().screenWidth;
  double get _swipeThreshold => swipeThreshold ?? (_swipeWidth / 2);

  @override
  void dispose() {
    _marginLeftNotifier.dispose();
    super.dispose();
  }

  double calculateOpacity(double marginLeft) {
    double proportion = marginLeft / ScreenUtil().screenWidth;
    return (1.0 - (0.8 * proportion)).clamp(0.8, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? PopScope(
            canPop: widget.onPopInvoked == null,
            onPopInvoked: (didPop) {
              if (didPop) return;
              widget.onPopInvoked?.call();
            },
            child: widget.child)
        : GestureDetector(
            onHorizontalDragUpdate: (details) {
              final isSwipedRight = (details.primaryDelta ?? 0) > 0;
              final isSwiped = _currentMarginLeft > 0;
              if (initialLeft) {
                if (isSwipedRight) {
                  _marginLeftNotifier.value = details.globalPosition.dx;
                } else if (isSwiped) {
                  _marginLeftNotifier.value = details.globalPosition.dx;
                }
              }
            },
            onHorizontalDragCancel: () {
              _marginLeftNotifier.value = 0;
              initialLeft = false;
            },
            onHorizontalDragStart: (details) {
              initialLeft = details.globalPosition.dx < 40;
            },
            onHorizontalDragEnd: (details) {
              final isThresholdExcedeed = _currentMarginLeft >= _swipeThreshold;
              if (isThresholdExcedeed) {
                widget.onPopInvoked?.call().then((value) {
                  log(value.toString());
                  if (value == true) {
                    _marginLeftNotifier.value = 0;
                    initialLeft = false;
                  } else if (value == false) {
                    _marginLeftNotifier.value = _swipeWidth;
                    initialLeft = false;
                  }
                });
              } else {
                _marginLeftNotifier.value = 0;
                initialLeft = false;
              }
            },
            child: ValueListenableBuilder<double>(
              valueListenable: _marginLeftNotifier,
              builder: (_, margin, __) => AnimatedSlide(
                duration: const Duration(milliseconds: 50),
                offset: Offset((margin / _swipeWidth), 0),
                child: AnimatedOpacity(
                    opacity: calculateOpacity(margin),
                    duration: const Duration(milliseconds: 50),
                    child: widget.child),
              ),
            ),
          );
  }
}
