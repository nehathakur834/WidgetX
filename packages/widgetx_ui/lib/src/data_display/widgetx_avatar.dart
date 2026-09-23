import 'package:flutter/material.dart';

/// Avatar size.
enum WidgetXAvatarSize { xs, sm, md, lg, xl }

/// A circular avatar following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXAvatar(initials: 'JD')
/// WidgetXAvatar(imageUrl: 'https://...')
/// ```
class WidgetXAvatar extends StatelessWidget {
  const WidgetXAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = WidgetXAvatarSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    this.onTap,
  }) : assert(imageUrl != null || initials != null || icon != null,
            'Provide imageUrl, initials, or icon');

  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final WidgetXAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;
  final VoidCallback? onTap;

  double get _diameter {
    return switch (size) {
      WidgetXAvatarSize.xs => 24,
      WidgetXAvatarSize.sm => 32,
      WidgetXAvatarSize.md => 40,
      WidgetXAvatarSize.lg => 56,
      WidgetXAvatarSize.xl => 80,
    };
  }

  double get _fontSize {
    return switch (size) {
      WidgetXAvatarSize.xs => 10,
      WidgetXAvatarSize.sm => 13,
      WidgetXAvatarSize.md => 16,
      WidgetXAvatarSize.lg => 22,
      WidgetXAvatarSize.xl => 32,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? cs.primaryContainer;
    final fg = foregroundColor ?? cs.onPrimaryContainer;

    Widget content;
    if (imageUrl != null) {
      content = CircleAvatar(
        radius: _diameter / 2,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: bg,
      );
    } else if (initials != null) {
      content = CircleAvatar(
        radius: _diameter / 2,
        backgroundColor: bg,
        child: Text(
          initials!,
          style: TextStyle(
              color: fg, fontSize: _fontSize, fontWeight: FontWeight.w600),
        ),
      );
    } else {
      content = CircleAvatar(
        radius: _diameter / 2,
        backgroundColor: bg,
        child: Icon(icon, color: fg, size: _diameter * 0.5),
      );
    }

    return Semantics(
      label: semanticLabel ?? initials ?? 'Avatar',
      child: GestureDetector(
        onTap: onTap,
        child: content,
      ),
    );
  }
}

/// Overlapping row of [WidgetXAvatar]s.
class WidgetXAvatarGroup extends StatelessWidget {
  const WidgetXAvatarGroup({
    super.key,
    required this.avatars,
    this.maxShown = 4,
    this.size = WidgetXAvatarSize.md,
    this.overlap = 12.0,
    this.semanticLabel,
  });

  final List<WidgetXAvatar> avatars;
  final int maxShown;
  final WidgetXAvatarSize size;
  final double overlap;
  final String? semanticLabel;

  double get _diameter {
    return switch (size) {
      WidgetXAvatarSize.xs => 24,
      WidgetXAvatarSize.sm => 32,
      WidgetXAvatarSize.md => 40,
      WidgetXAvatarSize.lg => 56,
      WidgetXAvatarSize.xl => 80,
    };
  }

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(maxShown).toList();
    final extra = avatars.length - maxShown;

    return Semantics(
      label: semanticLabel ?? '${avatars.length} avatars',
      child: SizedBox(
        height: _diameter,
        width: _diameter + (shown.length - 1) * (_diameter - overlap),
        child: Stack(
          children: [
            for (var i = 0; i < shown.length; i++)
              Positioned(
                left: i * (_diameter - overlap),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  child: shown[i],
                ),
              ),
            if (extra > 0)
              Positioned(
                left: shown.length * (_diameter - overlap),
                child: CircleAvatar(
                  radius: _diameter / 2,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Text('+$extra',
                      style: TextStyle(fontSize: _diameter * 0.25)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
