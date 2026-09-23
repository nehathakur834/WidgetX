import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../../catalog/template_app_bar.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  static const _skills = [
    _Skill('Flutter', 0.95),
    _Skill('Dart', 0.92),
    _Skill('Firebase', 0.80),
    _Skill('React', 0.70),
    _Skill('Node.js', 0.68),
    _Skill('GraphQL', 0.60),
    _Skill('Figma', 0.75),
    _Skill('Swift', 0.55),
    _Skill('Kotlin', 0.58),
    _Skill('Git', 0.90),
  ];

  static const _projects = [
    _Project(
      name: 'WidgetX UI',
      description:
          'A comprehensive Flutter design system with 50+ components, dark mode support, and accessibility-first design.',
      tags: ['Flutter', 'Dart', 'Open Source'],
    ),
    _Project(
      name: 'Finance Tracker',
      description:
          'Cross-platform mobile app for personal finance management with real-time syncing and smart analytics.',
      tags: ['Flutter', 'Firebase', 'Riverpod'],
    ),
    _Project(
      name: 'Social Dashboard',
      description:
          'Analytics dashboard for social media managers with multi-platform insights and automated reporting.',
      tags: ['React', 'Node.js', 'GraphQL'],
    ),
  ];

  static const _experience = [
    _Experience(
      role: 'Senior Flutter Developer',
      company: 'Tech Startup Inc.',
      period: '2022 – Present',
    ),
    _Experience(
      role: 'Mobile Developer',
      company: 'Digital Agency',
      period: '2020 – 2022',
    ),
    _Experience(
      role: 'Junior Developer',
      company: 'Freelance',
      period: '2018 – 2020',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Portfolio',
        favoriteId: 'tpl-portfolio',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero section
            Container(
              padding: const EdgeInsets.all(WidgetXSpacing.xxl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cs.primaryContainer,
                    cs.secondaryContainer,
                  ],
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: cs.primary,
                    child: Icon(Icons.person_outline,
                        size: 44, color: cs.onPrimary),
                  ),
                  const SizedBox(height: WidgetXSpacing.md),
                  Text('Alex Johnson',
                      style: tt.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Text('Flutter Developer & UI/UX Designer',
                      style: tt.bodyLarge
                          ?.copyWith(color: cs.onSurfaceVariant)),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Text('San Francisco, CA',
                      style: tt.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant)),
                  const SizedBox(height: WidgetXSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetXButton(
                        label: 'Contact Me',
                        onPressed: () {},
                        variant: WidgetXButtonVariant.primary,
                      ),
                      const SizedBox(width: WidgetXSpacing.md),
                      WidgetXButton(
                        label: 'Download CV',
                        onPressed: () {},
                        variant: WidgetXButtonVariant.outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  Row(
                    children: [
                      Expanded(
                          child: _StatItem(value: '5+', label: 'Years Exp.')),
                      Expanded(
                          child: _StatItem(value: '40+', label: 'Projects')),
                      Expanded(
                          child: _StatItem(value: '20+', label: 'Clients')),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  // About
                  Text('About Me',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text(
                    'Passionate Flutter developer with 5+ years of experience building beautiful, performant cross-platform apps. '
                    'I specialize in Flutter, Dart, and Firebase, with a strong eye for UI/UX design. '
                    'I love creating design systems and tools that help other developers ship faster.',
                    style: tt.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  // Skills
                  Text('Skills',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  ..._skills.map(
                    (skill) => Padding(
                      padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                      child: _SkillBar(skill: skill),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  // Projects
                  Text('Projects',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  ..._projects.map(
                    (p) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: WidgetXSpacing.md),
                      child: WidgetXCard(
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerHighest,
                                borderRadius:
                                    BorderRadius.circular(WidgetXRadius.sm),
                              ),
                              child: Center(
                                child: Icon(Icons.code,
                                    size: 32, color: cs.outlineVariant),
                              ),
                            ),
                            const SizedBox(height: WidgetXSpacing.sm),
                            Text(p.name,
                                style: tt.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: WidgetXSpacing.xs),
                            Text(p.description,
                                style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant)),
                            const SizedBox(height: WidgetXSpacing.sm),
                            Wrap(
                              spacing: 6,
                              children: p.tags
                                  .map((t) => Chip(
                                        label: Text(t,
                                            style: tt.labelSmall),
                                        padding: EdgeInsets.zero,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity:
                                            VisualDensity.compact,
                                        backgroundColor:
                                            cs.secondaryContainer,
                                        labelStyle: TextStyle(
                                            color: cs.onSecondaryContainer),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  // Experience
                  Text('Experience',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  ..._experience.asMap().entries.map(
                        (e) => _ExperienceItem(
                          experience: e.value,
                          isLast: e.key == _experience.length - 1,
                        ),
                      ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  // Contact
                  Text('Get In Touch',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  WidgetXCard(
                    body: Column(
                      children: [
                        _ContactRow(
                            icon: Icons.email_outlined,
                            label: 'alex@example.com'),
                        _ContactRow(
                            icon: Icons.language_outlined,
                            label: 'widgetx.dev'),
                        _ContactRow(
                            icon: Icons.code_outlined,
                            label: 'github.com/alexj'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Project {
  const _Project(
      {required this.name,
      required this.description,
      required this.tags});
  final String name, description;
  final List<String> tags;
}

class _Experience {
  const _Experience(
      {required this.role,
      required this.company,
      required this.period});
  final String role, company, period;
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});
  final String value, label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return WidgetXCard(
      body: Column(
        children: [
          Text(value,
              style: tt.headlineMedium
                  ?.copyWith(color: cs.primary, fontWeight: FontWeight.w700)),
          Text(label,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem(
      {required this.experience, required this.isLast});
  final _Experience experience;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 48,
                color: cs.outlineVariant,
              ),
          ],
        ),
        const SizedBox(width: WidgetXSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: WidgetXSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(experience.role,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(experience.company,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
                Text(experience.period,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WidgetXSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: WidgetXSpacing.md),
          Text(label, style: tt.bodyMedium),
        ],
      ),
    );
  }
}

class _Skill {
  const _Skill(this.name, this.level);
  final String name;
  final double level; // 0.0 – 1.0
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.skill});
  final _Skill skill;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final pct = '${(skill.level * 100).round()}%';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(skill.name,
                  style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            ),
            Text(pct,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: skill.level,
            minHeight: 8,
            backgroundColor: cs.surfaceContainerHighest,
            color: cs.primary,
          ),
        ),
      ],
    );
  }
}

