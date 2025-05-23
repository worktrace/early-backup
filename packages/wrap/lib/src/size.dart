import 'package:flutter/widgets.dart';

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

extension RectUtils on Rect {
  RRect get capsule {
    return RRect.fromRectAndRadius(this, Radius.circular(shortestSide / 2));
  }
}
