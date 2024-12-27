import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension FindContext on BuildContext {
  T? find<T>() => dependOnInheritedWidgetOfExactType<Inherit<T>>()?.data;
}

extension WrapInherit on Widget {
  Inherit<T> inherit<T>(T data, {Key? key}) {
    return Inherit<T>(key: key, data: data, child: this);
  }
}

class Inherit<T> extends InheritedWidget {
  const Inherit({super.key, required this.data, required super.child});

  final T data;

  @override
  bool updateShouldNotify(covariant Inherit<T> oldWidget) {
    return data != oldWidget.data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('data', data));
  }
}

abstract class WidgetBindingState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
