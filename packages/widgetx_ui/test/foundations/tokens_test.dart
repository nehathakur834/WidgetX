import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  group('WidgetXSpacing', () {
    test('spacing values are ordered ascending', () {
      expect(WidgetXSpacing.xxs, lessThan(WidgetXSpacing.xs));
      expect(WidgetXSpacing.xs, lessThan(WidgetXSpacing.sm));
      expect(WidgetXSpacing.sm, lessThan(WidgetXSpacing.md));
      expect(WidgetXSpacing.md, lessThan(WidgetXSpacing.lg));
      expect(WidgetXSpacing.lg, lessThan(WidgetXSpacing.xl));
      expect(WidgetXSpacing.xl, lessThan(WidgetXSpacing.xxl));
      expect(WidgetXSpacing.xxl, lessThan(WidgetXSpacing.xxxl));
    });

    test('base spacing value is 8', () {
      expect(WidgetXSpacing.sm, equals(8.0));
    });
  });

  group('WidgetXRadius', () {
    test('radius values are ordered ascending', () {
      expect(WidgetXRadius.xs, lessThan(WidgetXRadius.sm));
      expect(WidgetXRadius.sm, lessThan(WidgetXRadius.md));
      expect(WidgetXRadius.md, lessThan(WidgetXRadius.lg));
      expect(WidgetXRadius.lg, lessThan(WidgetXRadius.xl));
      expect(WidgetXRadius.xl, lessThan(WidgetXRadius.xxl));
      expect(WidgetXRadius.xxl, lessThan(WidgetXRadius.full));
    });
  });

  group('WidgetXBreakpoints', () {
    test('mobile is 0', () => expect(WidgetXBreakpoints.mobile, 0));
    test('tablet is 600', () => expect(WidgetXBreakpoints.tablet, 600));
    test('desktop is 1024', () => expect(WidgetXBreakpoints.desktop, 1024));
  });

  group('WidgetXMotion', () {
    test('fast < normal < slow < emphasis', () {
      expect(WidgetXMotion.fast.inMilliseconds,
          lessThan(WidgetXMotion.normal.inMilliseconds));
      expect(WidgetXMotion.normal.inMilliseconds,
          lessThan(WidgetXMotion.slow.inMilliseconds));
      expect(WidgetXMotion.slow.inMilliseconds,
          lessThan(WidgetXMotion.emphasis.inMilliseconds));
    });
  });

  group('WidgetXColors', () {
    test('primary color is defined', () {
      expect(WidgetXColors.primary.toARGB32(), isNonZero);
    });
    test('error color is fully opaque', () {
      expect(WidgetXColors.error.toARGB32() >> 24, equals(0xFF));
    });
  });
}
