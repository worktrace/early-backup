import 'package:flutter/widgets.dart';

extension WrapAlign on Widget {
  Center center({Key? key, double? widthFactor, double? heightFactor}) {
    return Center(
      key: key,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

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

extension WrapDisplay on List<Widget> {
  Column asColumn({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    double spacing = 0.0,
  }) => Column(
    key: key,
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: crossAxisAlignment,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    spacing: spacing,
    children: this,
  );

  Stack asStack({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) => Stack(
    key: key,
    alignment: alignment,
    textDirection: textDirection,
    fit: fit,
    clipBehavior: clipBehavior,
    children: this,
  );
}

extension WrapConstraint on Widget? {
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
