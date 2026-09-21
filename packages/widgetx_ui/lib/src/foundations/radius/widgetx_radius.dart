import 'package:flutter/material.dart';

/// Border-radius tokens for WidgetX UI.
abstract final class WidgetXRadius {
  /// 4px — small controls (chips, tags).
  static const double xs = 4;

  /// 8px — buttons, text fields.
  static const double sm = 8;

  /// 12px — cards, containers.
  static const double md = 12;

  /// 16px — dialogs, bottom sheets.
  static const double lg = 16;

  /// 24px — pills, badges.
  static const double xl = 24;

  /// 32px — large containers.
  static const double xxl = 32;

  /// Fully circular.
  static const double full = 9999;

  // Convenience BorderRadius values
  static BorderRadius get xsAll => BorderRadius.circular(xs);
  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
  static BorderRadius get xxlAll => BorderRadius.circular(xxl);
  static BorderRadius get fullAll => BorderRadius.circular(full);
}
