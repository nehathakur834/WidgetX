import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/color_swatch_grid.dart';
import '../catalog/type_scale_list.dart';
import '../catalog/spacing_scale_list.dart';

class FoundationsScreen extends StatelessWidget {
  const FoundationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md, WidgetXSpacing.md,
        WidgetXSpacing.md, WidgetXSpacing.md + bottom,
      ),
      children: const [
        SectionHeader(title: 'Color Tokens'),
        ColorSwatchGrid(),
        SizedBox(height: WidgetXSpacing.lg),
        SectionHeader(title: 'Typography Scale'),
        TypeScaleList(),
        SizedBox(height: WidgetXSpacing.lg),
        SectionHeader(title: 'Spacing Scale'),
        SpacingScaleList(),
      ],
    );
  }
}
