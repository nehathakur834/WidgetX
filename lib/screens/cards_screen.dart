import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(WidgetXSpacing.md),
      children: [
          const SectionHeader(title: 'Basic Card'),
          WidgetXCard(
            title: const Text('Order Summary'),
            subtitle: const Text('3 items · \$49.99'),
            body: const Text(
              'Your order has been placed and is being processed.',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Loading Card'),
          const WidgetXCard(isLoading: true, body: SizedBox.shrink()),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Selectable Card'),
          WidgetXCard(
            title: const Text('Pro Plan'),
            subtitle: const Text('\$9.99 / month'),
            isSelected: _selected,
            onTap: () => setState(() => _selected = !_selected),
            semanticDescription: 'Pro Plan card, tap to select',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Expandable Card'),
          const WidgetXExpandableCard(
            title: Text('What is WidgetX UI?'),
            subtitle: Text('Tap to expand'),
            expandedContent: Text(
              'WidgetX UI is a reusable Flutter design system that helps '
              'developers build consistent, accessible, and scalable '
              'applications faster.',
            ),
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Data Display'),
          const WidgetXCard(
            body: Column(
              children: [
                WidgetXKeyValueRow(label: 'Plan', value: 'Pro'),
                SizedBox(height: WidgetXSpacing.xs),
                WidgetXKeyValueRow(label: 'Status', value: 'Active'),
                SizedBox(height: WidgetXSpacing.xs),
                WidgetXKeyValueRow(label: 'Renews', value: 'Jan 1, 2026'),
              ],
            ),
          ),
      ],
    );
  }
}
