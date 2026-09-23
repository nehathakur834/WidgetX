import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';
class DataDisplayScreen extends StatefulWidget {
  const DataDisplayScreen({super.key});

  @override
  State<DataDisplayScreen> createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  final Set<int> _selectedRows = {};

  static final _tableRows = [
    ['Alice Chen', 'Designer', 'Active', 'Jan 2022'],
    ['Bob Martinez', 'Engineer', 'Active', 'Mar 2021'],
    ['Carol White', 'Product', 'Away', 'Sep 2023'],
    ['David Kim', 'Engineer', 'Inactive', 'Jun 2020'],
    ['Eva Rossi', 'Design', 'Active', 'Dec 2022'],
  ];

  static const _timelineItems = [
    WidgetXTimelineItem(
      title: 'Order placed',
      subtitle: 'Your order #1234 was received',
      time: '09:00',
      icon: Icons.shopping_cart_outlined,
      isCompleted: true,
    ),
    WidgetXTimelineItem(
      title: 'Payment confirmed',
      subtitle: 'Card ending in 4242 charged',
      time: '09:05',
      isCompleted: true,
    ),
    WidgetXTimelineItem(
      title: 'In transit',
      subtitle: 'Estimated delivery: Tomorrow',
      time: '14:30',
      isActive: true,
    ),
    WidgetXTimelineItem(
      title: 'Delivered',
      subtitle: 'Package delivered to door',
    ),
  ];

  static const _accordionItems = [
    WidgetXAccordionItem(
      title: 'What is WidgetX UI?',
      icon: Icons.info_outline,
      content: Text(
        'WidgetX UI is an open-source Flutter design system that provides '
        'reusable, accessible, and themeable components for building '
        'production-quality applications.',
      ),
    ),
    WidgetXAccordionItem(
      title: 'How do I add it to my project?',
      content: Text(
        'Add widgetx_ui as a dependency in your pubspec.yaml, then import '
        'package:widgetx_ui/widgetx_ui.dart.',
      ),
    ),
    WidgetXAccordionItem(
      title: 'Does it support dark mode?',
      content: Text(
        'Yes. Use WidgetXTheme.light() and WidgetXTheme.dark() with '
        'MaterialApp to support both light and dark themes.',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md,
        WidgetXSpacing.md,
        WidgetXSpacing.md,
        WidgetXSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      children: [
          // Badges
          const SectionHeader(
            title: 'Badges',
            description: 'Status labels and notification indicators.',
          ),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: WidgetXBadgeVariant.values
                .map((v) => WidgetXBadge(label: v.name, variant: v))
                .toList(),
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Overlay Badge'),
          Row(
            children: [
              const WidgetXOverlayBadge(
                count: 5,
                child: WidgetXAvatar(initials: 'JD'),
              ),
              const SizedBox(width: WidgetXSpacing.md),
              WidgetXOverlayBadge(
                showDot: true,
                child: Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Chips
          const SectionHeader(
            title: 'Chips',
            description: 'Compact elements for attributes and filters.',
          ),
          const Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: [
              WidgetXChip(label: 'Flutter'),
              WidgetXChip(label: 'Dart'),
              WidgetXChip(label: 'Material 3', isSelected: true),
              WidgetXChip(label: 'Design Systems'),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Avatars
          const SectionHeader(title: 'Avatars'),
          const Wrap(
            spacing: WidgetXSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              WidgetXAvatar(initials: 'JD', size: WidgetXAvatarSize.xs),
              WidgetXAvatar(initials: 'AB', size: WidgetXAvatarSize.sm),
              WidgetXAvatar(initials: 'CD'),
              WidgetXAvatar(initials: 'EF', size: WidgetXAvatarSize.lg),
              WidgetXAvatar(icon: Icons.person, size: WidgetXAvatarSize.xl),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Avatar Group'),
          const WidgetXAvatarGroup(
            avatars: [
              WidgetXAvatar(initials: 'JD'),
              WidgetXAvatar(initials: 'AB'),
              WidgetXAvatar(initials: 'CD'),
              WidgetXAvatar(initials: 'EF'),
              WidgetXAvatar(initials: 'GH'),
              WidgetXAvatar(initials: 'IJ'),
            ],
            maxShown: 4,
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // List Tile
          const SectionHeader(title: 'List Tiles'),
          WidgetXCard(
            padding: EdgeInsets.zero,
            body: Column(
              children: [
                WidgetXListTile(
                  title: 'Alice Chen',
                  subtitle: 'Senior Designer',
                  leading: const WidgetXAvatar(
                    initials: 'AC',
                    size: WidgetXAvatarSize.sm,
                  ),
                  trailing: const WidgetXBadge(
                    label: 'Active',
                    variant: WidgetXBadgeVariant.success,
                  ),
                  onTap: () {},
                ),
                const WidgetXDivider(),
                WidgetXListTile(
                  title: 'Bob Martinez',
                  subtitle: 'Staff Engineer',
                  leading: const WidgetXAvatar(
                    initials: 'BM',
                    size: WidgetXAvatarSize.sm,
                  ),
                  trailing: const WidgetXBadge(
                    label: 'Away',
                    variant: WidgetXBadgeVariant.warning,
                  ),
                  onTap: () {},
                ),
                const WidgetXDivider(),
                WidgetXListTile(
                  title: 'Carol White',
                  subtitle: 'Product Manager',
                  leading: const WidgetXAvatar(
                    initials: 'CW',
                    size: WidgetXAvatarSize.sm,
                  ),
                  trailing: const WidgetXBadge(
                    label: 'Inactive',
                    variant: WidgetXBadgeVariant.neutral,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Timeline
          const SectionHeader(
            title: 'Timeline',
            description: 'Sequential event visualization.',
          ),
          const WidgetXCard(body: WidgetXTimeline(items: _timelineItems)),
          const SizedBox(height: WidgetXSpacing.lg),

          // Accordion
          const SectionHeader(
            title: 'Accordion',
            description: 'Collapsible FAQ / content panels.',
          ),
          const WidgetXAccordion(items: _accordionItems, allowMultiple: false),
          const SizedBox(height: WidgetXSpacing.lg),

          // Data Table
          const SectionHeader(
            title: 'Data Table',
            description: 'Sortable, selectable table for structured data.',
          ),
          WidgetXCard(
            padding: EdgeInsets.zero,
            body: WidgetXDataTable(
              columns: const ['Name', 'Role', 'Status', 'Joined'],
              rows: _tableRows,
              selectedRows: _selectedRows,
              onRowSelected: (i) => setState(() {
                if (_selectedRows.contains(i)) {
                  _selectedRows.remove(i);
                } else {
                  _selectedRows.add(i);
                }
              }),
              onSort: (col, _) {},
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Dividers
          const SectionHeader(title: 'Dividers'),
          const WidgetXDivider(),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXDivider.labeled(label: 'or'),
          const SizedBox(height: WidgetXSpacing.lg),

          // Empty / Error States
          const SectionHeader(title: 'Empty & Error States'),
          const WidgetXEmptyState(
            icon: Icons.inbox_outlined,
            title: 'No results',
            description: 'Try adjusting your search filters.',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXEmptyState(
            isError: true,
            title: 'Something went wrong',
            description: 'Unable to load data. Please try again.',
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          const SectionHeader(title: 'Example Code'),
          const CodeBlock(
            code: '''WidgetXTimeline(
  items: [
    WidgetXTimelineItem(
      title: 'Order placed',
      time: '09:00',
      isCompleted: true,
    ),
    WidgetXTimelineItem(
      title: 'In transit',
      isActive: true,
    ),
  ],
)''',
          ),
      ],
    );
  }
}
