import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  bool _loading = false;
  Set<int> _toggleSelected = {0};

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md, WidgetXSpacing.md,
        WidgetXSpacing.md, WidgetXSpacing.md + bottom,
      ),
        children: [
          const SectionHeader(
            title: 'Variants',
            description:
                'Use the appropriate variant based on action emphasis.',
          ),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: [
              WidgetXButton(
                label: 'Primary',
                variant: WidgetXButtonVariant.primary,
                onPressed: () {},
              ),
              WidgetXButton(
                label: 'Secondary',
                variant: WidgetXButtonVariant.secondary,
                onPressed: () {},
              ),
              WidgetXButton(
                label: 'Outlined',
                variant: WidgetXButtonVariant.outlined,
                onPressed: () {},
              ),
              WidgetXButton(
                label: 'Text',
                variant: WidgetXButtonVariant.text,
                onPressed: () {},
              ),
              WidgetXButton(
                label: 'Destructive',
                variant: WidgetXButtonVariant.destructive,
                onPressed: () {},
              ),
              const WidgetXButton(
                label: 'Disabled',
                variant: WidgetXButtonVariant.primary,
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'States'),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: [
              WidgetXButton(
                label: 'Loading',
                variant: WidgetXButtonVariant.primary,
                isLoading: _loading,
                onPressed: () async {
                  setState(() => _loading = true);
                  await Future<void>.delayed(const Duration(seconds: 2));
                  if (mounted) setState(() => _loading = false);
                },
              ),
              WidgetXButton(
                label: 'With Icon',
                variant: WidgetXButtonVariant.primary,
                leadingIcon: const Icon(Icons.add, size: 18),
                onPressed: () {},
              ),
              WidgetXButton(
                label: 'Full Width',
                variant: WidgetXButtonVariant.outlined,
                isFullWidth: true,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Sizes'),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: WidgetXButtonSize.values
                .map(
                  (s) =>
                      WidgetXButton(label: s.name, size: s, onPressed: () {}),
                )
                .toList(),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Icon Buttons'),
          Wrap(
            spacing: WidgetXSpacing.sm,
            children: [
              WidgetXIconButton(
                icon: Icons.favorite_border,
                semanticLabel: 'Favourite',
                onPressed: () {},
              ),
              WidgetXIconButton(
                icon: Icons.share,
                semanticLabel: 'Share',
                variant: WidgetXIconButtonVariant.filled,
                onPressed: () {},
              ),
              WidgetXIconButton(
                icon: Icons.bookmark_border,
                semanticLabel: 'Bookmark',
                variant: WidgetXIconButtonVariant.outlined,
                onPressed: () {},
              ),
              WidgetXIconButton(
                icon: Icons.edit,
                semanticLabel: 'Edit',
                variant: WidgetXIconButtonVariant.tonal,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Floating Action Buttons
          const SectionHeader(
            title: 'Floating Action Buttons',
            description: 'FABs for primary screen-level actions.',
          ),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              WidgetXFAB(icon: Icons.add, onPressed: () {}),
              WidgetXFAB(
                icon: Icons.add,
                size: WidgetXFABSize.small,
                onPressed: () {},
              ),
              WidgetXFAB(
                icon: Icons.add,
                size: WidgetXFABSize.large,
                onPressed: () {},
              ),
              WidgetXFAB(
                icon: Icons.edit,
                label: 'Create',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Toggle Buttons
          const SectionHeader(
            title: 'Toggle Button Group',
            description:
                'Single-select and multi-select toggle groups.',
          ),
          WidgetXToggleButtonGroup(
            items: const [
              WidgetXToggleItem(label: 'Bold', icon: Icons.format_bold),
              WidgetXToggleItem(label: 'Italic', icon: Icons.format_italic),
              WidgetXToggleItem(
                  label: 'Underline', icon: Icons.format_underline),
            ],
            selectedIndices: _toggleSelected,
            onChanged: (s) => setState(() => _toggleSelected = s),
            allowMultiple: true,
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          WidgetXToggleButtonGroup(
            items: const [
              WidgetXToggleItem(label: 'Day'),
              WidgetXToggleItem(label: 'Week'),
              WidgetXToggleItem(label: 'Month'),
            ],
            selectedIndices: const {1},
            onChanged: (_) {},
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          const SectionHeader(title: 'Example Code'),
          const CodeBlock(
            code: '''// Primary button
WidgetXButton(
  label: 'Continue',
  variant: WidgetXButtonVariant.primary,
  size: WidgetXButtonSize.large,
  onPressed: () {},
)

// Floating Action Button
WidgetXFAB(
  icon: Icons.add,
  label: 'Create',
  onPressed: () {},
)

// Toggle group (multi-select)
WidgetXToggleButtonGroup(
  items: const [
    WidgetXToggleItem(label: 'Bold', icon: Icons.format_bold),
    WidgetXToggleItem(label: 'Italic', icon: Icons.format_italic),
  ],
  selectedIndices: _selected,
  onChanged: (s) => setState(() => _selected = s),
  allowMultiple: true,
)''',
          ),
        ],
      );
  }
}
