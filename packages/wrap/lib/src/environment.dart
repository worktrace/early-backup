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
  }) => Text(
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
