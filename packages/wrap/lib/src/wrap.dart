import 'package:flutter/widgets.dart';
import 'package:wrap/annotation.dart';

/// All wrapped constructors provided by this library.
@wrap
const Set<Function> wrapConstructors = {
  Align.new,
  Center.new,
  ClipPath.new,
  Focus.new,
  Padding.new,
  Transform.new,
};

@GenerateWrap(typeNameOverride: 'position')
const Set<Function> wrapPositioned = {
  Positioned.new,
  Positioned.fill,
  Positioned.fromRect,
  Positioned.directional,
};

@GenerateWrap(typeNameOverride: 'paint')
const Set<Function> wrapPaint = {CustomPaint.new};

@GenerateWrap(typeNameOverride: 'mouse')
const Set<Function> wrapMouse = {MouseRegion.new};

@GenerateWrap(typeNameOverride: 'gesture')
const Set<Function> wrapGesture = {GestureDetector.new};
