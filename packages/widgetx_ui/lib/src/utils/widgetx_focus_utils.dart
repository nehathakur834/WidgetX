import 'package:flutter/material.dart';
import '../foundations/colors/widgetx_colors.dart';

/// Utilities for accessibility and focus management.
abstract final class WidgetXFocusUtils {
  /// Returns a [FocusNode] that triggers [onFocus] / [onBlur] callbacks.
  static FocusNode createFocusNode({
    VoidCallback? onFocus,
    VoidCallback? onBlur,
    String? debugLabel,
  }) {
    final node = FocusNode(debugLabel: debugLabel);
    node.addListener(() {
      if (node.hasFocus) {
        onFocus?.call();
      } else {
        onBlur?.call();
      }
    });
    return node;
  }

  /// Returns a decoration suitable for showing a visible focus ring
  /// around a [Widget] when it is focused.
  static BoxDecoration focusRingDecoration({
    Color? color,
    double width = 2,
    double radius = 8,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: color ?? WidgetXColors.focus,
        width: width,
      ),
    );
  }

  /// Ensures [focusNode] requests focus on the next frame.
  static void requestFocusNextFrame(FocusNode focusNode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }
}
