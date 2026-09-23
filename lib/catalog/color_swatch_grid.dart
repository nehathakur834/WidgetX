import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class ColorSwatchGrid extends StatelessWidget {
  const ColorSwatchGrid({super.key});

  static const _swatches = [
    _Swatch('Primary', WidgetXColors.primary, Colors.white),
    _Swatch('Secondary', WidgetXColors.secondary, Colors.white),
    _Swatch('Surface', WidgetXColors.surface, Color(0xFF1E293B)),
    _Swatch('Background', WidgetXColors.background, Color(0xFF1E293B)),
    _Swatch('Success', WidgetXColors.success, Colors.white),
    _Swatch('Warning', WidgetXColors.warning, Colors.white),
    _Swatch('Error', WidgetXColors.error, Colors.white),
    _Swatch('Info', WidgetXColors.info, Colors.white),
    _Swatch('Outline', WidgetXColors.outline, Color(0xFF1E293B)),
    _Swatch('Disabled', WidgetXColors.disabled, Color(0xFF1E293B)),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: WidgetXSpacing.xs,
        crossAxisSpacing: WidgetXSpacing.xs,
        childAspectRatio: 2.5,
      ),
      itemCount: _swatches.length,
      itemBuilder: (_, i) => _SwatchTile(swatch: _swatches[i]),
    );
  }
}

class _SwatchTile extends StatelessWidget {
  const _SwatchTile({required this.swatch});
  final _Swatch swatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: swatch.color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        swatch.name,
        style: TextStyle(
          color: swatch.textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Swatch {
  const _Swatch(this.name, this.color, this.textColor);
  final String name;
  final Color color;
  final Color textColor;
}
