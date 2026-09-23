import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../../catalog/template_app_bar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _guests = 2;
  DateTime _checkIn = DateTime.now().add(const Duration(days: 3));
  DateTime _checkOut = DateTime.now().add(const Duration(days: 6));
  int _selectedRoom = 0;

  static const _rooms = [
    _Room(
        name: 'Standard Room',
        price: 89,
        beds: 1,
        sqft: 280,
        amenities: ['WiFi', 'TV', 'AC', 'Safe']),
    _Room(
        name: 'Deluxe Room',
        price: 139,
        beds: 1,
        sqft: 380,
        amenities: ['WiFi', 'TV', 'AC', 'Safe', 'Mini-bar']),
    _Room(
        name: 'Suite',
        price: 249,
        beds: 2,
        sqft: 620,
        amenities: ['WiFi', 'TV', 'AC', 'Safe', 'Mini-bar', 'Jacuzzi']),
  ];

  int get _nights => _checkOut.difference(_checkIn).inDays;
  int get _total => _rooms[_selectedRoom].price * _nights;

  String _formatDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';

  Future<void> _pickDate(bool isCheckIn) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkIn : _checkOut,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked == null) return;
    setState(() {
      if (isCheckIn) {
        _checkIn = picked;
        if (_checkOut.isBefore(_checkIn)) {
          _checkOut = _checkIn.add(const Duration(days: 1));
        }
      } else {
        _checkOut = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Hotel Booking',
        favoriteId: 'tpl-booking',
        subtitle: 'Grand Palace Hotel',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(WidgetXSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero card ────────────────────────────────────────────────────
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(WidgetXRadius.xl),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cs.primaryContainer,
                    cs.secondaryContainer,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.hotel, size: 48, color: cs.primary),
                        const SizedBox(height: WidgetXSpacing.sm),
                        Text('Grand Palace Hotel',
                            style: tt.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: WidgetXSpacing.xs),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('Midtown Manhattan, NYC',
                                style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: WidgetXSpacing.md,
                    right: WidgetXSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: WidgetXSpacing.sm,
                          vertical: WidgetXSpacing.xxs),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius:
                            BorderRadius.circular(WidgetXRadius.sm),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('4.8',
                              style: tt.labelMedium
                                  ?.copyWith(color: cs.onPrimary)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Date + guest selector ────────────────────────────────────────
            Text('Select Dates',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: WidgetXSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _DateCard(
                    label: 'Check-in',
                    date: _formatDate(_checkIn),
                    icon: Icons.login_outlined,
                    onTap: () => _pickDate(true),
                  ),
                ),
                const SizedBox(width: WidgetXSpacing.md),
                Expanded(
                  child: _DateCard(
                    label: 'Check-out',
                    date: _formatDate(_checkOut),
                    icon: Icons.logout_outlined,
                    onTap: () => _pickDate(false),
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 80.ms, duration: 350.ms),
            const SizedBox(height: WidgetXSpacing.md),

            // Guests
            WidgetXCard(
              body: Row(
                children: [
                  const Icon(Icons.people_outline, size: 20),
                  const SizedBox(width: WidgetXSpacing.md),
                  Expanded(
                    child: Text('Guests',
                        style: tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _guests > 1
                        ? () => setState(() => _guests--)
                        : null,
                  ),
                  Text('$_guests',
                      style: tt.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _guests < 6
                        ? () => setState(() => _guests++)
                        : null,
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 120.ms, duration: 350.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Room selection ───────────────────────────────────────────────
            Text('Select Room',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: WidgetXSpacing.md),
            ..._rooms.asMap().entries.map(
                  (e) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: WidgetXSpacing.md),
                    child: _RoomCard(
                      room: e.value,
                      isSelected: _selectedRoom == e.key,
                      onTap: () =>
                          setState(() => _selectedRoom = e.key),
                    ).animate().fadeIn(
                          delay: Duration(
                              milliseconds: 160 + e.key * 60),
                          duration: 350.ms,
                        ),
                  ),
                ),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── Booking summary ──────────────────────────────────────────────
            Text('Booking Summary',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: WidgetXSpacing.md),
            WidgetXCard(
              body: Column(
                children: [
                  WidgetXKeyValueRow(
                    label: 'Room',
                    value: _rooms[_selectedRoom].name,
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  WidgetXKeyValueRow(
                    label: 'Check-in',
                    value: _formatDate(_checkIn),
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  WidgetXKeyValueRow(
                    label: 'Check-out',
                    value: _formatDate(_checkOut),
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  WidgetXKeyValueRow(
                    label: 'Nights',
                    value: '$_nights',
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  WidgetXKeyValueRow(
                    label: 'Guests',
                    value: '$_guests',
                  ),
                  const WidgetXDivider(),
                  WidgetXKeyValueRow(
                    label: 'Total',
                    value: '\$$_total',
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 350.ms),
            const SizedBox(height: WidgetXSpacing.xl),

            // ── CTA ──────────────────────────────────────────────────────────
            WidgetXButton(
              label: 'Confirm Booking — \$$_total',
              onPressed: () => showWidgetXSnackbar(
                context: context,
                message: 'Booking confirmed! You will receive a confirmation email.',
                variant: WidgetXSnackbarVariant.success,
              ),
              variant: WidgetXButtonVariant.primary,
              isFullWidth: true,
              leadingIcon: const Icon(Icons.check_circle_outline, size: 18),
            )
                .animate()
                .fadeIn(delay: 360.ms, duration: 350.ms)
                .slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _Room {
  const _Room({
    required this.name,
    required this.price,
    required this.beds,
    required this.sqft,
    required this.amenities,
  });
  final String name;
  final int price, beds, sqft;
  final List<String> amenities;
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.label,
    required this.date,
    required this.icon,
    required this.onTap,
  });
  final String label, date;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(WidgetXRadius.md),
      child: Container(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(WidgetXRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Text(label,
                    style: tt.labelSmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: WidgetXSpacing.xs),
            Text(date,
                style:
                    tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({
    required this.room,
    required this.isSelected,
    required this.onTap,
  });
  final _Room room;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return WidgetXCard(
      isSelected: isSelected,
      onTap: onTap,
      semanticDescription: '${room.name}, \$${room.price} per night',
      body: Row(
        children: [
          // Room icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? cs.primaryContainer : cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(WidgetXRadius.sm),
            ),
            child: Icon(Icons.bed_outlined,
                color: isSelected ? cs.primary : cs.onSurfaceVariant, size: 28),
          ),
          const SizedBox(width: WidgetXSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.name,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: WidgetXSpacing.xxs),
                Wrap(
                  spacing: WidgetXSpacing.sm,
                  children: [
                    _RoomDetail(
                        icon: Icons.king_bed_outlined,
                        text: '${room.beds} bed'),
                    _RoomDetail(
                        icon: Icons.square_foot_outlined,
                        text: '${room.sqft} sqft'),
                  ],
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: room.amenities
                      .take(3)
                      .map((a) => WidgetXChip(label: a))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: WidgetXSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${room.price}',
                  style: tt.titleMedium
                      ?.copyWith(
                          color: cs.primary, fontWeight: FontWeight.w700)),
              Text('/night',
                  style:
                      tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoomDetail extends StatelessWidget {
  const _RoomDetail({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: cs.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(text,
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}
