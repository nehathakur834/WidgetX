import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  group('WidgetXBanner', () {
    testWidgets('renders message', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXBanner(message: 'Test message')),
      );
      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('renders title if provided', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXBanner(
          title: 'Success!',
          message: 'Saved',
          variant: WidgetXBannerVariant.success,
        )),
      );
      expect(find.text('Success!'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);
    });

    testWidgets('calls onDismiss when close tapped', (tester) async {
      var dismissed = false;
      await tester.pumpWidget(
        _wrap(WidgetXBanner(
          message: 'Dismiss me',
          onDismiss: () => dismissed = true,
        )),
      );
      await tester.tap(find.byIcon(Icons.close));
      expect(dismissed, isTrue);
    });

    testWidgets('does not show close button when onDismiss is null',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXBanner(message: 'No dismiss')),
      );
      expect(find.byIcon(Icons.close), findsNothing);
    });
  });

  group('WidgetXCircularProgress', () {
    testWidgets('renders indicator', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXCircularProgress()),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('WidgetXLinearProgress', () {
    testWidgets('renders indicator', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXLinearProgress()),
      );
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('renders with value', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXLinearProgress(value: 0.5)),
      );
      final indicator = tester.widget<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator));
      expect(indicator.value, 0.5);
    });
  });

  group('WidgetXSkeleton', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXSkeleton(width: 100, height: 20)),
      );
      expect(find.byType(WidgetXSkeleton), findsOneWidget);
    });

    testWidgets('WidgetXSkeletonText renders correct number of lines',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXSkeletonText(lines: 3)),
      );
      expect(find.byType(WidgetXSkeleton), findsNWidgets(3));
    });
  });

  group('WidgetXEmptyState', () {
    testWidgets('renders title and description', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXEmptyState(
          title: 'Nothing here',
          description: 'Add something to get started.',
        )),
      );
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Add something to get started.'), findsOneWidget);
    });

    testWidgets('shows error icon when isError is true', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXEmptyState(
          title: 'Error',
          isError: true,
        )),
      );
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
