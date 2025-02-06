import 'terminal_decorate.dart' as t;

/// The terminal code to reset all decorations.
const resetCode = '\x1b[0m';

extension TerminalColors on String {
  // Foreground normal colors.
  String get black => t.black.foreground(this);
  String get red => t.red.foreground(this);
  String get green => t.green.foreground(this);
  String get yellow => t.yellow.foreground(this);
  String get blue => t.blue.foreground(this);
  String get magenta => t.magenta.foreground(this);
  String get cyan => t.cyan.foreground(this);
  String get white => t.white.foreground(this);

  // Foreground highlighted colors.
  String get hiBlack => t.hiBlack.foreground(this);
  String get hiRed => t.hiRed.foreground(this);
  String get hiGreen => t.hiGreen.foreground(this);
  String get hiYellow => t.hiYellow.foreground(this);
  String get hiBlue => t.hiBlue.foreground(this);
  String get hiMagenta => t.hiMagenta.foreground(this);
  String get hiCyan => t.hiCyan.foreground(this);
  String get hiWhite => t.hiWhite.foreground(this);

  // Background normal colors.
  String get bgBlack => t.black.background(this);
  String get bgRed => t.red.background(this);
  String get bgGreen => t.green.background(this);
  String get bgYellow => t.yellow.background(this);
  String get bgBlue => t.blue.background(this);
  String get bgMagenta => t.magenta.background(this);
  String get bgCyan => t.cyan.background(this);
  String get bgWhite => t.white.background(this);

  // Background highlighted colors.
  String get bgHiBlack => t.hiBlack.background(this);
  String get bgHiRed => t.hiRed.background(this);
  String get bgHiGreen => t.hiGreen.background(this);
  String get bgHiYellow => t.hiYellow.background(this);
  String get bgHiBlue => t.hiBlue.background(this);
  String get bgHiMagenta => t.hiMagenta.background(this);
  String get bgHiCyan => t.hiCyan.background(this);
  String get bgHiWhite => t.hiWhite.background(this);

  // Customized colors.
  String code(t.CodeColor color) => color.foreground(this);
  String bgCode(t.CodeColor color) => color.background(this);
  String rgb(t.RGBColor color) => color.foreground(this);
  String bgRgb(t.RGBColor color) => color.background(this);
}

extension TerminalFonts on String {
  String get bold => t.bold.render(this);
  String get faint => t.faint.render(this);
  String get italic => t.italic.render(this);
  String get underline => t.underline.render(this);
  String get blink => t.blink.render(this);
  String get blinkRapid => t.blinkRapid.render(this);
  String get negative => t.negative.render(this);
  String get conceal => t.conceal.render(this);
  String get strikethrough => t.strikethrough.render(this);
  String get doubleUnderline => t.doubleUnderline.render(this);
}

extension TerminalFontsAlias on String {
  String get dim => faint;
  String get blinkFast => blinkRapid;
  String get reverse => negative;
  String get hidden => conceal;
  String get lineThrough => strikethrough;
}
