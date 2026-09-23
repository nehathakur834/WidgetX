import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/device_preview_provider.dart';

/// A toggle control for the device preview mode.
///
/// Shows three buttons: Mobile, Tablet, Desktop.
/// Intended for use in the top bar of the showcase.
class DevicePreviewToggle extends ConsumerWidget {
  const DevicePreviewToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(previewDeviceProvider);
    final cs = Theme.of(context).colorScheme;

    return Tooltip(
      message: 'Device preview',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SegmentButton(
              icon: Icons.smartphone,
              label: 'Mobile',
              selected: current == PreviewDevice.mobile,
              isFirst: true,
              onTap: () => ref.read(previewDeviceProvider.notifier).state =
                  PreviewDevice.mobile,
            ),
            _SegmentButton(
              icon: Icons.tablet_android,
              label: 'Tablet',
              selected: current == PreviewDevice.tablet,
              onTap: () => ref.read(previewDeviceProvider.notifier).state =
                  PreviewDevice.tablet,
            ),
            _SegmentButton(
              icon: Icons.laptop,
              label: 'Desktop',
              selected: current == PreviewDevice.desktop,
              isLast: true,
              onTap: () => ref.read(previewDeviceProvider.notifier).state =
                  PreviewDevice.desktop,
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.icon,
    required this.label,
    required this.selected,
    this.isFirst = false,
    this.isLast = false,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.horizontal(
      left: isFirst ? const Radius.circular(7) : Radius.zero,
      right: isLast ? const Radius.circular(7) : Radius.zero,
    );
    return Semantics(
      label: '$label device preview',
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? cs.primaryContainer : Colors.transparent,
            borderRadius: radius,
          ),
          child: Icon(
            icon,
            size: 16,
            color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            semanticLabel: label,
          ),
        ),
      ),
    );
  }
}

/// Wraps [child] in a simulated device frame based on [PreviewDevice].
///
/// On [PreviewDevice.mobile] → 390×844 portrait constraint.
/// On [PreviewDevice.tablet] → 768×1024 portrait constraint.
/// On [PreviewDevice.desktop] → unconstrained (fills available space).
class DevicePreviewFrame extends ConsumerWidget {
  const DevicePreviewFrame({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref.watch(previewDeviceProvider);

    if (device == PreviewDevice.desktop) {
      return child;
    }

    final (maxW, maxH) = switch (device) {
      PreviewDevice.mobile => (390.0, 844.0),
      PreviewDevice.tablet => (768.0, 1024.0),
      PreviewDevice.desktop => (double.infinity, double.infinity),
    };

    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

// ── Responsive overlay badge ─────────────────────────────────────────────────

/// Shows the current breakpoint name in a small overlay in the corner.
/// Useful during development to verify responsive breakpoints.
class BreakpointBadge extends StatelessWidget {
  const BreakpointBadge({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final label = switch (true) {
      _ when width < 600 => 'Mobile',
      _ when width < 1024 => 'Tablet',
      _ => 'Desktop',
    };
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 8,
          right: 8,
          child: _BreakpointChip(label: label),
        ),
      ],
    );
  }
}

class _BreakpointChip extends StatelessWidget {
  const _BreakpointChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cs.inverseSurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.onInverseSurface,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
