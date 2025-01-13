import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'inherit.dart';

typedef _DataBuilder<T> = Widget Function(BuildContext context, T data);

class Handler<T> extends StatefulWidget {
  const Handler({
    super.key,
    required this.data,
    this.onChange,
    required this.builder,
  });

  final T data;
  final ValueChanged<T>? onChange;
  final Widget Function(BuildContext context, T data) builder;

  @override
  State<Handler<T>> createState() => _HandlerState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<T>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<T>('data', data))
      ..add(ObjectFlagProperty<_DataBuilder<T>>.has('builder', builder));
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
