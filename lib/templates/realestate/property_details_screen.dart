import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../providers/favorites_provider.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  static final _property = MockData.properties.first;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final price = '\$${(_property.price / 1000).toStringAsFixed(0)}K';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          Consumer(
            builder: (ctx, ref, _) {
              final isFav = ref.watch(
                favoritesProvider
                    .select((s) => s.contains('tpl-property-details')),
              );
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_outline,
                  color: isFav ? Colors.red : null,
                ),
                tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
                onPressed: () => ref
                    .read(favoritesProvider.notifier)
                    .toggle('tpl-property-details'),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image gallery
            SizedBox(
              height: 260,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: cs.surfaceContainerHighest,
                    child: Center(
                      child: Icon(Icons.home_outlined,
                          size: 80, color: cs.outlineVariant),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('1 / 5',
                          style: tt.bodySmall
                              ?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(_property.title,
                            style: tt.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ),
                      Text(price,
                          style: tt.headlineMedium?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16, color: cs.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(_property.location,
                          style: tt.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Amenities
                  WidgetXCard(
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _AmenityItem(
                            icon: Icons.bed_outlined,
                            label: 'Bedrooms',
                            value: '${_property.beds}'),
                        _AmenityItem(
                            icon: Icons.bathtub_outlined,
                            label: 'Bathrooms',
                            value: '${_property.baths}'),
                        _AmenityItem(
                            icon: Icons.square_foot_outlined,
                            label: 'Area',
                            value: '${_property.sqft} sqft'),
                        _AmenityItem(
                            icon: Icons.home_outlined,
                            label: 'Type',
                            value: _property.type),
                      ],
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  Text('Description',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text(
                    'This stunning ${_property.type.toLowerCase()} in ${_property.location} offers modern living at its finest. '
                    'Featuring ${_property.beds} spacious bedrooms, ${_property.baths} elegant bathrooms, '
                    'and ${_property.sqft} sqft of meticulously designed living space. '
                    'Prime location with easy access to public transport, restaurants, and shopping.',
                    style: tt.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Agent card
                  Text('Agent',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  WidgetXCard(
                    body: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: cs.primaryContainer,
                          child: Icon(Icons.person_outline,
                              color: cs.onPrimaryContainer),
                        ),
                        const SizedBox(width: WidgetXSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sarah Mitchell',
                                  style: tt.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600)),
                              Text('Licensed Real Estate Agent',
                                  style: tt.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.message_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.xl),

                  WidgetXButton(
                    label: 'Schedule Viewing',
                    onPressed: () {},
                    variant: WidgetXButtonVariant.primary,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),
                  WidgetXButton(
                    label: 'Contact Agent',
                    onPressed: () {},
                    variant: WidgetXButtonVariant.outlined,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmenityItem extends StatelessWidget {
  const _AmenityItem(
      {required this.icon,
      required this.label,
      required this.value});
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(icon, color: cs.primary, size: 22),
        const SizedBox(height: WidgetXSpacing.xs),
        Text(value,
            style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        Text(label,
            style:
                tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}
