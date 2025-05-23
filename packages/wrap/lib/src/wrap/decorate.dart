import 'dart:ui';

import 'package:flutter/widgets.dart';

extension WrapDecoration on Widget {
  DecoratedBox decorate({
    Key? key,
    required Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
  }) => DecoratedBox(
    key: key,
    decoration: decoration,
    position: position,
    child: this,
  );
}

extension WrapFilter on Widget? {
  Opacity opacity(
    double opacity, {
    Key? key,
    bool alwaysIncludeSemantics = false,
  }) => Opacity(
    key: key,
    opacity: opacity,
    alwaysIncludeSemantics: alwaysIncludeSemantics,
    child: this,
  );

  BackdropFilter filter({
    Key? key,
    required ImageFilter filter,
    BlendMode blendMode = BlendMode.srcOver,
    bool enabled = true,
  }) => BackdropFilter(
    key: key,
    filter: filter,
    blendMode: blendMode,
    enabled: enabled,
    child: this,
  );

  BackdropFilter blur(
    double sigma, {
    Key? key,
    TileMode tileMode = TileMode.clamp,
    BlendMode blendMode = BlendMode.srcOver,
    bool enabled = true,
  }) => filter(
    key: key,
    filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: tileMode),
    blendMode: blendMode,
    enabled: enabled,
  );
}
