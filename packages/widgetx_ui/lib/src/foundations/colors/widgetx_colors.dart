import 'package:flutter/material.dart';

/// Semantic color tokens for WidgetX UI.
///
/// Use these tokens instead of hardcoded [Color] values
/// to ensure theme consistency across the design system.
abstract final class WidgetXColors {
  // ── Brand / Primary ────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryVariant = Color(0xFF1D4ED8);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ── Secondary ──────────────────────────────────────────────────────────────
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryVariant = Color(0xFF5B21B6);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // ── Surface ────────────────────────────────────────────────────────────────
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceVariant = Color(0xFFE2E8F0);
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF64748B);

  // ── Background ─────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8FAFC);
  static const Color onBackground = Color(0xFF1E293B);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFF59E0B);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color info = Color(0xFF3B82F6);
  static const Color onInfo = Color(0xFFFFFFFF);

  // ── Outline ────────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFFCBD5E1);
  static const Color outlineVariant = Color(0xFFE2E8F0);

  // ── Interaction states ─────────────────────────────────────────────────────
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color onDisabled = Color(0xFF94A3B8);
  static const Color focus = Color(0xFF3B82F6);
  static const Color hover = Color(0x143B82F6);
  static const Color pressed = Color(0x293B82F6);

  // ── Dark surface overrides ─────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceContainerDark = Color(0xFF0F172A);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color onSurfaceDark = Color(0xFFF1F5F9);
  static const Color onSurfaceVariantDark = Color(0xFF94A3B8);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color onBackgroundDark = Color(0xFFF1F5F9);
  static const Color outlineDark = Color(0xFF475569);
}
