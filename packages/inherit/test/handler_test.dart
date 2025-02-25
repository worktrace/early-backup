import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wrap/debug.dart';

void main() {
  testWidgets('handler update', (t) async {
    await t.pumpWidget(const HandlerUpdate().ensureText());
  });
}

class HandlerUpdate extends StatefulWidget {
  const HandlerUpdate({super.key});

  @override
  State<HandlerUpdate> createState() => _HandlerUpdateState();
}

class _HandlerUpdateState extends State<HandlerUpdate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
