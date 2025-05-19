/// This private library is designed to avoid unnecessary generated file export,
/// or the generated file at package lib root may be called.
library;

import 'package:build_type/annotation.dart';
import 'package:flutter/widgets.dart';

part '_child_type.type.g.dart';

@typeIdentifier
// ignore: unused_element generating entries.
const _childTypes = <Type>{Widget};

const TypeIdentifier widgetType = _$typeWidget;
