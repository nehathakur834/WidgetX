import 'package:flutter/material.dart';

/// Shadow / elevation tokens for WidgetX UI.
abstract final class WidgetXShadows {
  /// No shadow — flat surfaces.
  static const List<BoxShadow> none = [];

  /// Subtle shadow — cards, popovers.
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// Medium shadow — modals, dropdowns.
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Large shadow — dialogs, overlays.
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}
