import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension FindContext on BuildContext {
  T? find<T>() => dependOnInheritedWidgetOfExactType<Inherit<T>>()?.data;
  void update<T>(T data) {
    dependOnInheritedWidgetOfExactType<InheritUpdate<T>>()?.onChange(data);
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

  InheritUpdate<T> inheritUpdate<T>(ValueChanged<T> onChange, {Key? key}) {
    return InheritUpdate<T>(
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

typedef InheritUpdate<T> = _InheritUpdate<T, ValueChanged<T>>;

class _InheritUpdate<T, U extends ValueChanged<T>> extends InheritedWidget {
  const _InheritUpdate({
    super.key,
    required this.onChange,
    required super.child,
  });

  final U onChange;

  @override
  bool updateShouldNotify(covariant InheritUpdate<T> oldWidget) {
    return onChange != oldWidget.onChange;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final c = onChange;
    properties.add(ObjectFlagProperty<ValueChanged<T>>.has('onChange', c));
  }
}
