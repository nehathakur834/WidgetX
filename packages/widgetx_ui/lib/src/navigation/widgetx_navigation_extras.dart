import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A segmented control / button group for mutually-exclusive selections.
///
/// Example:
/// ```dart
/// WidgetXSegmentedControl(
///   segments: ['Day', 'Week', 'Month'],
///   selectedIndex: _index,
///   onChanged: (i) => setState(() => _index = i),
/// )
/// ```
class WidgetXSegmentedControl extends StatelessWidget {
  /// Creates a [WidgetXSegmentedControl].
  const WidgetXSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    this.isEnabled = true,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    // Use Material 3 SegmentedButton when possible
    return SegmentedButton<int>(
      segments: segments.asMap().entries.map((e) {
        return ButtonSegment<int>(
          value: e.key,
          label: Text(e.value),
        );
      }).toList(),
      selected: {selectedIndex},
      onSelectionChanged:
          isEnabled ? (newSelection) => onChanged(newSelection.first) : null,
      style: SegmentedButton.styleFrom(
        minimumSize: const Size(0, 40),
      ),
    );
  }
}

/// A breadcrumb navigation component.
///
/// Example:
/// ```dart
/// WidgetXBreadcrumbs(
///   items: [
///     WidgetXBreadcrumbItem(label: 'Home', onTap: () {}),
///     WidgetXBreadcrumbItem(label: 'Products', onTap: () {}),
///     WidgetXBreadcrumbItem(label: 'Details'),
///   ],
/// )
/// ```
class WidgetXBreadcrumbs extends StatelessWidget {
  const WidgetXBreadcrumbs({super.key, required this.items});

  final List<WidgetXBreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Breadcrumb: ${items.map((e) => e.label).join(' > ')}',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: WidgetXSpacing.xs),
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              GestureDetector(
                onTap: items[i].onTap,
                child: Text(
                  items[i].label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            i == items.length - 1 ? cs.onSurface : cs.primary,
                        fontWeight: i == items.length - 1
                            ? FontWeight.w600
                            : FontWeight.normal,
                        decoration: items[i].onTap != null
                            ? TextDecoration.underline
                            : null,
                        decorationColor: cs.primary,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// An item in a [WidgetXBreadcrumbs] widget.
class WidgetXBreadcrumbItem {
  const WidgetXBreadcrumbItem({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;
}

/// A step in a [WidgetXStepper].
class WidgetXStepItem {
  const WidgetXStepItem({
    required this.title,
    required this.content,
    this.subtitle,
    this.isOptional = false,
  });

  final String title;
  final Widget content;
  final String? subtitle;
  final bool isOptional;
}

/// A vertical stepper for multi-step processes.
///
/// Example:
/// ```dart
/// WidgetXStepper(
///   steps: [
///     WidgetXStepItem(title: 'Account', content: AccountForm()),
///     WidgetXStepItem(title: 'Profile', content: ProfileForm()),
///   ],
/// )
/// ```
class WidgetXStepper extends StatefulWidget {
  const WidgetXStepper({
    super.key,
    required this.steps,
    this.onCompleted,
    this.physics,
  });

  final List<WidgetXStepItem> steps;
  final VoidCallback? onCompleted;
  final ScrollPhysics? physics;

  @override
  State<WidgetXStepper> createState() => _WidgetXStepperState();
}

class _WidgetXStepperState extends State<WidgetXStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      physics: widget.physics ?? const ClampingScrollPhysics(),
      onStepContinue: () {
        if (_currentStep < widget.steps.length - 1) {
          setState(() => _currentStep++);
        } else {
          widget.onCompleted?.call();
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) setState(() => _currentStep--);
      },
      onStepTapped: (step) => setState(() => _currentStep = step),
      steps: widget.steps
          .map(
            (step) => Step(
              title: Text(step.title),
              subtitle: step.subtitle != null ? Text(step.subtitle!) : null,
              content: step.content,
              isActive: _currentStep >= widget.steps.indexOf(step),
              state: _currentStep > widget.steps.indexOf(step)
                  ? StepState.complete
                  : StepState.indexed,
            ),
          )
          .toList(),
    );
  }
}
