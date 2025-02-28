import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inherit/debug.dart';
import 'package:inherit/inherit.dart';
import 'package:modifier/modifier.dart';
import 'package:wrap/debug.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('handler update', (t) async {
    const before = 'before';
    const after = 'after';
    const button = 'button';
    const widget = HandlerUpdate(
      before: before,
      after: after,
      button: button,
    );
    await t.pumpWidget(widget.ensureText());
    expect(find.text(before), findsOneWidget);
    expect(find.text(button), findsOneWidget);

    await t.tap(find.text(button));
    await t.pump();
    expect(find.text(after), findsOneWidget);
  });
}

class HandlerUpdate extends UpdateTester {
  const HandlerUpdate({
    super.key,
    required super.before,
    required super.after,
    required super.button,
  });

  @override
  State<HandlerUpdate> createState() => _HandlerUpdateState();
}

class _HandlerUpdateState extends UpdateTesterState<HandlerUpdate> {
  @override
  Widget buttonBuilder(BuildContext context) {
    return widget.button
        .asText()
        .gesture(onTap: () => context.update(widget.after));
  }

  @override
  Widget build(BuildContext context) {
    return Handler(
      data: message,
      builder: (context, data) => [data.asText(), button].asColumn().center,
    );
  }
}
