import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';

class TaskDashboardScreen extends StatefulWidget {
  const TaskDashboardScreen({super.key});

  @override
  State<TaskDashboardScreen> createState() => _TaskDashboardScreenState();
}

class _TaskDashboardScreenState extends State<TaskDashboardScreen> {
  List<MockTask> _tasks = MockData.tasks.toList();

  void _toggleTask(int index) {
    setState(() {
      final t = _tasks[index];
      _tasks[index] = MockTask(
        id: t.id,
        title: t.title,
        project: t.project,
        priority: t.priority,
        isDone: !t.isDone,
        dueDate: t.dueDate,
      );
    });
  }

  void _showNewTaskDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    String priority = 'Medium';
    showWidgetXBottomSheet(
      context: context,
      title: 'New Task',
      body: StatefulBuilder(
        builder: (ctx, setSheetState) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetXTextField(
              controller: titleCtrl,
              label: 'Task Title',
              hint: 'What needs to be done?',
              autofocus: true,
            ),
            const SizedBox(height: WidgetXSpacing.md),
            Text('Priority',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(ctx).colorScheme.onSurfaceVariant)),
            const SizedBox(height: WidgetXSpacing.xs),
            WidgetXSegmentedControl(
              segments: const ['Low', 'Medium', 'High'],
              selectedIndex: ['Low', 'Medium', 'High'].indexOf(priority),
              onChanged: (i) => setSheetState(
                  () => priority = ['Low', 'Medium', 'High'][i]),
            ),
            const SizedBox(height: WidgetXSpacing.lg),
            WidgetXButton(
              label: 'Add Task',
              variant: WidgetXButtonVariant.primary,
              isFullWidth: true,
              onPressed: () {
                final title = titleCtrl.text.trim();
                if (title.isEmpty) return;
                setState(() {
                  _tasks = [
                    ..._tasks,
                    MockTask(
                      id: '${_tasks.length + 1}',
                      title: title,
                      project: 'WidgetX UI',
                      priority: priority,
                      dueDate: 'Today',
                    ),
                  ];
                });
                Navigator.of(context).pop();
                showWidgetXSnackbar(
                  context: context,
                  message: 'Task "$title" added',
                  variant: WidgetXSnackbarVariant.success,
                );
              },
            ),
          ],
        ),
      ),
    );
    titleCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final done = _tasks.where((t) => t.isDone).length;
    final total = _tasks.length;
    final progress = total == 0 ? 0.0 : done / total;

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Task Dashboard',
        favoriteId: 'tpl-productivity',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(WidgetXSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Tasks',
                          style: tt.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      Text('$done of $total tasks completed',
                          style: tt.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                WidgetXButton(
                  label: 'New Task',
                  onPressed: () => _showNewTaskDialog(context),
                  variant: WidgetXButtonVariant.primary,
                  leadingIcon: const Icon(Icons.add, size: 18),
                ),
              ],
            ),
            const SizedBox(height: WidgetXSpacing.lg),

            // Progress card
            WidgetXCard(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Overall Progress',
                          style: tt.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text('${(progress * 100).toInt()}%',
                          style: tt.titleSmall?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: cs.outlineVariant,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.md),
                  Row(
                    children: [
                      _ProgressStat(
                          label: 'To Do',
                          count: _tasks.where((t) => !t.isDone).length,
                          color: cs.primary),
                      const SizedBox(width: WidgetXSpacing.xl),
                      _ProgressStat(
                          label: 'Done',
                          count: done,
                          color: Colors.green.shade600),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Project cards
            Text('Projects',
                style: tt.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: WidgetXSpacing.md),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _ProjectCard(
                      name: 'WidgetX UI',
                      taskCount: _tasks
                          .where((t) => t.project == 'WidgetX UI')
                          .length,
                      color: cs.primaryContainer,
                      textColor: cs.onPrimaryContainer),
                  const SizedBox(width: WidgetXSpacing.md),
                  _ProjectCard(
                      name: 'General',
                      taskCount: _tasks
                          .where((t) => t.project == 'General')
                          .length,
                      color: cs.secondaryContainer,
                      textColor: cs.onSecondaryContainer),
                ],
              ),
            ),
            const SizedBox(height: WidgetXSpacing.xl),

            // Task list
            Text('All Tasks',
                style: tt.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: WidgetXSpacing.md),
            ..._tasks.asMap().entries.map(
                  (e) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                    child: WidgetXCard(
                      body: Row(
                        children: [
                          Checkbox(
                            value: e.value.isDone,
                            onChanged: (_) => _toggleTask(e.key),
                            activeColor: cs.primary,
                          ),
                          const SizedBox(width: WidgetXSpacing.xs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.value.title,
                                  style: tt.bodyMedium?.copyWith(
                                    decoration: e.value.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: e.value.isDone
                                        ? cs.onSurfaceVariant
                                        : cs.onSurface,
                                  ),
                                ),
                                Text(
                                  '${e.value.project} • ${e.value.dueDate}',
                                  style: tt.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          _PriorityBadge(priority: e.value.priority),
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

class _ProgressStat extends StatelessWidget {
  const _ProgressStat(
      {required this.label, required this.count, required this.color});
  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$count $label', style: tt.bodySmall),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard(
      {required this.name,
      required this.taskCount,
      required this.color,
      required this.textColor});
  final String name;
  final int taskCount;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      width: 140,
      padding: const EdgeInsets.all(WidgetXSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(WidgetXRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name,
              style: tt.titleSmall
                  ?.copyWith(color: textColor, fontWeight: FontWeight.w600)),
          Text('$taskCount tasks',
              style: tt.bodySmall?.copyWith(color: textColor)),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});
  final String priority;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color color;
    switch (priority) {
      case 'High':
        color = cs.error;
      case 'Medium':
        color = Colors.orange.shade600;
      default:
        color = Colors.green.shade600;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Text(
        priority,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
