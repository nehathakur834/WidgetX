import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  int _selectedPeriod = 1; // 0=Day, 1=Month, 2=Year

  // Day data
  static const _revenueDay = [
    WidgetXChartPoint(label: '8am', value: 12),
    WidgetXChartPoint(label: '10am', value: 28),
    WidgetXChartPoint(label: '12pm', value: 45),
    WidgetXChartPoint(label: '2pm', value: 31),
    WidgetXChartPoint(label: '4pm', value: 52),
    WidgetXChartPoint(label: '6pm', value: 38),
    WidgetXChartPoint(label: '8pm', value: 22),
  ];
  // Month data
  static const _revenueMonth = [
    WidgetXChartPoint(label: 'Jan', value: 52),
    WidgetXChartPoint(label: 'Feb', value: 78),
    WidgetXChartPoint(label: 'Mar', value: 61),
    WidgetXChartPoint(label: 'Apr', value: 94),
    WidgetXChartPoint(label: 'May', value: 88),
    WidgetXChartPoint(label: 'Jun', value: 110),
    WidgetXChartPoint(label: 'Jul', value: 97),
    WidgetXChartPoint(label: 'Aug', value: 125),
  ];
  // Year data
  static const _revenueYear = [
    WidgetXChartPoint(label: '2020', value: 380),
    WidgetXChartPoint(label: '2021', value: 520),
    WidgetXChartPoint(label: '2022', value: 690),
    WidgetXChartPoint(label: '2023', value: 870),
    WidgetXChartPoint(label: '2024', value: 1050),
    WidgetXChartPoint(label: '2025', value: 1240),
  ];

  static const _usersDayData = [
    WidgetXChartPoint(label: '8am', value: 80),
    WidgetXChartPoint(label: '10am', value: 230),
    WidgetXChartPoint(label: '12pm', value: 410),
    WidgetXChartPoint(label: '2pm', value: 350),
    WidgetXChartPoint(label: '4pm', value: 520),
    WidgetXChartPoint(label: '6pm', value: 380),
    WidgetXChartPoint(label: '8pm', value: 210),
  ];
  static const _usersData = [
    WidgetXChartPoint(label: 'Mon', value: 1200),
    WidgetXChartPoint(label: 'Tue', value: 1850),
    WidgetXChartPoint(label: 'Wed', value: 1600),
    WidgetXChartPoint(label: 'Thu', value: 2100),
    WidgetXChartPoint(label: 'Fri', value: 1900),
    WidgetXChartPoint(label: 'Sat', value: 980),
    WidgetXChartPoint(label: 'Sun', value: 760),
  ];
  static const _usersYearData = [
    WidgetXChartPoint(label: '2020', value: 3200),
    WidgetXChartPoint(label: '2021', value: 5800),
    WidgetXChartPoint(label: '2022', value: 8900),
    WidgetXChartPoint(label: '2023', value: 12400),
    WidgetXChartPoint(label: '2024', value: 18600),
    WidgetXChartPoint(label: '2025', value: 24100),
  ];

  List<WidgetXChartPoint> get _revenueData => switch (_selectedPeriod) {
    0 => _revenueDay,
    2 => _revenueYear,
    _ => _revenueMonth,
  };

  List<WidgetXChartPoint> get _currentUsersData => switch (_selectedPeriod) {
    0 => _usersDayData,
    2 => _usersYearData,
    _ => _usersData,
  };

  String get _periodLabel => switch (_selectedPeriod) {
    0 => 'Today',
    2 => 'This Year',
    _ => 'This Month',
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Analytics Dashboard',
        favoriteId: 'tpl-dashboard',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(WidgetXSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Analytics',
                          style: tt.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      Text(_periodLabel,
                          style: tt.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                WidgetXButton(
                  label: 'Export',
                  onPressed: () {},
                  variant: WidgetXButtonVariant.outlined,
                  leadingIcon: const Icon(Icons.download_outlined, size: 18),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 350.ms)
                .slideY(begin: -0.1, end: 0),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Period toggle ────────────────────────────────────────────────
            WidgetXSegmentedControl(
              segments: const ['Day', 'Month', 'Year'],
              selectedIndex: _selectedPeriod,
              onChanged: (i) => setState(() => _selectedPeriod = i),
            )
                .animate()
                .fadeIn(delay: 50.ms, duration: 300.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Stat cards ───────────────────────────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth > 600 ? 4 : 2;
                final itemWidth =
                    (constraints.maxWidth - (cols - 1) * WidgetXSpacing.md) /
                        cols;
                return Wrap(
                  spacing: WidgetXSpacing.md,
                  runSpacing: WidgetXSpacing.md,
                  children: [
                    _StatCard(
                      width: itemWidth,
                      label: 'Total Revenue',
                      value: '\$84,231',
                      change: '+12.5%',
                      isPositive: true,
                      icon: Icons.attach_money,
                    ),
                    _StatCard(
                      width: itemWidth,
                      label: 'Active Users',
                      value: '12,847',
                      change: '+8.2%',
                      isPositive: true,
                      icon: Icons.people_outline,
                    ),
                    _StatCard(
                      width: itemWidth,
                      label: 'Orders',
                      value: '3,291',
                      change: '-2.1%',
                      isPositive: false,
                      icon: Icons.shopping_bag_outlined,
                    ),
                    _StatCard(
                      width: itemWidth,
                      label: 'Conversion',
                      value: '3.24%',
                      change: '+0.4%',
                      isPositive: true,
                      icon: Icons.trending_up,
                    ),
                  ],
                );
              },
            )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.08, end: 0),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Revenue bar chart (WidgetXBarChart) ──────────────────────────
            WidgetXCard(
              body: WidgetXBarChart(
                data: _revenueData,
                title: 'Revenue (\$k) — $_periodLabel',
                height: 200,
              ),
            )
                .animate()
                .fadeIn(delay: 180.ms, duration: 400.ms),
            const SizedBox(height: WidgetXSpacing.lg),

            // ── Users area chart ─────────────────────────────────────────────
            WidgetXCard(
              body: WidgetXAreaChart(
                data: _currentUsersData,
                title: 'Active Users — $_periodLabel',
                height: 180,
              ),
            )
                .animate()
                .fadeIn(delay: 220.ms, duration: 400.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Quick KPI row ────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: WidgetXCard(
                    body: Column(
                      children: [
                        WidgetXProgressChart(
                          value: 0.72,
                          label: 'Goal',
                          size: 88,
                        ),
                        const SizedBox(height: WidgetXSpacing.xs),
                        Text('Monthly goal',
                            style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: WidgetXSpacing.md),
                Expanded(
                  child: WidgetXCard(
                    body: Column(
                      children: [
                        WidgetXProgressChart(
                          value: 0.54,
                          label: 'NPS',
                          size: 88,
                        ),
                        const SizedBox(height: WidgetXSpacing.xs),
                        Text('Customer score',
                            style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: WidgetXSpacing.md),
                Expanded(
                  child: WidgetXCard(
                    body: Column(
                      children: [
                        WidgetXProgressChart(
                          value: 0.91,
                          label: 'SLA',
                          size: 88,
                        ),
                        const SizedBox(height: WidgetXSpacing.xs),
                        Text('Uptime',
                            style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 260.ms, duration: 350.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Recent transactions ──────────────────────────────────────────
            Text('Recent Transactions',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: WidgetXSpacing.md),
            ...MockData.transactions.take(4).map(
                  (t) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                    child: WidgetXCard(
                      body: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer,
                              borderRadius:
                                  BorderRadius.circular(WidgetXRadius.md),
                            ),
                            child: Icon(t.icon,
                                size: 20, color: cs.onSecondaryContainer),
                          ),
                          const SizedBox(width: WidgetXSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.title,
                                    style: tt.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500)),
                                Text(t.date,
                                    style: tt.bodySmall?.copyWith(
                                        color: cs.onSurfaceVariant)),
                              ],
                            ),
                          ),
                          Text(
                            '${t.isCredit ? '+' : '-'}\$${t.amount.toStringAsFixed(2)}',
                            style: tt.bodyMedium?.copyWith(
                              color: t.isCredit
                                  ? Colors.green.shade600
                                  : cs.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

// ── Stat card ──────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.width,
    required this.label,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
  });
  final double width;
  final String label, value, change;
  final bool isPositive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SizedBox(
      width: width,
      child: WidgetXCard(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(label,
                      style: tt.bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant)),
                ),
                Icon(icon, size: 18, color: cs.primary),
              ],
            ),
            const SizedBox(height: WidgetXSpacing.sm),
            Text(value,
                style: tt.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: WidgetXSpacing.xs),
            Row(
              children: [
                Icon(
                  isPositive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 12,
                  color: isPositive ? Colors.green.shade600 : cs.error,
                ),
                const SizedBox(width: 2),
                Text(
                  change,
                  style: tt.bodySmall?.copyWith(
                    color: isPositive ? Colors.green.shade600 : cs.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
