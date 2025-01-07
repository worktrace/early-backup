import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension FindContext on BuildContext {
  T? find<T>() => dependOnInheritedWidgetOfExactType<Inherit<T>>()?.data;
  void update<T>(T data) {
    dependOnInheritedWidgetOfExactType<InheritUpdater<T>>()?.onChange(data);
  }
}

extension WrapInherit on Widget {
  Inherit<T> inherit<T>(T data, {Key? key}) {
    return Inherit<T>(
      key: key,
      data: data,
      child: this,
    );
  }

  InheritUpdater<T> inheritUpdater<T>(ValueChanged<T> onChange, {Key? key}) {
    return InheritUpdater<T>(
      key: key,
      onChange: onChange,
      child: this,
    );
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

class InheritUpdater<T> extends InheritedWidget {
  const InheritUpdater({
    super.key,
    required this.onChange,
    required super.child,
  });

  final ValueChanged<T> onChange;

  @override
  bool updateShouldNotify(covariant InheritUpdater<T> oldWidget) {
    return onChange != oldWidget.onChange;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final c = onChange;
    properties.add(ObjectFlagProperty<ValueChanged<T>>.has('onChange', c));
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
