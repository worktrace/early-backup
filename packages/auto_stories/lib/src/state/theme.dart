import 'package:flutter/widgets.dart';

import 'binding.dart';
import 'theme_color.dart';
import 'theme_size.dart';

extension WrapTheme on Widget {
  Widget themeAs<C extends ColorThemeBase, S extends SizeThemeBase>(
    BuildContext context,
    C colors,
    S sizes,
  ) {
    return inherit<S>(sizes).inherit<C>(colors);
  }
}

abstract class ThemeBase {
  const ThemeBase();
}
