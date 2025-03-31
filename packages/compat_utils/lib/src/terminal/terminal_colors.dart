mixin TerminalColor {
  static const resetForegroundCode = '\x1b[39m';
  static const resetBackgroundCode = '\x1b[49m';

  String get foregroundCode;
  String get backgroundCode;

  String foreground(String raw) => decorateForeground(raw);
  String background(String raw) => decorateBackground(raw);

  String wrapForeground(String raw) {
    return '$foregroundCode$raw$resetForegroundCode';
  }

  String wrapBackground(String raw) {
    return '$backgroundCode$raw$resetBackgroundCode';
  }

  String decorateForeground(String raw) {
    final resetIndex = raw.lastIndexOf(resetForegroundCode);
    if (resetIndex < 0) return '$foregroundCode$raw$resetForegroundCode';
    final separateIndex = resetIndex + resetForegroundCode.length;
    return '$foregroundCode'
        '${raw.substring(0, separateIndex)}'
        '$foregroundCode'
        '${raw.substring(separateIndex)}'
        '$resetForegroundCode';
  }

  String decorateBackground(String raw) {
    final resetIndex = raw.lastIndexOf(resetBackgroundCode);
    if (resetIndex < 0) return '$backgroundCode$raw$resetBackgroundCode';
    final separateIndex = resetIndex + resetBackgroundCode.length;
    return '$backgroundCode'
        '${raw.substring(0, separateIndex)}'
        '$backgroundCode'
        '${raw.substring(separateIndex)}'
        '$resetBackgroundCode';
  }
}

class BasicColor with TerminalColor {
  const BasicColor(this.code)
    : assert((code >= 30 && code <= 37) || (code >= 90 && code <= 97));

  final int code;

  @override
  String get foregroundCode => '\x1b[${code}m';

  @override
  String get backgroundCode => '\x1b[${code + 10}m';
}

// Normal basic colors.
const black = BasicColor(30);
const red = BasicColor(31);
const green = BasicColor(32);
const yellow = BasicColor(33);
const blue = BasicColor(34);
const magenta = BasicColor(35);
const cyan = BasicColor(36);
const white = BasicColor(37);

// Highlighted basic colors.
const hiBlack = BasicColor(90);
const hiRed = BasicColor(91);
const hiGreen = BasicColor(92);
const hiYellow = BasicColor(93);
const hiBlue = BasicColor(94);
const hiMagenta = BasicColor(95);
const hiCyan = BasicColor(96);
const hiWhite = BasicColor(97);

/// A terminal color defined by a [code] from 0 to 255.
class CodeColor with TerminalColor {
  const CodeColor(this.code) : assert(code >= 0 && code <= 0xff);

  final int code;

  @override
  String get foregroundCode => '\x1b[38;5;${code}m';

  @override
  String get backgroundCode => '\x1b[48;5;${code}m';
}

/// A terminal color defined by [red], [green] and [blue] values.
/// RGB means red, green and blue, all such values are integers from 0 to 255.
class RGBColor with TerminalColor {
  const RGBColor(int value)
    : this.from(
        red: value >> 16,
        green: (value >> 8) & 0xff,
        blue: value & 0xff,
      );

  const RGBColor.from({this.red = 0, this.green = 0, this.blue = 0})
    : assert(red >= 0 && red <= 0xff),
      assert(green >= 0 && green <= 0xff),
      assert(blue >= 0 && blue <= 0xff);

  factory RGBColor.resolve({
    double red = 0,
    double green = 0,
    double blue = 0,
  }) {
    return RGBColor.from(
      red: (red * 0xff).round(),
      green: (green * 0xff).round(),
      blue: (blue * 0xff).round(),
    );
  }

  factory RGBColor.fromHSL({
    double hue = 0,
    double saturation = 0.5,
    double lightness = 0.5,
  }) {
    if (saturation == 0) {
      return RGBColor.resolve(
        red: lightness,
        green: lightness,
        blue: lightness,
      );
    }
    assert(hue >= 0 && hue <= 360);
    assert(saturation >= 0 && saturation <= 1);
    assert(lightness >= 0 && lightness <= 1);

    final chroma = saturation * (1 - (2 * lightness - 1).abs());
    final m = lightness - chroma / 2;
    final prime = hue / 60;
    final section = prime.floor() % 6;
    final x = chroma * (1 - (prime % 2 - 1).abs());

    double r;
    double g;
    double b;

    switch (section) {
      case 0:
        r = chroma;
        g = x;
        b = 0;
      case 1:
        r = x;
        g = chroma;
        b = 0;
      case 2:
        r = 0;
        g = chroma;
        b = x;
      case 3:
        r = 0;
        g = x;
        b = chroma;
      case 4:
        r = x;
        g = 0;
        b = chroma;
      case 5:
        r = chroma;
        g = 0;
        b = x;
      default:
        throw Exception('Invalid hue section');
    }

    return RGBColor.resolve(red: r + m, green: g + m, blue: b + m);
  }

  final int red;
  final int green;
  final int blue;

  String get code {
    String hex(int raw) => raw.toRadixString(16).padLeft(2, '0');
    return '${hex(red)}${hex(green)}${hex(blue)}';
  }

  @override
  String get foregroundCode => '\x1b[38;2;$red;$green;${blue}m';

  @override
  String get backgroundCode => '\x1b[48;2;$red;$green;${blue}m';
}
