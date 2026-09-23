import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

/// Welcome / splash screen shown on first launch before login or onboarding.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _features = [
    _Feature(
      icon: Icons.widgets_outlined,
      title: '50+ Components',
      subtitle: 'Buttons, inputs, cards, charts and much more.',
    ),
    _Feature(
      icon: Icons.palette_outlined,
      title: 'Material 3 Design',
      subtitle: 'Beautiful light & dark themes with accent colors.',
    ),
    _Feature(
      icon: Icons.devices_outlined,
      title: 'Fully Responsive',
      subtitle: 'Mobile, tablet and desktop — all in one codebase.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: WidgetXSpacing.xl),
          child: Column(
            children: [
              const Spacer(),

              // Logo + branding
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(WidgetXRadius.xl),
                ),
                child: Icon(Icons.widgets_outlined,
                    color: cs.onPrimary, size: 44),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scaleXY(
                    begin: 0.6,
                    end: 1.0,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: WidgetXSpacing.lg),

              Text('WidgetX UI',
                  style: tt.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800, letterSpacing: -0.5))
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: WidgetXSpacing.xs),
              Text(
                'Flutter Design System',
                style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              )
                  .animate()
                  .fadeIn(delay: 160.ms, duration: 400.ms),
              const SizedBox(height: WidgetXSpacing.xxxl),

              // Feature list
              ..._features.asMap().entries.map(
                    (e) => _FeatureRow(
                      feature: e.value,
                      delay: 220 + e.key * 80,
                    ),
                  ),

              const Spacer(),

              // CTA buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetXButton(
                    label: 'Get started',
                    onPressed: () => context.go('/templates/auth/login'),
                    variant: WidgetXButtonVariant.primary,
                    isFullWidth: true,
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 350.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: WidgetXSpacing.sm),
                  WidgetXButton(
                    label: 'Explore components',
                    onPressed: () => context.go('/'),
                    variant: WidgetXButtonVariant.outlined,
                    isFullWidth: true,
                  )
                      .animate()
                      .fadeIn(delay: 560.ms, duration: 350.ms)
                      .slideY(begin: 0.2, end: 0),
                ],
              ),
              const SizedBox(height: WidgetXSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature, required this.delay});
  final _Feature feature;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: WidgetXSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(WidgetXRadius.md),
            ),
            child: Icon(feature.icon,
                color: cs.onPrimaryContainer, size: 22),
          ),
          const SizedBox(width: WidgetXSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feature.title,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(feature.subtitle,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 350.ms).slideX(begin: -0.1, end: 0);
  }
}
