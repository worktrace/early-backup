import 'package:auto_stories/src/utils.dart';

abstract class SizeThemeBase {
  const SizeThemeBase({this.fontSize = const Range(16, min: 12, max: 24)});

  final Range fontSize;
}
