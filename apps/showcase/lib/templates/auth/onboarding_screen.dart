import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPage(
      icon: Icons.widgets_outlined,
      title: 'Beautiful Components',
      description:
          'Access 50+ production-ready Flutter components built with Material 3 design principles.',
    ),
    _OnboardingPage(
      icon: Icons.palette_outlined,
      title: 'Fully Themeable',
      description:
          'Customize every pixel with dynamic color support, dark mode, and flexible design tokens.',
    ),
    _OnboardingPage(
      icon: Icons.rocket_launch_outlined,
      title: 'Ship Faster',
      description:
          'Jump-start your next Flutter project with ready-made templates and a cohesive design system.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Skip'),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _OnboardingPageView(page: _pages[i]),
              ),
            ),

            // Indicators + CTA
            Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < _pages.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4),
                          width: i == _currentPage ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: i == _currentPage
                                ? cs.primary
                                : cs.outlineVariant,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  WidgetXButton(
                    label: isLast ? 'Get Started' : 'Next',
                    onPressed: _next,
                    variant: WidgetXButtonVariant.primary,
                    isFullWidth: true,
                  ),
                  if (!isLast) ...[
                    const SizedBox(height: WidgetXSpacing.sm),
                    Text(
                      '${_currentPage + 1} of ${_pages.length}',
                      style: tt.bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage(
      {required this.icon,
      required this.title,
      required this.description});
  final IconData icon;
  final String title, description;
}

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView({required this.page});
  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(WidgetXSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(WidgetXRadius.xxl),
            ),
            child: Icon(page.icon, size: 56, color: cs.onPrimaryContainer),
          ),
          const SizedBox(height: WidgetXSpacing.xxl),
          Text(
            page.title,
            style:
                tt.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: WidgetXSpacing.md),
          Text(
            page.description,
            style:
                tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
