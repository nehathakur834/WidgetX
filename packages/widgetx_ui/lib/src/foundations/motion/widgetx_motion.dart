import 'package:flutter/material.dart';

/// Motion / animation tokens for WidgetX UI.
///
/// Components should use these constants rather than hardcoded
/// durations and curves to maintain animation consistency.
abstract final class WidgetXMotion {
  // ── Durations ──────────────────────────────────────────────────────────────

  /// 100ms — micro-interactions (ripples, button press).
  static const Duration fast = Duration(milliseconds: 100);

  /// 200ms — most UI transitions.
  static const Duration normal = Duration(milliseconds: 200);

  /// 350ms — layout shifts, modal entry.
  static const Duration slow = Duration(milliseconds: 350);

  /// 500ms — emphasis animations.
  static const Duration emphasis = Duration(milliseconds: 500);

  // ── Curves ─────────────────────────────────────────────────────────────────

  /// Standard easing — most transitions.
  static const Curve standard = Curves.easeInOut;

  /// Deceleration — elements entering the screen.
  static const Curve decelerate = Curves.easeOut;

  /// Acceleration — elements leaving the screen.
  static const Curve accelerate = Curves.easeIn;

  /// Spring-like overshoot — emphasis, selection.
  static const Curve spring = Curves.elasticOut;
}
