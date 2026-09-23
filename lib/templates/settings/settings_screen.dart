import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../providers/theme_provider.dart';
import '../../../catalog/template_app_bar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final themeMode = ref.watch(themeModeProvider);
    final accentIndex = ref.watch(accentIndexProvider);

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Settings',
        favoriteId: 'tpl-settings',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(WidgetXSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings',
                style: tt.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: WidgetXSpacing.xl),

            // Account section
            const _SectionHeader(title: 'Account'),
            WidgetXCard(
              body: Column(
                children: [
                  _SettingsRow(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    subtitle: 'Alex Johnson',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _SettingsRow(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    subtitle: 'alex@example.com',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _SettingsRow(
                    icon: Icons.lock_outline,
                    title: 'Password',
                    subtitle: 'Last changed 3 months ago',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Appearance section
            const _SectionHeader(title: 'Appearance'),
            WidgetXCard(
              body: Column(
                children: [
                  // Theme
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: WidgetXSpacing.xs),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            borderRadius:
                                BorderRadius.circular(WidgetXRadius.sm),
                          ),
                          child: Icon(Icons.palette_outlined,
                              size: 18, color: cs.onPrimaryContainer),
                        ),
                        const SizedBox(width: WidgetXSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Theme', style: tt.bodyMedium),
                              Text('Choose light, dark, or system',
                                  style: tt.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        DropdownButton<ThemeMode>(
                          value: themeMode,
                          underline: const SizedBox.shrink(),
                          items: const [
                            DropdownMenuItem(
                                value: ThemeMode.light,
                                child: Text('Light')),
                            DropdownMenuItem(
                                value: ThemeMode.dark,
                                child: Text('Dark')),
                            DropdownMenuItem(
                                value: ThemeMode.system,
                                child: Text('System')),
                          ],
                          onChanged: (m) {
                            if (m != null) {
                              ref
                                  .read(themeModeProvider.notifier)
                                  .setMode(m);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Accent color
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: WidgetXSpacing.xs),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: cs.primaryContainer,
                                borderRadius:
                                    BorderRadius.circular(WidgetXRadius.sm),
                              ),
                              child: Icon(Icons.color_lens_outlined,
                                  size: 18, color: cs.onPrimaryContainer),
                            ),
                            const SizedBox(width: WidgetXSpacing.md),
                            Expanded(
                              child: Text('Accent Color',
                                  style: tt.bodyMedium),
                            ),
                          ],
                        ),
                        const SizedBox(height: WidgetXSpacing.sm),
                        Wrap(
                          spacing: WidgetXSpacing.sm,
                          children: [
                            for (var i = 0;
                                i < AccentIndexNotifier.accentColors.length;
                                i++)
                              GestureDetector(
                                onTap: () => ref
                                    .read(accentIndexProvider.notifier)
                                    .setIndex(i),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color:
                                        AccentIndexNotifier.accentColors[i],
                                    shape: BoxShape.circle,
                                    border: i == accentIndex
                                        ? Border.all(
                                            color: cs.onSurface, width: 2)
                                        : null,
                                  ),
                                  child: i == accentIndex
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 16)
                                      : null,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Notifications section
            const _SectionHeader(title: 'Notifications'),
            WidgetXCard(
              body: Column(
                children: [
                  _ToggleRow(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Receive app notifications',
                    value: true,
                    onChanged: (_) {},
                  ),
                  const Divider(height: 1),
                  _ToggleRow(
                    icon: Icons.email_outlined,
                    title: 'Email Updates',
                    subtitle: 'Weekly digest and news',
                    value: false,
                    onChanged: (_) {},
                  ),
                  const Divider(height: 1),
                  _ToggleRow(
                    icon: Icons.campaign_outlined,
                    title: 'Marketing',
                    subtitle: 'Promotional emails',
                    value: false,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // About section
            const _SectionHeader(title: 'About'),
            WidgetXCard(
              body: Column(
                children: [
                  const _SettingsRow(
                    icon: Icons.info_outline,
                    title: 'Version',
                    subtitle: '1.0.0 (Build 100)',
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  _SettingsRow(
                    icon: Icons.description_outlined,
                    title: 'Privacy Policy',
                    trailing: const Icon(Icons.open_in_new, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _SettingsRow(
                    icon: Icons.gavel_outlined,
                    title: 'Terms of Service',
                    trailing: const Icon(Icons.open_in_new, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Sign out
            WidgetXButton(
              label: 'Sign Out',
              onPressed: () {},
              variant: WidgetXButtonVariant.destructive,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(
          bottom: WidgetXSpacing.sm, left: WidgetXSpacing.xs),
      child: Text(
        title.toUpperCase(),
        style: tt.labelSmall?.copyWith(
          color: cs.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: WidgetXSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(WidgetXRadius.sm),
              ),
              child: Icon(icon, size: 18, color: cs.onPrimaryContainer),
            ),
            const SizedBox(width: WidgetXSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: tt.bodyMedium),
                  if (subtitle != null)
                    Text(subtitle!,
                        style: tt.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
            if (trailing != null)
              IconTheme(
                data: IconThemeData(
                    color: cs.onSurfaceVariant, size: 18),
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatefulWidget {
  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<_ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<_ToggleRow> {
  late bool _value = widget.value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WidgetXSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(WidgetXRadius.sm),
            ),
            child: Icon(widget.icon,
                size: 18, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: WidgetXSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: tt.bodyMedium),
                Text(widget.subtitle,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          Switch(
            value: _value,
            onChanged: (v) {
              setState(() => _value = v);
              widget.onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}
