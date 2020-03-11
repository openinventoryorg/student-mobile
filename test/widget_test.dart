import 'package:flutter_test/flutter_test.dart';

import 'package:openinventory_student_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BaseApp());

    // Verify that the title is showing correctly.
    expect(find.text('Open Inventory'), findsOneWidget);
  });
}
