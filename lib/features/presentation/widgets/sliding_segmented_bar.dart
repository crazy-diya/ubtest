import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class SlidingSegmentedBar extends StatefulWidget {
  /// Custom segmented bar with sliding effect with custom designs.
  /// Typically used as a tab bar.
  /// The [children] are the widgets to be displayed as the segments.
  /// The [selectedIndex] is the index of the selected segment.
  /// The [onChanged] is the callback called when the user taps a segment.

  const SlidingSegmentedBar({
    Key? key,
    required this.children,
    required this.onChanged,
    required this.selectedIndex,
    this.selectedTextStyle,
    this.textStyle,
    this.borderRadius,
    this.thumbColor,
    this.thumbGradient, 
    this.isBorder = false,  
    this.backgroundColor, 
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : assert(children.length >= 2), super(key: key);

  /// List of children to display in the segmented bar.
  /// Must be at least two widgets.
  /// Only allows [String] values.
  final List<String> children;

  /// Called when the user taps a segment.
  /// The index of the tapped segment is passed to the callback.
  /// The state of the segmented bar is not modified by this callback.
  final ValueChanged<int> onChanged;

  /// The index of the currently selected segment.
  /// The state of the segmented bar is updated by this value.
  final int selectedIndex;

  /// The Style of the selected segment.
  /// If null, the default style is used.
  final TextStyle? selectedTextStyle;
  
  /// The Style of the unselected segment.
  /// If null, the default style is used.
  final TextStyle? textStyle;

  /// The radius of the segment.
  final BorderRadius? borderRadius;

  /// The color of the segment.
  /// If null, the default color is used.
  /// Can be overridden by the [thumbGradient].
  final Color? thumbColor;

  /// The gradient of the segment.
  /// If null, color will be used.
  /// If not null, color will be ignored.
  final Gradient? thumbGradient;

  final bool? isBorder;

  final Color? backgroundColor;

  final EdgeInsets padding;

  @override
  State<SlidingSegmentedBar> createState() => _SlidingSegmentedBarState();
}

class _SlidingSegmentedBarState extends State<SlidingSegmentedBar> with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  Size? _tabSize;
  late int _selectedIndex;

  late Animation<Offset> _animation;
  late AnimationController _animationController;

  final Logger _logger = Logger('_SlidingSegmentedControlState');

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getTabSize());
    super.initState();
  }

  void animateToTab(int newIndex, int oldIndex) {
    _logger.fine('animateToTab: newIndex: $newIndex, oldIndex: $oldIndex');
    _animationController.reset();
    Offset currentOffset = Offset((_tabSize!.width / widget.children.length) * oldIndex, 0);
    Offset targetOffset = Offset((_tabSize!.width / widget.children.length) * newIndex, 0);
    _animation = Tween<Offset>(
      begin: currentOffset,
      end: targetOffset,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward().then((value) => {
      setState(() {
        _selectedIndex = newIndex;
      })
    });
  }

  void getTabSize() {
    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _tabSize = renderBox.size;
      });
    }
    _logger.fine('getTabSize: ${_tabSize?.toString()}');
  }

  @override
  void didUpdateWidget(covariant SlidingSegmentedBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (oldWidget.selectedIndex != widget.selectedIndex) {
      animateToTab(widget.selectedIndex, oldWidget.selectedIndex);
    // }

  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:widget.backgroundColor?? colors(context).primaryColor,
        border:widget.isBorder! ? Border.all(
          color: colors(context).greyColor!.withOpacity(0.5),
          width: 0.2,
        ):null,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _tabSize != null ? SlidingSegmentedPainter(
              tabSize: _tabSize ?? Size.zero,
              segmentOffset: _animation.value,
              childCount: widget.children.length,
              thumbColor: widget.thumbColor ?? colors(context).primaryColor!,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
              thumbGradient: widget.thumbGradient,
            ) : null,
            child: Row(
              key: _key,
              children: widget.children.map((label) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onChanged(widget.children.indexOf(label));
                    },
                    child: Container(
                      padding:widget.padding,
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: _selectedIndex == widget.children.indexOf(label) ? widget.selectedTextStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary) : widget.textStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      )
    );
  }
}

class SlidingSegmentedPainter extends CustomPainter {
  late Size tabSize;
  late Offset segmentOffset;
  late int childCount;
  late BorderRadius borderRadius;
  late Color thumbColor;
  late Gradient? thumbGradient;
  SlidingSegmentedPainter({
    required this.tabSize,
    required this.segmentOffset,
    required this.childCount,
    required this.borderRadius,
    required this.thumbColor,
    this.thumbGradient,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    final double width = tabSize.width / childCount;
    final double height = tabSize.height;

    final double left = segmentOffset.dx;
    final double top = segmentOffset.dy;

    if (thumbGradient != null) {
      paint.shader = thumbGradient?.createShader(Rect.fromLTWH(left, top, width, height));
    }

    final Radius radius = borderRadius.topLeft;

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(left, top, width, height), radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}