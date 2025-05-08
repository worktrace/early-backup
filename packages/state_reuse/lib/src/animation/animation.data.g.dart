// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'animation.dart';

extension CopyAnimationData on AnimationData {
  AnimationData copyWith({Duration? duration, Curve? curve}) {
    return AnimationData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

extension CopyAnimationDefibrillation on AnimationDefibrillation {
  AnimationDefibrillation copyWith({
    Duration? duration,
    Curve? curve,
    Duration? defibrillation,
  }) {
    return AnimationDefibrillation(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      defibrillation: defibrillation ?? this.defibrillation,
    );
  }
}
