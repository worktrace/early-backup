import 'package:auto_stories/annotation.dart';
import 'package:auto_stories/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'colors.data.g.dart';
part 'colors.lerp.g.dart';

class Colors extends ColorsBase {
  @copy
  @lerp
  const Colors.light({
    super.brightness,
    super.foreground = BuildInColors.ink,
    super.background = BuildInColors.snow,
    this.sidebar = const SidebarColors(background: BuildInColors.paper),
  }) : super.light();

  const Colors.dark({
    super.brightness,
    super.foreground = BuildInColors.lunar,
    super.background = BuildInColors.coal,
    this.sidebar = const SidebarColors(background: BuildInColors.night),
  }) : super.dark();

  factory Colors.lerp(Colors a, Colors b, double t) => _$lerp$Colors(a, b, t);

  final SidebarColors sidebar;

  static ColorsAdapter<Colors> adapter({ColorsMode mode = ColorsMode.system}) {
    return ColorsAdapter(
      light: const Colors.light(),
      dark: const Colors.dark(),
      mode: mode,
    );
  }
}

abstract class BuildInColors {
  static const snow = Color.fromARGB(255, 245, 247, 248);
  static const paper = Color.fromARGB(255, 241, 239, 238);
  static const lunar = Color.fromARGB(255, 189, 188, 187);
  static const gray = Color.fromARGB(255, 139, 139, 139);
  static const ink = Color.fromARGB(255, 49, 51, 52);
  static const night = Color.fromARGB(255, 27, 28, 28);
  static const coal = Color.fromARGB(255, 24, 23, 23);
}
