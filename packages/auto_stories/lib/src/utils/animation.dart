import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
