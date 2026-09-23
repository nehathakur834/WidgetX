import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(WidgetXSpacing.md),
      children: [
          const SectionHeader(
            title: 'Current Screen Size',
            description: 'Resize the window to see how breakpoints change.',
          ),
          WidgetXResponsiveBuilder(
            builder: (context, size) => WidgetXCard(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Screen size: ${size.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Text(
                    'Width: ${MediaQuery.sizeOf(context).width.toStringAsFixed(0)}px',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Breakpoints'),
          const WidgetXCard(
            body: Column(
              children: [
                WidgetXKeyValueRow(label: 'Mobile', value: '0 – 599px'),
                SizedBox(height: WidgetXSpacing.xs),
                WidgetXKeyValueRow(label: 'Tablet', value: '600 – 1023px'),
                SizedBox(height: WidgetXSpacing.xs),
                WidgetXKeyValueRow(label: 'Desktop', value: '1024px+'),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Responsive Container'),
          const WidgetXResponsiveContainer(
            tabletMaxWidth: 600,
            desktopMaxWidth: 800,
            padding: EdgeInsets.all(WidgetXSpacing.md),
            child: WidgetXCard(
              body: Text(
                'This container is constrained to different max-widths '
                'depending on the screen size.',
              ),
            ),
          ),
      ],
    );
  }
}
