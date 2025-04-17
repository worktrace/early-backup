import 'package:auto_stories/helpers.dart';
import 'package:data_build/annotation.dart';
import 'package:flutter/widgets.dart';

class Colors extends ColorsBase {
  const Colors.light({
    super.brightness,
    super.foreground = MonoColors.ink,
    super.background = MonoColors.snow,
    this.sidebar = const SidebarColors(background: MonoColors.paper),
  }) : super.light();

  const Colors.dark({
    super.brightness,
    super.foreground = MonoColors.lunar,
    super.background = MonoColors.coal,
    this.sidebar = const SidebarColors(background: MonoColors.night),
  }) : super.dark();

  factory Colors.lerp(Colors a, Colors b, double t) => Colors.light(
    brightness: t < 0.5 ? a.brightness : b.brightness,
    foreground: Color.lerp(a.foreground, b.foreground, t),
    background: lerpColor(a.background, b.background, t),
    sidebar: SidebarColors.lerp(a.sidebar, b.sidebar, t),
  );

  final SidebarColors sidebar;

  static ColorsAdapter<Colors> adapter({ColorsMode mode = ColorsMode.system}) {
    return ColorsAdapter(
      light: const Colors.light(),
      dark: const Colors.dark(),
      mode: mode,
    );
  }
}

abstract class MonoColors {
  static const snow = Color.fromARGB(255, 245, 247, 248);
  static const paper = Color.fromARGB(255, 241, 239, 238);
  static const lunar = Color.fromARGB(255, 189, 188, 187);
  static const gray = Color.fromARGB(255, 139, 139, 139);
  static const ink = Color.fromARGB(255, 49, 51, 52);
  static const night = Color.fromARGB(255, 27, 28, 28);
  static const coal = Color.fromARGB(255, 24, 23, 23);
}
