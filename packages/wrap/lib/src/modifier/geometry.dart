import 'package:flutter/widgets.dart';

extension ModifyFlex on Flex {
  Flex get center => Flex(
    key: key,
    direction: direction,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: crossAxisAlignment,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    clipBehavior: clipBehavior,
    spacing: spacing,
    children: children,
  );
}
