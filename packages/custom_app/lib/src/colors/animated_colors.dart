import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:custom_app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';

const colorsAnimation = AnimationData(duration: Duration(milliseconds: 345));

extension WrapAnimatedColors on Widget {
  SingleAnimation<T> animatedColors<T extends ColorsBase>(
    T colors,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = const AnimationData(),
  }) => SingleAnimation(
    key: key,
    animation: animation,
    data: colors,
    lerp: lerp,
    builder: colorsAs<T>,
  );

  Widget maybeAnimatedColors<T extends ColorsBase>(
    T colors, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = const AnimationData(),
  }) {
    return lerp != null
        ? animatedColors<T>(colors, lerp, key: key, animation: animation)
        : this.colors(colors, key: key);
  }

  AdaptiveColors<T> adaptiveAnimatedColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = colorsAnimation,
  }) => AdaptiveColors<T>(
    key: key,
    adapter: adapter,
    builder: (_, t) => animatedColors<T>(t, lerp, animation: animation),
    child: this,
  );

  AdaptiveColors<T> adaptiveMaybeAnimatedColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = colorsAnimation,
  }) {
    if (lerp == null) return adaptiveColors<T>(adapter, key: key);
    return adaptiveAnimatedColors<T>(
      adapter,
      lerp,
      key: key,
      animation: animation,
    );
  }
}
