import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class UpdateTester extends StatefulWidget {
  const UpdateTester({
    super.key,
    required this.before,
    required this.after,
    required this.button,
  });

  final String before;
  final String after;
  final String button;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('before', before))
      ..add(StringProperty('after', after))
      ..add(StringProperty('button', button));
  }
}

abstract class UpdateTesterState<T extends UpdateTester> extends State<T> {
  late String _message = widget.before;
  String get message => _message;
  set message(String value) {
    if (_message != value) setState(() => _message = value);
  }

  Widget buttonBuilder(BuildContext context);
  Widget get button => Builder(builder: buttonBuilder);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}
