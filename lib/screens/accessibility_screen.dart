import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';
import '../catalog/favorite_button.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool _switch = false;
  bool _checkbox = false;
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const WidgetXAppBar(
        title: 'Accessibility',
        subtitle: 'WCAG 2.1 AA compliance examples',
        actions: [FavoriteButton(id: 'accessibility')],
      ),
      body: ListView(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        children: [
          // Semantics
          const SectionHeader(
            title: 'Semantic Labels',
            description:
                'Every interactive element carries a meaningful semantic label '
                'readable by screen readers.',
          ),
          WidgetXCard(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Screen reader announces:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: WidgetXSpacing.sm),
                const _SemanticRow(
                  label: 'WidgetXButton',
                  announced: '"Continue, button"',
                ),
                const _SemanticRow(
                  label: 'WidgetXCheckbox',
                  announced: '"Accept terms, checkbox, checked"',
                ),
                const _SemanticRow(
                  label: 'WidgetXSwitch',
                  announced: '"Dark mode, toggle button, on"',
                ),
                const _SemanticRow(
                  label: 'WidgetXTextField',
                  announced: '"Email address, text field"',
                ),
                const _SemanticRow(
                  label: 'WidgetXBanner',
                  announced: '"Warning: session expiring soon, live region"',
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Minimum touch targets
          const SectionHeader(
            title: 'Minimum Touch Targets',
            description:
                'All interactive elements meet the 44×44px minimum touch '
                'target requirement (WCAG 2.5.8).',
          ),
          const WidgetXCard(
            body: Column(
              children: [
                _TouchTargetRow(label: 'WidgetXButton (medium)', height: 44),
                SizedBox(height: WidgetXSpacing.xs),
                _TouchTargetRow(label: 'WidgetXIconButton', height: 48),
                SizedBox(height: WidgetXSpacing.xs),
                _TouchTargetRow(label: 'WidgetXCheckbox row', height: 44),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Focus indicators
          const SectionHeader(
            title: 'Focus Indicators',
            description:
                'Use Tab / keyboard to navigate. Each element shows a '
                'visible focus ring (WCAG 2.4.7).',
          ),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: [
              WidgetXButton(label: 'Focusable button', onPressed: () {}),
              WidgetXIconButton(
                icon: Icons.favorite_border,
                semanticLabel: 'Add to favourites',
                variant: WidgetXIconButtonVariant.outlined,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Text scaling
          const SectionHeader(
            title: 'Text Scaling',
            description:
                'All text uses relative sizes that respond to system '
                'font size settings (WCAG 1.4.4).',
          ),
          WidgetXCard(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: Text(
                    'Scale 1.0× — normal',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.5)),
                  child: Text(
                    'Scale 1.5× — large',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(2.0)),
                  child: Text(
                    'Scale 2.0× — extra-large',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Color contrast
          const SectionHeader(
            title: 'Color Contrast',
            description:
                'Text and UI components meet WCAG AA contrast ratio '
                'requirements (4.5:1 for normal text, 3:1 for large).',
          ),
          WidgetXCard(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContrastRow(
                  fg: cs.onPrimary,
                  bg: cs.primary,
                  label: 'Primary button text',
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                _ContrastRow(
                  fg: cs.onSurface,
                  bg: cs.surface,
                  label: 'Body text',
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                _ContrastRow(fg: cs.onError, bg: cs.error, label: 'Error text'),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Live region demo
          const SectionHeader(
            title: 'Live Regions',
            description:
                'Banners use liveRegion: true so screen readers '
                'announce status changes automatically.',
          ),
          WidgetXBanner(
            variant: WidgetXBannerVariant.info,
            message:
                'This banner is announced by screen readers when it appears.',
            onDismiss: () {},
          ),
          const SizedBox(height: WidgetXSpacing.sm),

          // Interactive inputs
          const SectionHeader(title: 'Accessible Inputs'),
          WidgetXCheckbox(
            label: 'I agree to the Terms of Service',
            value: _checkbox,
            onChanged: (v) => setState(() => _checkbox = v ?? false),
            semanticLabel: 'Agree to terms',
          ),
          const SizedBox(height: WidgetXSpacing.xs),
          WidgetXSwitch(
            label: 'Enable notifications',
            value: _switch,
            onChanged: (v) => setState(() => _switch = v),
            semanticLabel: 'Enable notifications toggle',
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          const SectionHeader(title: 'Accessibility API'),
          const CodeBlock(
            code: '''// All public widgets accept semanticLabel
WidgetXButton(
  label: 'Continue',
  semanticLabel: 'Continue to checkout',
  onPressed: () {},
)

// Banners announce themselves as live regions
WidgetXBanner(
  variant: WidgetXBannerVariant.error,
  message: 'Payment failed.',
  semanticLabel: 'Error: Payment failed.',
)

// Focus utilities
WidgetXFocusUtils.requestFocusNextFrame(myFocusNode);''',
          ),
        ],
      ),
    );
  }
}

class _SemanticRow extends StatelessWidget {
  const _SemanticRow({required this.label, required this.announced});
  final String label;
  final String announced;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WidgetXSpacing.xxs),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                color: cs.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              announced,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TouchTargetRow extends StatelessWidget {
  const _TouchTargetRow({required this.label, required this.height});
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.sm,
            vertical: WidgetXSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${height.toInt()}px',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: cs.onPrimaryContainer),
          ),
        ),
      ],
    );
  }
}

class _ContrastRow extends StatelessWidget {
  const _ContrastRow({required this.fg, required this.bg, required this.label});
  final Color fg;
  final Color bg;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 28,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            'Aa',
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: WidgetXSpacing.sm),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
