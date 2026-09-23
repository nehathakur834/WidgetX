import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';
import '../foundations/motion/widgetx_motion.dart';

// ────────────────────────────────────────────────────────────────────────────
// Shared data models
// ────────────────────────────────────────────────────────────────────────────

/// A single data point in a chart.
class WidgetXChartPoint {
  const WidgetXChartPoint({required this.label, required this.value});

  final String label;
  final double value;
}

/// A data series for multi-series charts.
class WidgetXChartSeries {
  const WidgetXChartSeries({
    required this.name,
    required this.points,
    this.color,
  });

  final String name;
  final List<WidgetXChartPoint> points;
  final Color? color;
}

// ────────────────────────────────────────────────────────────────────────────
// Bar Chart
// ────────────────────────────────────────────────────────────────────────────

/// A simple, accessible bar chart rendered with [CustomPaint].
///
/// Example:
/// ```dart
/// WidgetXBarChart(
///   data: [
///     WidgetXChartPoint(label: 'Jan', value: 120),
///     WidgetXChartPoint(label: 'Feb', value: 200),
///   ],
///   title: 'Monthly Revenue',
/// )
/// ```
class WidgetXBarChart extends StatefulWidget {
  const WidgetXBarChart({
    super.key,
    required this.data,
    this.title,
    this.height = 200,
    this.barColor,
    this.isLoading = false,
    this.emptyMessage = 'No data available',
    this.semanticDescription,
  });

  final List<WidgetXChartPoint> data;
  final String? title;
  final double height;
  final Color? barColor;
  final bool isLoading;
  final String emptyMessage;
  final String? semanticDescription;

  @override
  State<WidgetXBarChart> createState() => _WidgetXBarChartState();
}

class _WidgetXBarChartState extends State<WidgetXBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: WidgetXMotion.slow);
    _animation =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (widget.isLoading) {
      return _ChartSkeleton(height: widget.height);
    }
    if (widget.data.isEmpty) {
      return _ChartEmpty(message: widget.emptyMessage, height: widget.height);
    }

    return Semantics(
    label: widget.semanticDescription ??
        'Bar chart: ${widget.title ?? ''}. '
            '${widget.data.map((p) => '${p.label}: ${p.value}').join(', ')}',
    child: _ChartContainer(
      title: widget.title,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _BarChartPainter(
            data: widget.data,
            progress: _animation.value,
            barColor: widget.barColor ?? cs.primary,
            labelColor: cs.onSurfaceVariant,
            gridColor: cs.outlineVariant,
          ),
        ),
      ),
    ),
  );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.data,
    required this.progress,
    required this.barColor,
    required this.labelColor,
    required this.gridColor,
  });

  final List<WidgetXChartPoint> data;
  final double progress;
  final Color barColor;
  final Color labelColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    const labelHeight = 24.0;
    final chartH = size.height - labelHeight;
    final maxVal = data.map((p) => p.value).reduce(math.max);
    if (maxVal == 0) return;

    final barWidth = (size.width / data.length) * 0.6;
    final gap = (size.width / data.length) * 0.4;

    final barPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    // Grid lines
    for (var i = 1; i <= 4; i++) {
      final y = chartH * (1 - i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Bars
    for (var i = 0; i < data.length; i++) {
      final x = i * (barWidth + gap) + gap / 2;
      final barH = (data[i].value / maxVal) * chartH * progress;
      final rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(x, chartH - barH, barWidth, barH),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
      );
      canvas.drawRRect(rect, barPaint);

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: data[i].label,
          style: TextStyle(color: labelColor, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset(x + barWidth / 2 - tp.width / 2, chartH + 4));
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter old) =>
      old.progress != progress || old.data != data;
}

// ────────────────────────────────────────────────────────────────────────────
// Line Chart
// ────────────────────────────────────────────────────────────────────────────

/// A simple animated line chart.
///
/// Example:
/// ```dart
/// WidgetXLineChart(
///   data: [
///     WidgetXChartPoint(label: 'Mon', value: 80),
///     WidgetXChartPoint(label: 'Tue', value: 120),
///   ],
///   title: 'Daily Active Users',
/// )
/// ```
class WidgetXLineChart extends StatefulWidget {
  const WidgetXLineChart({
    super.key,
    required this.data,
    this.title,
    this.height = 200,
    this.lineColor,
    this.fill = true,
    this.isLoading = false,
    this.emptyMessage = 'No data available',
    this.semanticDescription,
  });

  final List<WidgetXChartPoint> data;
  final String? title;
  final double height;
  final Color? lineColor;
  final bool fill;
  final bool isLoading;
  final String emptyMessage;
  final String? semanticDescription;

  @override
  State<WidgetXLineChart> createState() => _WidgetXLineChartState();
}

class _WidgetXLineChartState extends State<WidgetXLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: WidgetXMotion.slow);
    _animation =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (widget.isLoading) {
      return _ChartSkeleton(height: widget.height);
    }
    if (widget.data.isEmpty) {
      return _ChartEmpty(message: widget.emptyMessage, height: widget.height);
    }

    return Semantics(
      label: widget.semanticDescription ??
          'Line chart: ${widget.title ?? ''}. '
              '${widget.data.map((p) => '${p.label}: ${p.value}').join(', ')}',
      child: _ChartContainer(
        title: widget.title,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) => CustomPaint(
            size: Size.infinite,
            painter: _LineChartPainter(
              data: widget.data,
              progress: _animation.value,
              lineColor: widget.lineColor ?? cs.primary,
              fillColor: (widget.lineColor ?? cs.primary)
                  .withValues(alpha: 0.12),
              labelColor: cs.onSurfaceVariant,
              gridColor: cs.outlineVariant,
              fill: widget.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.data,
    required this.progress,
    required this.lineColor,
    required this.fillColor,
    required this.labelColor,
    required this.gridColor,
    required this.fill,
  });

  final List<WidgetXChartPoint> data;
  final double progress;
  final Color lineColor;
  final Color fillColor;
  final Color labelColor;
  final Color gridColor;
  final bool fill;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    const labelHeight = 24.0;
    final chartH = size.height - labelHeight;
    final maxVal = data.map((p) => p.value).reduce(math.max);
    if (maxVal == 0) return;

    final step = size.width / (data.length - 1).clamp(1, double.infinity);
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    // Grid
    for (var i = 1; i <= 4; i++) {
      final y = chartH * (1 - i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Compute points
    final points = <Offset>[];
    final visible = (data.length * progress).ceil().clamp(1, data.length);
    for (var i = 0; i < visible; i++) {
      final x = i * step;
      final y = chartH - (data[i].value / maxVal) * chartH;
      points.add(Offset(x, y));
    }

    // Fill
    if (fill && points.length >= 2) {
      final fillPath = Path()..moveTo(points.first.dx, chartH);
      for (final p in points) {
        fillPath.lineTo(p.dx, p.dy);
      }
      fillPath
        ..lineTo(points.last.dx, chartH)
        ..close();
      canvas.drawPath(fillPath, Paint()..color = fillColor);
    }

    // Line
    if (points.length >= 2) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = lineColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }

    // Dots + labels
    final dotPaint = Paint()..color = lineColor;
    for (var i = 0; i < visible; i++) {
      canvas.drawCircle(points[i], 3, dotPaint);
      final tp = TextPainter(
        text: TextSpan(
          text: data[i].label,
          style: TextStyle(color: labelColor, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset(points[i].dx - tp.width / 2, chartH + 4));
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) =>
      old.progress != progress || old.data != data;
}

// ────────────────────────────────────────────────────────────────────────────
// Pie Chart
// ────────────────────────────────────────────────────────────────────────────

/// An animated pie/donut chart.
///
/// Example:
/// ```dart
/// WidgetXPieChart(
///   segments: [
///     WidgetXChartPoint(label: 'Food', value: 40),
///     WidgetXChartPoint(label: 'Transport', value: 25),
///     WidgetXChartPoint(label: 'Housing', value: 35),
///   ],
///   title: 'Expenses',
/// )
/// ```
class WidgetXPieChart extends StatefulWidget {
  const WidgetXPieChart({
    super.key,
    required this.segments,
    this.title,
    this.size = 200,
    this.donut = true,
    this.colors,
    this.isLoading = false,
    this.emptyMessage = 'No data available',
    this.semanticDescription,
  });

  final List<WidgetXChartPoint> segments;
  final String? title;
  final double size;
  final bool donut;
  final List<Color>? colors;
  final bool isLoading;
  final String emptyMessage;
  final String? semanticDescription;

  @override
  State<WidgetXPieChart> createState() => _WidgetXPieChartState();
}

class _WidgetXPieChartState extends State<WidgetXPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: WidgetXMotion.slow);
    _animation =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final defaultColors = [
      cs.primary,
      cs.secondary,
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF14B8A6),
    ];

    if (widget.isLoading) {
      return _ChartSkeleton(height: widget.size);
    }
    if (widget.segments.isEmpty) {
      return _ChartEmpty(message: widget.emptyMessage, height: widget.size);
    }

    return Semantics(
      label: widget.semanticDescription ??
          'Pie chart: ${widget.title ?? ''}. '
              '${widget.segments.map((p) => '${p.label}: ${p.value}').join(', ')}',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (_, __) {
                  final effectiveColors = widget.colors ?? defaultColors;
                  return SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(widget.size, widget.size),
                          painter: _PieChartPainter(
                            segments: widget.segments,
                            progress: _animation.value,
                            colors: effectiveColors,
                            donut: widget.donut,
                          ),
                        ),
                        // Donut hole drawn in widget layer — BlendMode.clear
                        // is unreliable without a dedicated layer.
                        if (widget.donut)
                          Container(
                            width: widget.size * 0.55,
                            height: widget.size * 0.55,
                            decoration: BoxDecoration(
                              color: cs.surface,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: WidgetXSpacing.lg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.segments.length; i++)
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: WidgetXSpacing.xs),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: (widget.colors ?? defaultColors)[
                                  i % (widget.colors ?? defaultColors).length],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: WidgetXSpacing.xs),
                          Text(
                            widget.segments[i].label,
                            style:
                                Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter({
    required this.segments,
    required this.progress,
    required this.colors,
    required this.donut,
  });

  final List<WidgetXChartPoint> segments;
  final double progress;
  final List<Color> colors;
  final bool donut;

  @override
  void paint(Canvas canvas, Size size) {
    final total = segments.fold<double>(0, (s, p) => s + p.value);
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const startAngle = -math.pi / 2;
    var sweep = 0.0;

    for (var i = 0; i < segments.length; i++) {
      final angle = (segments[i].value / total) * 2 * math.pi * progress;
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + sweep,
        angle,
        !donut,
        paint,
      );

      sweep += angle;
    }
  }

  // Draws the donut hole using a solid background-coloured circle.
  // Call this from the widget layer instead — see [_WidgetXPieChartState].

  @override
  bool shouldRepaint(_PieChartPainter old) =>
      old.progress != progress || old.segments != segments;
}

// ────────────────────────────────────────────────────────────────────────────
// Progress Chart (radial)
// ────────────────────────────────────────────────────────────────────────────

/// A radial progress/gauge chart.
///
/// Example:
/// ```dart
/// WidgetXProgressChart(
///   value: 0.72,
///   label: 'Completion',
/// )
/// ```
class WidgetXProgressChart extends StatefulWidget {
  const WidgetXProgressChart({
    super.key,
    required this.value,
    this.label,
    this.size = 120,
    this.strokeWidth = 12,
    this.color,
    this.backgroundColor,
    this.semanticDescription,
  });

  /// 0.0 to 1.0
  final double value;
  final String? label;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final String? semanticDescription;

  @override
  State<WidgetXProgressChart> createState() => _WidgetXProgressChartState();
}

class _WidgetXProgressChartState extends State<WidgetXProgressChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: WidgetXMotion.slow);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(WidgetXProgressChart old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      _animation = Tween<double>(begin: _animation.value, end: widget.value)
          .animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
      );
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: widget.semanticDescription ??
          '${widget.label ?? 'Progress'}: '
              '${(widget.value * 100).toStringAsFixed(0)}%',
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) => SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RadialProgressPainter(
                  value: _animation.value,
                  color: widget.color ?? cs.primary,
                  backgroundColor:
                      widget.backgroundColor ?? cs.surfaceContainerHighest,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(_animation.value * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (widget.label != null)
                    Text(
                      widget.label!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadialProgressPainter extends CustomPainter {
  _RadialProgressPainter({
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  final double value;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    const startAngle = -math.pi / 2;

    // Background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi,
      false,
      Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi * value,
      false,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RadialProgressPainter old) =>
      old.value != value;
}

// ────────────────────────────────────────────────────────────────────────────
// Area Chart (alias for line with fill = true)
// ────────────────────────────────────────────────────────────────────────────

/// Convenience alias for [WidgetXLineChart] with fill enabled.
class WidgetXAreaChart extends WidgetXLineChart {
  const WidgetXAreaChart({
    super.key,
    required super.data,
    super.title,
    super.height,
    super.lineColor,
    super.isLoading,
    super.emptyMessage,
    super.semanticDescription,
  }) : super(fill: true);
}

// ────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ────────────────────────────────────────────────────────────────────────────

class _ChartContainer extends StatelessWidget {
  const _ChartContainer({
    required this.child,
    required this.height,
    this.title,
  });

  final Widget child;
  final double height;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        SizedBox(
          height: height,
          child: LayoutBuilder(
            builder: (_, constraints) => SizedBox(
              width: constraints.maxWidth,
              height: height,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChartSkeleton extends StatelessWidget {
  const _ChartSkeleton({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ChartEmpty extends StatelessWidget {
  const _ChartEmpty({required this.message, required this.height});
  final String message;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}
