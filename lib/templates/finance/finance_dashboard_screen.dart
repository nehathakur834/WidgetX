import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';

void _showQuickActionSheet(
    BuildContext context, String action, String description) {
  showWidgetXBottomSheet(
    context: context,
    title: action,
    body: Builder(
      builder: (sheetContext) => Column(
        children: [
          Text(description,
              style: Theme.of(sheetContext)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                      color: Theme.of(sheetContext)
                          .colorScheme
                          .onSurfaceVariant)),
          const SizedBox(height: WidgetXSpacing.lg),
          const WidgetXTextField(
            label: 'Recipient',
            hint: 'Email or account number',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXTextField(
            label: 'Amount',
            hint: '0.00',
            keyboardType: TextInputType.number,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12),
              child: Text('\$', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          WidgetXButton(
            label: action,
            variant: WidgetXButtonVariant.primary,
            isFullWidth: true,
            onPressed: () {
              Navigator.of(sheetContext).pop();
              showWidgetXSnackbar(
                context: context,
                message: '$action initiated successfully',
                variant: WidgetXSnackbarVariant.success,
              );
            },
          ),
        ],
      ),
    ),
  );
}

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Finance',
        favoriteId: 'tpl-finance',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          WidgetXSpacing.xl,
          WidgetXSpacing.xl,
          WidgetXSpacing.xl,
          WidgetXSpacing.xl + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Finance',
                style: tt.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            Text('January 2025',
                style: tt.bodyMedium
                    ?.copyWith(color: cs.onSurfaceVariant)),
            const SizedBox(height: WidgetXSpacing.xl),

            // Balance card (gradient)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cs.primary, cs.secondary],
                ),
                borderRadius: BorderRadius.circular(WidgetXRadius.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Balance',
                      style: tt.bodyMedium
                          ?.copyWith(color: cs.onPrimary.withValues(alpha: 0.78))),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text('\$24,563.00',
                      style: tt.displaySmall?.copyWith(
                          color: cs.onPrimary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.lg),
                  Row(
                    children: [
                      _BalanceStat(
                          label: 'Income',
                          value: '\$5,950',
                          icon: Icons.arrow_upward,
                          color: Colors.greenAccent.shade200),
                      const SizedBox(width: WidgetXSpacing.xl),
                      _BalanceStat(
                          label: 'Expenses',
                          value: '\$2,380',
                          icon: Icons.arrow_downward,
                          color: Colors.redAccent.shade100),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Quick actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _QuickAction(
                    icon: Icons.send_outlined,
                    label: 'Send',
                    onTap: () => _showQuickActionSheet(
                        context, 'Send Money', 'Transfer funds to another account.')),
                _QuickAction(
                    icon: Icons.call_received_outlined,
                    label: 'Receive',
                    onTap: () => _showQuickActionSheet(
                        context, 'Receive Money', 'Receive funds from another account.')),
                _QuickAction(
                    icon: Icons.swap_horiz_outlined,
                    label: 'Transfer',
                    onTap: () => _showQuickActionSheet(
                        context, 'Transfer', 'Move funds between your accounts.')),
                _QuickAction(
                    icon: Icons.more_horiz_outlined,
                    label: 'More',
                    onTap: () => showWidgetXSnackbar(
                      context: context,
                      message: 'More actions coming soon',
                    )),
              ],
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Spending breakdown pie chart ─────────────────────────────────
            Text('Spending Breakdown',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: WidgetXSpacing.md),
            const WidgetXCard(
              body: WidgetXPieChart(
                segments: [
                  WidgetXChartPoint(label: 'Housing', value: 35),
                  WidgetXChartPoint(label: 'Food', value: 22),
                  WidgetXChartPoint(label: 'Transport', value: 15),
                  WidgetXChartPoint(label: 'Health', value: 12),
                  WidgetXChartPoint(label: 'Other', value: 16),
                ],
                title: 'Monthly Expenses',
                size: 160,
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Monthly income vs expenses bar chart ─────────────────────────
            const WidgetXCard(
              body: WidgetXBarChart(
                data: [
                  WidgetXChartPoint(label: 'Sep', value: 2100),
                  WidgetXChartPoint(label: 'Oct', value: 2450),
                  WidgetXChartPoint(label: 'Nov', value: 1980),
                  WidgetXChartPoint(label: 'Dec', value: 2800),
                  WidgetXChartPoint(label: 'Jan', value: 2380),
                ],
                title: 'Monthly Expenses (\$)',
                height: 160,
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            Text('Recent Transactions',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: WidgetXSpacing.md),

            ...MockData.transactions.map(
              (t) => Padding(
                padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                child: WidgetXCard(
                  body: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: t.isCredit
                              ? Colors.green.shade50
                              : cs.errorContainer,
                          borderRadius:
                              BorderRadius.circular(WidgetXRadius.md),
                        ),
                        child: Icon(
                          t.icon,
                          size: 20,
                          color: t.isCredit
                              ? Colors.green.shade700
                              : cs.onErrorContainer,
                        ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${t.isCredit ? '+' : '-'}\$${t.amount.toStringAsFixed(2)}',
                            style: tt.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: t.isCredit
                                  ? Colors.green.shade700
                                  : cs.error,
                            ),
                          ),
                          Text(t.subtitle,
                              style: tt.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant)),
                        ],
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

class _BalanceStat extends StatelessWidget {
  const _BalanceStat(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});
  final String label, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: tt.bodySmall?.copyWith(color: color)),
            Text(value,
                style: tt.titleMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(WidgetXRadius.xl),
        child: Padding(
          padding: const EdgeInsets.all(WidgetXSpacing.xs),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: cs.onPrimaryContainer, size: 22),
              ),
              const SizedBox(height: WidgetXSpacing.xs),
              Text(label,
                  style:
                      tt.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
