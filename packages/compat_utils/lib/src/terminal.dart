class TerminalFont {
  const TerminalFont({required this.code, required this.resetCode})
      : assert((code >= 1 && code <= 9) || code == 21),
        assert(resetCode >= 22 && resetCode <= 29 && resetCode != 26);

  final int code;
  final int resetCode;

  String get decorateCode => '\x1b[${code}m';
  String get resetDecorateCode => '\x1b[${resetCode}m';

  String wrap(String raw) => '$decorateCode$raw$resetDecorateCode';

  String render(String raw) {
    final resetIndex = raw.lastIndexOf(resetDecorateCode);
    if (resetIndex < 0) return '$decorateCode$raw$resetDecorateCode';
    final separateIndex = resetIndex + resetDecorateCode.length;
    return '$decorateCode'
        '${raw.substring(0, separateIndex)}'
        '$decorateCode'
        '${raw.substring(separateIndex)}'
        '$resetDecorateCode';
  }
}

const bold = TerminalFont(code: 1, resetCode: 22);
const faint = TerminalFont(code: 2, resetCode: 22);
const italic = TerminalFont(code: 3, resetCode: 23);
const underline = TerminalFont(code: 4, resetCode: 24);
const blink = TerminalFont(code: 5, resetCode: 25);
const blinkRapid = TerminalFont(code: 6, resetCode: 25);
const negative = TerminalFont(code: 7, resetCode: 27);
const conceal = TerminalFont(code: 8, resetCode: 28);
const strikethrough = TerminalFont(code: 9, resetCode: 29);
const doubleUnderline = TerminalFont(code: 21, resetCode: 24);

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
