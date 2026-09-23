import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';
import '../catalog/favorite_button.dart';

class DialogsScreen extends StatelessWidget {
  const DialogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetXAppBar(
        title: 'Dialogs & Sheets',
        actions: [FavoriteButton(id: 'dialogs')],
      ),
      body: ListView(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        children: [
          // Alert Dialog
          const SectionHeader(
            title: 'Alert Dialog',
            description: 'Notify the user of important information.',
          ),
          WidgetXButton(
            label: 'Show Alert Dialog',
            variant: WidgetXButtonVariant.outlined,
            onPressed: () => showWidgetXAlertDialog(
              context: context,
              title: 'Session Expiring',
              message:
                  'Your session will expire in 5 minutes. Please save your work.',
              confirmLabel: 'Got it',
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Confirmation Dialog
          const SectionHeader(
            title: 'Confirmation Dialog',
            description: 'Request user confirmation before an action.',
          ),
          WidgetXButton(
            label: 'Show Confirm Dialog',
            variant: WidgetXButtonVariant.outlined,
            onPressed: () async {
              final confirmed = await showWidgetXConfirmDialog(
                context: context,
                title: 'Delete Account',
                message:
                    'This will permanently delete your account and all its data. This action cannot be undone.',
                confirmLabel: 'Delete',
                cancelLabel: 'Cancel',
                isDestructive: true,
              );
              if (confirmed == true && context.mounted) {
                showWidgetXSnackbar(
                  context: context,
                  message: 'Account deletion confirmed',
                  variant: WidgetXSnackbarVariant.error,
                );
              }
            },
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Custom Dialog
          const SectionHeader(
            title: 'Custom Dialog',
            description: 'Custom body content inside a standard dialog.',
          ),
          WidgetXButton(
            label: 'Show Custom Dialog',
            variant: WidgetXButtonVariant.outlined,
            onPressed: () => WidgetXDialog(
              title: 'Rename File',
              body: const WidgetXTextField(
                label: 'File name',
                hint: 'Enter new name…',
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Save'),
                ),
              ],
            ).show(context),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Modal Bottom Sheet
          const SectionHeader(
            title: 'Modal Bottom Sheet',
            description: 'Surface that slides up from the bottom.',
          ),
          WidgetXButton(
            label: 'Show Bottom Sheet',
            variant: WidgetXButtonVariant.outlined,
            onPressed: () => showWidgetXBottomSheet(
              context: context,
              title: 'Share with',
              body: Wrap(
                spacing: WidgetXSpacing.md,
                runSpacing: WidgetXSpacing.md,
                children:
                    [
                      Icons.message_outlined,
                      Icons.email_outlined,
                      Icons.link,
                      Icons.copy,
                    ].map((icon) {
                      return InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(WidgetXSpacing.md),
                          child: Icon(
                            icon,
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Action Sheet
          const SectionHeader(
            title: 'Action Sheet',
            description: 'A list of labeled actions in a bottom sheet.',
          ),
          WidgetXButton(
            label: 'Show Action Sheet',
            variant: WidgetXButtonVariant.outlined,
            onPressed: () async {
              final choice = await showWidgetXActionSheet(
                context: context,
                title: 'Choose an action',
                actions: const [
                  WidgetXActionItem(label: 'Edit', icon: Icons.edit_outlined),
                  WidgetXActionItem(
                    label: 'Duplicate',
                    icon: Icons.copy_outlined,
                  ),
                  WidgetXActionItem(
                    label: 'Archive',
                    icon: Icons.archive_outlined,
                  ),
                  WidgetXActionItem(
                    label: 'Delete',
                    icon: Icons.delete_outline,
                    isDestructive: true,
                  ),
                ],
              );
              if (choice != null && context.mounted) {
                showWidgetXSnackbar(
                  context: context,
                  message: 'Selected action #${choice + 1}',
                );
              }
            },
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Code example
          const SectionHeader(title: 'Example Code'),
          const CodeBlock(
            code: '''await showWidgetXConfirmDialog(
  context: context,
  title: 'Delete file',
  message: 'This cannot be undone.',
  confirmLabel: 'Delete',
  isDestructive: true,
);''',
          ),
        ],
      ),
    );
  }
}
