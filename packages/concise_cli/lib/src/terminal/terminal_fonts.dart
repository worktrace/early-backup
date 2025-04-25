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
