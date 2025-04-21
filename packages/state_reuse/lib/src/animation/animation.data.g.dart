// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'animation.dart';

mixin _$Copy$AnimationData implements Copyable {
  AnimationData get _template => this as AnimationData;

  @override
  AnimationData copyWith({Duration? duration, Curve? curve}) {
    return AnimationData(
      duration: duration ?? _template.duration,
      curve: curve ?? _template.curve,
    );
  }
}

mixin _$Copy$AnimationDefibrillation implements Copyable {
  AnimationDefibrillation get _template => this as AnimationDefibrillation;

  @override
  AnimationDefibrillation copyWith({
    Duration? duration,
    Curve? curve,
    Duration? defibrillation,
  }) {
    return AnimationDefibrillation(
      duration: duration ?? _template.duration,
      curve: curve ?? _template.curve,
      defibrillation: defibrillation ?? _template.defibrillation,
    );
  }
}
