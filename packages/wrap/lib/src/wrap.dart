import 'package:flutter/widgets.dart';
import 'package:wrap/annotation.dart';

part 'wrap.wrap.g.dart';

/// All wrapped constructors provided by this library.
@wrap
const Set<Function> wrappedConstructors = {
  Center.new,
  Positioned.new,
  Positioned.fill,
};
