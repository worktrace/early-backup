import 'animation.dart';

const kHoverDefibrillation = Duration(milliseconds: 35);

class AnimationDefibrillation extends AnimationData {
  const AnimationDefibrillation({
    super.duration,
    super.curve,
    this.defibrillation = kHoverDefibrillation,
  });

  final Duration defibrillation;
}
