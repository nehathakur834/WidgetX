import 'package:flutter_test/flutter_test.dart';
import 'package:showcase/app/showcase_app.dart';

void main() {
  testWidgets('ShowcaseApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShowcaseApp());
    expect(find.byType(ShowcaseApp), findsOneWidget);
  });
}
