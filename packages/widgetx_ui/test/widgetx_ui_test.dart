import 'package:flutter_test/flutter_test.dart';

import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  test('WidgetXSpacing values are correct', () {
    expect(WidgetXSpacing.xs, 4);
    expect(WidgetXSpacing.sm, 8);
    expect(WidgetXSpacing.md, 16);
    expect(WidgetXSpacing.lg, 24);
  });

  test('WidgetXBreakpoints values are correct', () {
    expect(WidgetXBreakpoints.mobile, 0);
    expect(WidgetXBreakpoints.tablet, 600);
    expect(WidgetXBreakpoints.desktop, 1024);
    expect(WidgetXBreakpoints.widescreen, 1440);
  });

  test('WidgetXBreakpointConfig uses defaults', () {
    const config = WidgetXBreakpointConfig();
    expect(config.tablet, WidgetXBreakpoints.tablet);
    expect(config.desktop, WidgetXBreakpoints.desktop);
    expect(config.widescreen, WidgetXBreakpoints.widescreen);
  });
}
