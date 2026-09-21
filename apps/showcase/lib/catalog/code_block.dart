import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class CodeBlock extends StatelessWidget {
  const CodeBlock({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copy'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  showWidgetXSnackbar(
                    context: context,
                    message: 'Code copied to clipboard',
                    variant: WidgetXSnackbarVariant.success,
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                WidgetXSpacing.md, 0, WidgetXSpacing.md, WidgetXSpacing.md),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
