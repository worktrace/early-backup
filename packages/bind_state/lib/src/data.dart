import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

abstract class SingleValueNotifierState<S extends StatefulWidget, T>
    extends State<S> {
  ValueNotifier<T> get notifier;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    notifier.addListener(() => setState(() {}));
  }

  @override
  @mustCallSuper
  void dispose() {
    notifier.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ValueNotifier<T>>('notifier', notifier));
  }
}
