/// Chain-style encapsulations to simplify Flutter widget coding.
///
/// Those encapsulations in this library are designed to be chain-style,
/// which means that you can use them in a chain, such as:
///
/// ```dart
/// Text('message')
///     .asText()
///     .center()
///     .textDirection(TextDirection.ltr)
///     .mediaAsView(context);
/// ```
///
/// Rather than:
///
/// ```dart
/// MediaQuery(
///   data: MediaQueryData.fromView(View.of(context)),
///   child: Directionality(
///     textDirection: TextDirection.ltr,
///     child: Center(
///       child: Text('message'),
///     ),
///   ),
/// );
/// ```
///
/// Such encapsulation will make the code more readable and maintainable,
/// and here are tips:
///
/// 1. You can easily comment out a single line to cancel a single layer.
/// 2. You can easily move a single line up and down to modify the layers.
/// 3. You can think from inside to outside, from exactly what is required.
///
/// # About Performance
///
/// Such encapsulation will definitely decrease the performance
/// because of the extra layers of functions.
/// But it's worth in most cases because of its readability and maintainability.
/// And thanks to the compiler optimization, it's not a problem in most cases.
/// However, it's not recommended to use such encapsulations
/// in performance sensitive cases such as long loops.
library;

import 'package:flutter/widgets.dart';

extension WrapEnvironment on Widget {
  MediaQuery media(MediaQueryData data, {Key? key}) {
    return MediaQuery(key: key, data: data, child: this);
  }

  MediaQuery mediaAsView(BuildContext context, {Key? key}) {
    return media(key: key, MediaQueryData.fromView(View.of(context)));
  }

  Directionality textDirection(TextDirection direction, {Key? key}) {
    return Directionality(key: key, textDirection: direction, child: this);
  }
}

extension AsText on String {
  Text asText({
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return Text(
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
      this,
    );
  }
}

extension WrapAlign on Widget {
  Center center({Key? key, double? widthFactor, double? heightFactor}) {
    return Center(
      key: key,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }
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
  }) {
    return Column(
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
  }
}

extension ModifyFlex on Flex {
  Flex get center {
    return Flex(
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
}
