import 'package:flutter/widgets.dart';
import 'package:wrap/annotation.dart';

part 'wrap.wrap.g.dart';

/// All wrapped constructors provided by this library.
@wrap
const Set<Function> wrappedConstructors = {Center.new};

extension WrapPosition on Widget {
  Positioned position({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    key: key,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );

  Positioned positionFill({
    Key? key,
    double? left = 0.0,
    double? top = 0.0,
    double? right = 0.0,
    double? bottom = 0.0,
  }) => Positioned.fill(
    key: key,
    top: top,
    left: left,
    right: right,
    bottom: bottom,
    child: this,
  );
}

extension WrapSize on Widget? {
  SizedBox size({Key? key, double? width, double? height}) {
    return SizedBox(key: key, width: width, height: height, child: this);
  }

  SizedBox sizeAs(Size size, {Key? key}) {
    return SizedBox(
      key: key,
      width: size.width,
      height: size.height,
      child: this,
    );
  }
}
