import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';

/// A shimmer skeleton placeholder widget.
///
/// Example:
/// ```dart
/// WidgetXSkeleton(width: 200, height: 16)
/// ```
class WidgetXSkeleton extends StatefulWidget {
  const WidgetXSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  State<WidgetXSkeleton> createState() => _WidgetXSkeletonState();
}

class _WidgetXSkeletonState extends State<WidgetXSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: WidgetXMotion.emphasis,
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 0.9).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.outlineVariant;
    final radius = widget.isCircle
        ? BorderRadius.circular(widget.height / 2)
        : (widget.borderRadius ?? BorderRadius.circular(4));

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) => Container(
        width: widget.isCircle ? widget.height : widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: base.withValues(alpha: _anim.value),
          borderRadius: radius,
        ),
      ),
    );
  }
}

/// A multi-line skeleton text block.
class WidgetXSkeletonText extends StatelessWidget {
  const WidgetXSkeletonText({
    super.key,
    this.lines = 3,
    this.lineHeight = 14,
    this.spacing = 8,
  });

  final int lines;
  final double lineHeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < lines; i++) ...[
          WidgetXSkeleton(
            width: i == lines - 1 ? 120 : double.infinity,
            height: lineHeight,
          ),
          if (i < lines - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }
}
