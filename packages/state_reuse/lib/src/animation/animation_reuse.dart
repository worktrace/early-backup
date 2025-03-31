import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';

import 'animation.dart';
import 'lerp.dart';

typedef SingleAnimation<T> = _SingleAnimation<T, DataBuilder<T>, Lerp<T>>;

class _SingleAnimation<T, U extends DataBuilder<T>, L extends Lerp<T>>
    extends SingleAnimationWidget {
  const _SingleAnimation({
    super.key,
    super.animation,
    required this.data,
    required this.lerp,
    required this.builder,
  });

  final T data;
  final L lerp;
  final U builder;

  @override
  State<_SingleAnimation<T, U, L>> createState() =>
      _SingleAnimationState<T, U, L>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('data', data))
      ..add(ObjectFlagProperty<Lerp<T>>.has('lerp', lerp))
      ..add(ObjectFlagProperty<DataBuilder<T>>.has('builder', builder));
  }
}

class _SingleAnimationState<T, U extends DataBuilder<T>, L extends Lerp<T>>
    extends SingleAnimationStateBare<_SingleAnimation<T, U, L>> {
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
  void didUpdateWidget(covariant _SingleAnimation<T, U, L> oldWidget) {
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
