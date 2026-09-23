import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/social_provider.dart';

class SocialHomeScreen extends StatelessWidget {
  const SocialHomeScreen({super.key});

  static final _stories = [
    'Alex J.',
    'Sarah C.',
    'Marcus R.',
    'Emma W.',
    'Liam K.',
    'Sofia M.',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('WidgetX Social'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: () {},
              ),
              Consumer(
                builder: (ctx, ref, _) {
                  final isFav = ref.watch(
                    favoritesProvider.select((s) => s.contains('tpl-social')),
                  );
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                      size: 20,
                    ),
                    tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
                    onPressed: () =>
                        ref.read(favoritesProvider.notifier).toggle('tpl-social'),
                  );
                },
              ),
            ],
          ),
          // Story bar
          SliverToBoxAdapter(
            child: SizedBox(
              height: 96,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: WidgetXSpacing.lg,
                    vertical: WidgetXSpacing.sm),
                scrollDirection: Axis.horizontal,
                itemCount: _stories.length + 1,
                separatorBuilder: (ctx, i) =>
                    const SizedBox(width: WidgetXSpacing.sm),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return _StoryItem(
                      label: 'Your Story',
                      isOwn: true,
                      color: cs.primaryContainer,
                      textColor: cs.onPrimaryContainer,
                    );
                  }
                  return _StoryItem(
                    label: _stories[i - 1],
                    color: cs.secondaryContainer,
                    textColor: cs.onSecondaryContainer,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Divider(color: cs.outlineVariant)),
          // Posts
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: WidgetXSpacing.sm),
                child: _PostCard(post: MockData.posts[i]),
              ),
              childCount: MockData.posts.length,
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: WidgetXSpacing.xl)),
        ],
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem(
      {required this.label,
      this.isOwn = false,
      required this.color,
      required this.textColor});
  final String label;
  final bool isOwn;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: isOwn
                  ? Icon(Icons.add, color: textColor)
                  : Text(label[0].toUpperCase(),
                      style: tt.titleMedium
                          ?.copyWith(color: textColor)),
            ),
            if (isOwn)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2),
                  ),
                  child: const Icon(Icons.add,
                      size: 12, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label.split(' ').first,
          style: tt.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _PostCard extends ConsumerWidget {
  const _PostCard({required this.post});
  final MockPost post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final liked = ref.watch(
      socialLikesProvider.select((s) => s.contains(post.id)),
    );
    final likes = post.likes + (liked ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: WidgetXSpacing.lg),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: cs.primaryContainer,
                child: Text(
                  post.author[0].toUpperCase(),
                  style: tt.titleSmall
                      ?.copyWith(color: cs.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: WidgetXSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.author,
                        style: tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text(post.handle,
                            style: tt.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                        const SizedBox(width: 4),
                        Text('· ${post.timeAgo}',
                            style: tt.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: WidgetXSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: WidgetXSpacing.lg),
          child: Text(post.content, style: tt.bodyMedium),
        ),
        const SizedBox(height: WidgetXSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: WidgetXSpacing.sm),
          child: Row(
            children: [
              Semantics(
                label: liked ? 'Unlike post' : 'Like post',
                button: true,
                child: IconButton(
                  icon: Icon(
                    liked ? Icons.favorite : Icons.favorite_outline,
                    color: liked ? cs.error : null,
                    size: 20,
                  ),
                  onPressed: () => ref
                      .read(socialLikesProvider.notifier)
                      .toggle(post.id),
                ),
              ),
              Text('$likes', style: tt.bodySmall),
              const SizedBox(width: WidgetXSpacing.sm),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 20),
                onPressed: () {},
              ),
              Text('${post.comments}', style: tt.bodySmall),
              const SizedBox(width: WidgetXSpacing.sm),
              Text('${post.shares} shares',
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.share_outlined, size: 20),
                onPressed: () => showWidgetXSnackbar(
                  context: context,
                  message: 'Link copied to clipboard',
                ),
              ),
            ],
          ),
        ),
        Divider(color: cs.outlineVariant, height: 1),
      ],
    );
  }
}
