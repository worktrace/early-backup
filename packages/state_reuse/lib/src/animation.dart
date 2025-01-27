import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding.dart';

class AnimationData {
  const AnimationData({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final Duration duration;
  final Curve curve;

  AnimationData copyWith({Duration? duration, Curve? curve}) {
    return AnimationData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

const kHoverDefibrillation = Duration(milliseconds: 35);

class AnimationDefibrillation extends AnimationData {
  const AnimationDefibrillation({
    super.duration,
    super.curve,
    this.defibrillation = kHoverDefibrillation,
  });

  final Duration defibrillation;
}

extension AnimationUtils on AnimationController {
  TickerFuture animateAs(AnimationData animation, double target) {
    return animateTo(
      target,
      duration: animation.duration,
      curve: animation.curve,
    );
  }

  TickerFuture animateToEnd(AnimationData animation) {
    if (value == upperBound) return TickerFuture.complete();
    return animateAs(animation, upperBound);
  }

  TickerFuture animateToStart(AnimationData animation) {
    if (value == lowerBound) return TickerFuture.complete();
    return animateAs(animation, lowerBound);
  }
}

abstract class SingleAnimationWidget extends StatefulWidget {
  const SingleAnimationWidget({
    super.key,
    this.animation = const AnimationData(),
  });

  final AnimationData animation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimationData>('animation', animation));
  }
}

/// The animation [controller] had been bind with [setState] callback here.
/// You may consider [SingleAnimationStateBare] instead.
abstract class SingleAnimationState<S extends StatefulWidget>
    extends SingleAnimationStateBare<S> {
  /// Encapsulate [setState] for [dispose] to call the same one.
  void _setState() => setState(() {});

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    controller.addListener(_setState);
  }

  @override
  @mustCallSuper
  void dispose() {
    controller.removeListener(_setState);
    super.dispose();
  }
}

/// The animation [controller] had not been bind with [setState] callback here.
/// You may consider [SingleAnimationState] instead.
abstract class SingleAnimationStateBare<S extends StatefulWidget>
    extends State<S> with SingleTickerProviderStateMixin {
  late final AnimationController controller = setupController();

  AnimationController setupController() => AnimationController(vsync: this);

  @override
  @mustCallSuper
  void initState() {
    super.initState();
  }

  @override
  @mustCallSuper
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  @mustCallSuper
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final c = controller;
    properties.add(DiagnosticsProperty<AnimationController>('controller', c));
  }
}

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
