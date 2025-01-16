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
