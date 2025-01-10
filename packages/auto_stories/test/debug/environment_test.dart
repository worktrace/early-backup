import 'package:auto_stories/debug.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('ensure text', (t) async {
    const message = 'message';
    await t.pumpWidget(message.asText().ensureText());
    expect(find.text(message), findsOneWidget);
  });
}
