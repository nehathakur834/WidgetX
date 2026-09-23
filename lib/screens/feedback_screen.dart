import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md,
        WidgetXSpacing.md,
        WidgetXSpacing.md,
        WidgetXSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      children: [
          const SectionHeader(title: 'Banners'),
          const WidgetXBanner(
            variant: WidgetXBannerVariant.info,
            message: 'Your subscription renews in 3 days.',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXBanner(
            variant: WidgetXBannerVariant.success,
            title: 'Payment received',
            message: 'Your plan has been upgraded to Pro.',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXBanner(
            variant: WidgetXBannerVariant.warning,
            message: 'Your account storage is almost full.',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXBanner(
            variant: WidgetXBannerVariant.error,
            message: 'Payment failed. Please update your billing info.',
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Snackbars'),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: WidgetXSnackbarVariant.values
                .map(
                  (v) => WidgetXButton(
                    label: v.name,
                    variant: WidgetXButtonVariant.outlined,
                    onPressed: () => showWidgetXSnackbar(
                      context: context,
                      message: '${v.name} notification',
                      variant: v,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Progress'),
          const WidgetXCircularProgress(),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXLinearProgress(),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXLinearProgress(value: 0.65),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Skeleton'),
          const WidgetXSkeletonText(lines: 4),
          const SizedBox(height: WidgetXSpacing.sm),
          const Row(
            children: [
              WidgetXSkeleton(height: 48, isCircle: true),
              SizedBox(width: WidgetXSpacing.sm),
              Expanded(child: WidgetXSkeletonText(lines: 2)),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Empty & Error States'),
          const WidgetXEmptyState(
            icon: Icons.inbox_outlined,
            title: 'No messages yet',
            description: 'When you receive messages, they will appear here.',
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXEmptyState(
            isError: true,
            title: 'Something went wrong',
            description: 'We couldn\'t load the data. Please try again.',
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Badges & Chips'),
          Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: WidgetXBadgeVariant.values
                .map((v) => WidgetXBadge(label: v.name, variant: v))
                .toList(),
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          const Wrap(
            spacing: WidgetXSpacing.sm,
            children: [
              WidgetXChip(label: 'Flutter'),
              WidgetXChip(label: 'Dart'),
              WidgetXChip(label: 'Design Systems', isSelected: true),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Dividers'),
          const WidgetXDivider(),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXDivider.labeled(label: 'or'),
          const SizedBox(height: WidgetXSpacing.sm),
          const SectionHeader(title: 'Avatars'),
          const Wrap(
            spacing: WidgetXSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              WidgetXAvatar(initials: 'JD', size: WidgetXAvatarSize.xs),
              WidgetXAvatar(initials: 'AB', size: WidgetXAvatarSize.sm),
              WidgetXAvatar(initials: 'CD', size: WidgetXAvatarSize.md),
              WidgetXAvatar(initials: 'EF', size: WidgetXAvatarSize.lg),
              WidgetXAvatar(icon: Icons.person, size: WidgetXAvatarSize.xl),
            ],
          ),
      ],
    );
  }
}
