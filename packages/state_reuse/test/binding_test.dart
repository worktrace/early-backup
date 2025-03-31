import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_reuse/binding.dart';
import 'package:wrap/debug.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('bind data update', (t) async {
    const before = 'before';
    const after = 'after';
    final message = ValueNotifier(before);
    await t.pumpWidget(UpdateData(message: message).ensureText());
    expect(find.text(before), findsOneWidget);

    message.value = after;
    await t.pump();
    expect(find.text(after), findsOneWidget);
  });
}

class UpdateData extends StatefulWidget {
  const UpdateData({super.key, required this.message});

  final ValueNotifier<String> message;

  @override
  State<UpdateData> createState() => _UpdateDataState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final m = message;
    properties.add(DiagnosticsProperty<ValueNotifier<String>>('message', m));
  }
}

class _UpdateDataState extends SingleValueNotifierState<UpdateData, String> {
  @override
  ValueNotifier<String> get notifier => widget.message;

  @override
  Widget build(BuildContext context) {
    return notifier.value.asText().center();
  }
}
