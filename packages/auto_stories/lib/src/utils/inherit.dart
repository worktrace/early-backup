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

class InheritUpdate<T> extends InheritedWidget {
  const InheritUpdate({
    super.key,
    required this.onChange,
    required super.child,
  });

  final ValueChanged<T> onChange;

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

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

class Handler<T> extends StatefulWidget {
  const Handler({
    super.key,
    required this.data,
    this.onChange,
    required this.builder,
  });

  final T data;
  final ValueChanged<T>? onChange;
  final DataBuilder<T> builder;

  @override
  State<Handler<T>> createState() => _HandlerState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<T>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<T>('data', data))
      ..add(ObjectFlagProperty<DataBuilder<T>>.has('builder', builder));
  }
}

class _HandlerState<T> extends State<Handler<T>> {
  late T _data = widget.data;
  void updateData(T value) {
    if (value == _data) return;
    setState(() => _data = value);
    widget.onChange?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return widget
        .builder(context, _data)
        .inherit(_data)
        .inheritUpdate(updateData);
  }
}
