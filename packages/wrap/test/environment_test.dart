import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('wrap media', (t) async {
    const message = 'message';
    final probe = Builder(
      builder: (context) => message
          .asText()
          .center()
          .textDirection(TextDirection.ltr)
          .mediaAsView(context),
    );
    await t.pumpWidget(probe);
    expect(find.text(message), findsOneWidget);
  });
}
