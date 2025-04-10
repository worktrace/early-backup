import 'package:data_build/annotation.dart';
import 'package:flutter/widgets.dart';

part 'animation.data.g.dart';

class AnimationData {
  @copy
  const AnimationData({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final Duration duration;
  final Curve curve;

  AnimationData copyWith({Duration? duration, Curve? curve}) => AnimationData(
    duration: duration ?? this.duration,
    curve: curve ?? this.curve,
  );
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
