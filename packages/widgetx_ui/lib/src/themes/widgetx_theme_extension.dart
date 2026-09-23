import 'package:flutter/material.dart';
import '../foundations/colors/widgetx_colors.dart';
import '../foundations/spacing/widgetx_spacing.dart';
import '../foundations/radius/widgetx_radius.dart';
import '../foundations/motion/widgetx_motion.dart';

/// Theme extension that carries WidgetX-specific design tokens into
/// Flutter's [ThemeData], making them available via
/// `Theme.of(context).extension<WidgetXThemeExtension>()`.
class WidgetXThemeExtension extends ThemeExtension<WidgetXThemeExtension> {
  const WidgetXThemeExtension({
    required this.primaryColor,
    required this.secondaryColor,
    required this.successColor,
    required this.warningColor,
    required this.infoColor,
    required this.surfaceContainerColor,
    required this.outlineColor,
    required this.disabledColor,
    required this.focusColor,
    this.defaultPadding = WidgetXSpacing.md,
    this.defaultRadius = WidgetXRadius.md,
    this.defaultDuration = WidgetXMotion.normal,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color successColor;
  final Color warningColor;
  final Color infoColor;
  final Color surfaceContainerColor;
  final Color outlineColor;
  final Color disabledColor;
  final Color focusColor;
  final double defaultPadding;
  final double defaultRadius;
  final Duration defaultDuration;

  /// Light theme extension values.
  static const WidgetXThemeExtension light = WidgetXThemeExtension(
    primaryColor: WidgetXColors.primary,
    secondaryColor: WidgetXColors.secondary,
    successColor: WidgetXColors.success,
    warningColor: WidgetXColors.warning,
    infoColor: WidgetXColors.info,
    surfaceContainerColor: WidgetXColors.surfaceContainer,
    outlineColor: WidgetXColors.outline,
    disabledColor: WidgetXColors.disabled,
    focusColor: WidgetXColors.focus,
  );

  /// Dark theme extension values.
  static const WidgetXThemeExtension dark = WidgetXThemeExtension(
    primaryColor: WidgetXColors.primary,
    secondaryColor: WidgetXColors.secondary,
    successColor: WidgetXColors.success,
    warningColor: WidgetXColors.warning,
    infoColor: WidgetXColors.info,
    surfaceContainerColor: WidgetXColors.surfaceContainerDark,
    outlineColor: WidgetXColors.outlineDark,
    disabledColor: WidgetXColors.disabled,
    focusColor: WidgetXColors.focus,
  );

  @override
  WidgetXThemeExtension copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? successColor,
    Color? warningColor,
    Color? infoColor,
    Color? surfaceContainerColor,
    Color? outlineColor,
    Color? disabledColor,
    Color? focusColor,
    double? defaultPadding,
    double? defaultRadius,
    Duration? defaultDuration,
  }) {
    return WidgetXThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      surfaceContainerColor:
          surfaceContainerColor ?? this.surfaceContainerColor,
      outlineColor: outlineColor ?? this.outlineColor,
      disabledColor: disabledColor ?? this.disabledColor,
      focusColor: focusColor ?? this.focusColor,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultRadius: defaultRadius ?? this.defaultRadius,
      defaultDuration: defaultDuration ?? this.defaultDuration,
    );
  }

  @override
  WidgetXThemeExtension lerp(WidgetXThemeExtension? other, double t) {
    if (other == null) return this;
    return WidgetXThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      surfaceContainerColor:
          Color.lerp(surfaceContainerColor, other.surfaceContainerColor, t)!,
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      focusColor: Color.lerp(focusColor, other.focusColor, t)!,
      defaultPadding: defaultPadding,
      defaultRadius: defaultRadius,
      defaultDuration: defaultDuration,
    );
  }
}
