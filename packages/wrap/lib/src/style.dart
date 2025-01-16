import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension WrapColors on Widget {
  Widget maybeBackground(Color color) {
    const transparent = Color(0x00000000);
    return color == transparent ? this : background(color);
  }

  Widget maybeForeground(Color? color) {
    return color == null ? this : foreground(color);
  }

  Widget maybeForegroundAs(BuildContext context, Color? color, {Key? key}) {
    return color == null ? this : foregroundAs(context, color, key: key);
  }

  ColoredBox background(Color color, {Key? key}) {
    return ColoredBox(key: key, color: color, child: this);
  }

  Foreground foreground(Color color, {Key? key}) {
    return Foreground(key: key, color: color, child: this);
  }

  // ignore: unnecessary_this readability.
  Widget foregroundAs(BuildContext context, Color color, {Key? key}) => this
      .textForeground(context, color) //
      .iconForeground(context, color, key: key);

  DefaultTextStyle textForeground(
    BuildContext context,
    Color color, {
    Key? key,
  }) {
    return DefaultTextStyle(
      key: key,
      style: DefaultTextStyle.of(context).style.copyWith(color: color),
      child: this,
    );
  }

  IconTheme iconForeground(BuildContext context, Color color, {Key? key}) {
    return IconTheme(
      key: key,
      data: IconTheme.of(context).copyWith(color: color),
      child: this,
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.foregroundAs(context, color);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}
