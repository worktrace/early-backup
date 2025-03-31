import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_reuse/binding.dart';
import 'package:state_reuse/test.dart';
import 'package:wrap/modifier.dart';
import 'package:wrap/test.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('inherit data', (t) async {
    const message = 'message';
    await t.pumpWidget(inheritProbe.center().inherit(message).ensureText());
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('inherit update', (t) async {
    const before = 'before';
    const after = 'after';
    const button = 'button';
    const widget = InheritUpdate(before: before, after: after, button: button);
    await t.pumpWidget(widget.ensureText());
    expect(find.text(before), findsOneWidget);
    expect(find.text(button), findsOneWidget);

    await t.tap(find.text(button));
    await t.pump();
    expect(find.text(after), findsOneWidget);
  });
}

final inheritProbe = Builder(
  builder: (context) {
    return context.find<String>()!.asText();
  },
);

class InheritUpdate extends UpdateTester {
  const InheritUpdate({
    super.key,
    required super.before,
    required super.after,
    required super.button,
  });

  @override
  State<InheritUpdate> createState() => _InheritUpdateState();
}

class _InheritUpdateState extends UpdateTesterState<InheritUpdate> {
  @override
  Widget buttonBuilder(BuildContext context) {
    return widget.button.asText().gesture(
      onTap: () => context.update<String>(widget.after),
    );
  }

  @override
  Widget build(BuildContext context) => [inheritProbe, button]
      .asColumn()
      .center
      .inherit(message)
      .inheritUpdate<String>((value) => message = value);
}
