import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';
import 'package:smooth_ui/themes.dart';
import 'package:wrap/wrap.dart';

extension WrapColors on Widget {
  Widget colorsAs<T extends ColorsBase>(BuildContext context, T colors) {
    return inherit(colors)
        .inherit(colors.brightness)
        .background(colors.background)
        .maybeForegroundAs(context, colors.foreground);
  }

  ColorsApply<T> colors<T extends ColorsBase>(T colors, {Key? key}) {
    return ColorsApply(key: key, colors: colors, child: this);
  }
}

class ColorsApply<T extends ColorsBase> extends StatelessWidget {
  const ColorsApply({super.key, required this.colors, required this.child});

  final T colors;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.colorsAs(context, colors);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('colors', colors));
  }
}

abstract class ColorsBase extends AreaColors {
  const ColorsBase.light({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.light,
  });

  const ColorsBase.dark({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.dark,
  });

  final Brightness brightness;
}
