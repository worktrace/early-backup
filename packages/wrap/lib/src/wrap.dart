import 'package:flutter/widgets.dart';
import 'package:wrap/annotation.dart';

/// All wrapped constructors provided by this library.
@wrap
const Set<Function> wrapConstructors = {
  Center.new,
  MouseRegion.new,
  GestureDetector.new,
};

@GenerateWrap(typeNameOverride: 'position')
const Set<Function> wrapPositioned = {
  Positioned.new,
  Positioned.fill,
  Positioned.fromRect,
  Positioned.directional,
};
