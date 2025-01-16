import 'package:bang_lerp/bang_lerp.dart';
import 'package:bind_state/bind_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'animation.dart';

class SingleAnimation<T> extends SingleAnimationWidget {
  const SingleAnimation({
    super.key,
    super.animation,
    required this.data,
    required this.lerp,
    required this.builder,
  });

  final T data;
  final Lerp<T> lerp;
  final DataBuilder<T> builder;

  @override
  State<SingleAnimation<T>> createState() => _SingleAnimationState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('data', data))
      ..add(ObjectFlagProperty<Lerp<T>>.has('lerp', lerp))
      ..add(ObjectFlagProperty<DataBuilder<T>>.has('builder', builder));
  }
}

class _SingleAnimationState<T>
    extends SingleAnimationStateBare<SingleAnimation<T>> {
  late AnimationTween<T> _tween = AnimationTween(
    begin: widget.data,
    end: widget.data,
  );

  late T _data = widget.data;
  T get data => _data;
  set data(T value) {
    if (value != _data) setState(() => _data = value);
  }

  void updateData() => data = _tween.of(controller, widget.lerp);

  @override
  void initState() {
    super.initState();
    controller.addListener(updateData);
  }

  @override
  void dispose() {
    controller.removeListener(updateData);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SingleAnimation<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _tween = AnimationTween(begin: data, end: widget.data);
      controller
        ..reset()
        ..animateAs(widget.animation, 1);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, data);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('data', data));
  }
}
