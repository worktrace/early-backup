import 'package:annotate_wrap/annotate_wrap.dart';
import 'package:flutter/widgets.dart';

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

@GenerateWrap(typeNameOverride: 'asColumn')
const Set<Function> wrapColumn = {Column.new};

@GenerateWrap(typeNameOverride: 'asRow')
const Set<Function> wrapRow = {Row.new};

@GenerateWrap(typeNameOverride: 'asFlex')
const Set<Function> wrapFlex = {Flex.new};

@GenerateWrap(typeNameOverride: 'asStack')
const Set<Function> wrapStack = {Stack.new};

@GenerateWrap(typeNameOverride: 'position')
const Set<Function> wrapPositioned = {
  Positioned.new,
  Positioned.fill,
  Positioned.fromRect,
  Positioned.directional,
};

@GenerateWrap(typeNameOverride: 'paint')
const Set<Function> wrapPaint = {CustomPaint.new};

@GenerateWrap(typeNameOverride: 'decorate')
const Set<Function> wrapDecorate = {DecoratedBox.new};

@GenerateWrap(typeNameOverride: 'mouse')
const Set<Function> wrapMouse = {MouseRegion.new};

@GenerateWrap(typeNameOverride: 'gesture')
const Set<Function> wrapGesture = {GestureDetector.new};
