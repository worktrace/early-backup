import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding.dart';
import 'inherit.dart';

typedef Handler<T> = _Handler<T, DataBuilder<T>, ValueChanged<T>>;

class _Handler<T, U extends DataBuilder<T>, V extends ValueChanged<T>>
    extends StatefulWidget {
  const _Handler({
    super.key,
    required this.data,
    this.onChange,
    required this.builder,
  });

  final T data;
  final V? onChange;
  final U builder;

  @override
  State<_Handler<T, U, V>> createState() => _HandlerState<T, U, V>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<T>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<T>('data', data))
      ..add(ObjectFlagProperty<DataBuilder<T>>.has('builder', builder));
  }
}

class _HandlerState<T, U extends DataBuilder<T>, V extends ValueChanged<T>>
    extends State<_Handler<T, U, V>> {
  late T _data = widget.data;
  void updateData(T value) {
    if (value == _data) return;
    setState(() => _data = value);
    (widget.onChange as ValueChanged<T>?)?.call(value);
  }

  @override
  Widget build(BuildContext context) => widget
      .builder(context, _data) //
      .inherit(_data)
      .inheritUpdate(updateData);
}
