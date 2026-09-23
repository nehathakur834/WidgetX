import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A configurable data table following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXDataTable(
///   columns: ['Name', 'Role', 'Status'],
///   rows: [
///     ['Alice', 'Designer', 'Active'],
///     ['Bob', 'Engineer', 'Inactive'],
///   ],
/// )
/// ```
class WidgetXDataTable extends StatefulWidget {
  /// Creates a [WidgetXDataTable].
  const WidgetXDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
    this.isLoading = false,
    this.emptyMessage = 'No data available',
    this.selectedRows,
    this.onRowSelected,
  });

  final List<String> columns;
  final List<List<String>> rows;
  final ValueChanged<int>? onRowTap;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(int columnIndex, bool ascending)? onSort;
  final bool isLoading;
  final String emptyMessage;
  final Set<int>? selectedRows;
  final ValueChanged<int>? onRowSelected;

  @override
  State<WidgetXDataTable> createState() => _WidgetXDataTableState();
}

class _WidgetXDataTableState extends State<WidgetXDataTable> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _sortColumnIndex = widget.sortColumnIndex;
    _sortAscending = widget.sortAscending;
  }

  List<List<String>> get _sortedRows {
    if (_sortColumnIndex == null) return widget.rows;
    final sorted = [...widget.rows]..sort(
        (a, b) => a[_sortColumnIndex!].compareTo(b[_sortColumnIndex!]),
      );
    return _sortAscending ? sorted : sorted.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (widget.isLoading) {
      return _LoadingRows(columns: widget.columns);
    }

    if (widget.rows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(WidgetXSpacing.xxl),
        child: Center(
          child: Text(
            widget.emptyMessage,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: cs.onSurfaceVariant),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        headingRowColor: WidgetStateProperty.all(
          cs.surfaceContainerHighest,
        ),
        columns: widget.columns
            .asMap()
            .entries
            .map(
              (entry) => DataColumn(
                label: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                onSort: widget.onSort != null
                    ? (colIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = colIndex;
                          _sortAscending = ascending;
                        });
                        widget.onSort!(colIndex, ascending);
                      }
                    : null,
              ),
            )
            .toList(),
        rows: _sortedRows.asMap().entries.map((rowEntry) {
          final i = rowEntry.key;
          final row = rowEntry.value;
          final isSelected = widget.selectedRows?.contains(i) ?? false;
          return DataRow(
            selected: isSelected,
            onSelectChanged: widget.onRowSelected != null
                ? (_) => widget.onRowSelected!(i)
                : null,
            onLongPress:
                widget.onRowTap != null ? () => widget.onRowTap!(i) : null,
            color: isSelected
                ? WidgetStateProperty.all(
                    cs.primaryContainer.withValues(alpha: 0.3))
                : null,
            cells: row
                .map(
                  (cell) => DataCell(
                    Text(cell),
                    onTap: widget.onRowTap != null
                        ? () => widget.onRowTap!(i)
                        : null,
                  ),
                )
                .toList(),
          );
        }).toList(),
      ),
    );
  }
}

class _LoadingRows extends StatelessWidget {
  const _LoadingRows({required this.columns});
  final List<String> columns;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          color: cs.surfaceContainerHighest,
        ),
        for (var i = 0; i < 4; i++)
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 1),
            color: i.isEven
                ? cs.surface
                : cs.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
      ],
    );
  }
}
