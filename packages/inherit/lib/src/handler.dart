import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';

import 'inherit.dart';

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
  Widget build(BuildContext context) => widget
      .builder(context, _data) //
      .inherit(_data)
      .inheritUpdate(updateData);
}
