import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';

class PropertyHomeScreen extends StatefulWidget {
  const PropertyHomeScreen({super.key});

  @override
  State<PropertyHomeScreen> createState() => _PropertyHomeScreenState();
}

class _PropertyHomeScreenState extends State<PropertyHomeScreen> {
  final _searchController = TextEditingController();
  String _selectedType = 'All';

  static const _types = [
    'All',
    'Apartment',
    'House',
    'Condo',
    'Penthouse',
    'Loft',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final filtered = _selectedType == 'All'
        ? MockData.properties
        : MockData.properties
            .where((p) => p.type == _selectedType)
            .toList();

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Real Estate',
        favoriteId: 'tpl-realestate',
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Find Your Home',
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text('${MockData.properties.length} properties available',
                      style: tt.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant)),
                  const SizedBox(height: WidgetXSpacing.lg),
                  WidgetXTextField(
                    controller: _searchController,
                    hint: 'Search by location, type…',
                    prefixIcon: const Icon(Icons.search, size: 18),
                  ),
                  const SizedBox(height: WidgetXSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _types
                          .map(
                            (t) => Padding(
                              padding: const EdgeInsets.only(
                                  right: WidgetXSpacing.sm),
                              child: ChoiceChip(
                                label: Text(t),
                                selected: _selectedType == t,
                                onSelected: (_) =>
                                    setState(() => _selectedType = t),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.md),
                  Text('${filtered.length} results',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: WidgetXSpacing.xl, vertical: WidgetXSpacing.sm),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: WidgetXSpacing.md),
                  child: _PropertyCard(property: filtered[i]),
                ),
                childCount: filtered.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: WidgetXSpacing.xl)),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property});
  final MockProperty property;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final price = property.price >= 1000000
        ? '\$${(property.price / 1000000).toStringAsFixed(1)}M'
        : '\$${(property.price / 1000).toStringAsFixed(0)}K';

    return WidgetXCard(
      onTap: () => context.go('/templates/realestate/details'),
      semanticDescription: 'View ${property.title} details',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(WidgetXRadius.sm),
                ),
                child: Center(
                  child: Icon(Icons.home_outlined,
                      size: 48, color: cs.outlineVariant),
                ),
              ),
              if (property.isFeatured)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Featured',
                        style:
                            tt.labelSmall?.copyWith(color: cs.onPrimary)),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(property.type,
                      style: tt.labelSmall),
                ),
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(property.title,
                    style: tt.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              Text(price,
                  style: tt.titleMedium?.copyWith(
                      color: cs.primary, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.xs),
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(property.location,
                  style:
                      tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          Row(
            children: [
              _AmenityChip(
                  icon: Icons.bed_outlined, label: '${property.beds} bed'),
              const SizedBox(width: WidgetXSpacing.sm),
              _AmenityChip(
                  icon: Icons.bathtub_outlined,
                  label: '${property.baths} bath'),
              const SizedBox(width: WidgetXSpacing.sm),
              _AmenityChip(
                  icon: Icons.square_foot_outlined,
                  label: '${property.sqft} sqft'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  const _AmenityChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: cs.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(label,
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}
