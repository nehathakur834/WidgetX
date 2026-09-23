import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  double _progress = 0.72;

  static const _monthlyRevenue = [
    WidgetXChartPoint(label: 'Jan', value: 52),
    WidgetXChartPoint(label: 'Feb', value: 78),
    WidgetXChartPoint(label: 'Mar', value: 61),
    WidgetXChartPoint(label: 'Apr', value: 94),
    WidgetXChartPoint(label: 'May', value: 88),
    WidgetXChartPoint(label: 'Jun', value: 110),
    WidgetXChartPoint(label: 'Jul', value: 97),
    WidgetXChartPoint(label: 'Aug', value: 125),
  ];

  static const _weeklyUsers = [
    WidgetXChartPoint(label: 'Mon', value: 120),
    WidgetXChartPoint(label: 'Tue', value: 180),
    WidgetXChartPoint(label: 'Wed', value: 155),
    WidgetXChartPoint(label: 'Thu', value: 210),
    WidgetXChartPoint(label: 'Fri', value: 190),
    WidgetXChartPoint(label: 'Sat', value: 95),
    WidgetXChartPoint(label: 'Sun', value: 75),
  ];

  static const _expenses = [
    WidgetXChartPoint(label: 'Housing', value: 35),
    WidgetXChartPoint(label: 'Food', value: 22),
    WidgetXChartPoint(label: 'Transport', value: 15),
    WidgetXChartPoint(label: 'Health', value: 12),
    WidgetXChartPoint(label: 'Other', value: 16),
  ];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md, WidgetXSpacing.md,
        WidgetXSpacing.md, WidgetXSpacing.md + bottom,
      ),
        children: [
          // Bar Chart
          const SectionHeader(
            title: 'Bar Chart',
            description:
                'Animated bars with grid lines and axis labels. '
                'Ideal for comparing discrete values.',
          ),
          WidgetXCard(
            body: WidgetXBarChart(
              data: _monthlyRevenue,
              title: 'Monthly Revenue (\$k)',
              height: 200,
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Line Chart
          const SectionHeader(
            title: 'Line Chart',
            description:
                'Smooth animated line with dot markers. '
                'Best for showing trends over time.',
          ),
          WidgetXCard(
            body: WidgetXLineChart(
              data: _weeklyUsers,
              title: 'Weekly Active Users',
              height: 200,
              fill: false,
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Area Chart
          const SectionHeader(
            title: 'Area Chart',
            description:
                'Line chart with a filled area beneath — '
                'emphasises volume and cumulative data.',
          ),
          WidgetXCard(
            body: WidgetXAreaChart(
              data: _weeklyUsers,
              title: 'Weekly Active Users (Area)',
              height: 200,
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Pie / Donut Chart
          const SectionHeader(
            title: 'Pie / Donut Chart',
            description:
                'Part-of-whole relationships with a legend. '
                'Toggle donut mode via the `donut` property.',
          ),
          WidgetXCard(
            body: const WidgetXPieChart(
              segments: _expenses,
              title: 'Expense Breakdown',
              size: 160,
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Progress Charts
          const SectionHeader(
            title: 'Radial Progress Charts',
            description:
                'Circular gauges for completion percentages, scores, '
                'and KPIs.',
          ),
          WidgetXCard(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: WidgetXSpacing.xl,
                  runSpacing: WidgetXSpacing.lg,
                  children: [
                    WidgetXProgressChart(
                      value: _progress,
                      label: 'Completion',
                      size: 120,
                    ),
                    const WidgetXProgressChart(
                      value: 0.45,
                      label: 'Coverage',
                      size: 120,
                    ),
                    const WidgetXProgressChart(
                      value: 0.91,
                      label: 'Performance',
                      size: 120,
                    ),
                  ],
                ),
                const SizedBox(height: WidgetXSpacing.md),
                Text(
                  'Adjust completion',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                WidgetXSlider(
                  value: _progress,
                  onChanged: (v) => setState(() => _progress = v),
                  showValueLabel: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Empty and loading states
          const SectionHeader(
            title: 'Empty & Loading States',
            description:
                'Every chart supports isLoading and emptyMessage '
                'for complete data lifecycle coverage.',
          ),
          Row(
            children: [
              Expanded(
                child: WidgetXCard(
                  body: const WidgetXBarChart(
                    data: [],
                    title: 'Empty Bar Chart',
                    height: 140,
                    emptyMessage: 'No data yet',
                  ),
                ),
              ),
              const SizedBox(width: WidgetXSpacing.sm),
              Expanded(
                child: WidgetXCard(
                  body: const WidgetXLineChart(
                    data: [],
                    title: 'Loading…',
                    height: 140,
                    isLoading: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Code example
          const SectionHeader(title: 'Example Code'),
          const CodeBlock(
            code: '''// Bar chart
WidgetXBarChart(
  data: [
    WidgetXChartPoint(label: 'Jan', value: 52),
    WidgetXChartPoint(label: 'Feb', value: 78),
  ],
  title: 'Monthly Revenue',
  height: 200,
)

// Radial progress
WidgetXProgressChart(
  value: 0.72,
  label: 'Completion',
)

// Pie / donut
WidgetXPieChart(
  segments: [
    WidgetXChartPoint(label: 'Food', value: 40),
    WidgetXChartPoint(label: 'Transport', value: 25),
  ],
  donut: true,
)''',
          ),
        ],
      );
  }
}
