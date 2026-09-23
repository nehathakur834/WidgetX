import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_x/app/showcase_app.dart';

void main() {
  testWidgets('ShowcaseApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ShowcaseApp()),
    );
    // Flush flutter_animate timers and any other pending async work.
    await tester.pumpAndSettle();
    expect(find.byType(ShowcaseApp), findsOneWidget);
  });
}
