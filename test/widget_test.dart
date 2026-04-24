import 'package:flutter_test/flutter_test.dart';
import 'package:yugioh/main.dart';

void main() {
  testWidgets('Game screen loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const YugiohApp());

    // Verify that the Game Screen is loaded
    expect(find.text('Game Screen'), findsOneWidget);
    expect(find.text('Your Hand'), findsOneWidget);
  });
}
