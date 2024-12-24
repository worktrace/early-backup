import 'package:auto_stories/auto_stories.dart';
import 'package:auto_stories/debug.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('inherit data', (t) async {
    const message = 'message';
    await t.pumpWidget(inheritProbe.center().inherit(message).ensureText());
    expect(find.text(message), findsOneWidget);
  });
}

final inheritProbe = Builder(
  builder: (context) {
    return context.find<String>()!.asText();
  },
);

class InheritUpdate extends StatefulWidget {
  const InheritUpdate({
    super.key,
    required this.beforeMessage,
    required this.afterMessage,
    required this.buttonName,
  });

  final String beforeMessage;
  final String afterMessage;
  final String buttonName;

  @override
  State<InheritUpdate> createState() => _InheritUpdateState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('beforeMessage', beforeMessage))
      ..add(StringProperty('afterMessage', afterMessage))
      ..add(StringProperty('buttonName', buttonName));
  }
}

class _InheritUpdateState extends State<InheritUpdate> {
  late String _message = widget.beforeMessage;
  String get message => _message;
  set message(String value) {
    if (_message != value) setState(() => _message = value);
  }

  @override
  Widget build(BuildContext context) {
    final GestureDetector button = widget.buttonName
        .asText() //
        .gesture(onTap: () => message = widget.afterMessage);

    return [inheritProbe, button].asColumn().center().inherit(message);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}
