import 'terminal_colors.dart' as c;
import 'terminal_fonts.dart' as f;

/// The terminal code to reset all decorations.
const resetCode = '\x1b[0m';

extension TerminalColors on String {
  // Foreground normal colors.
  String get black => c.black.foreground(this);
  String get red => c.red.foreground(this);
  String get green => c.green.foreground(this);
  String get yellow => c.yellow.foreground(this);
  String get blue => c.blue.foreground(this);
  String get magenta => c.magenta.foreground(this);
  String get cyan => c.cyan.foreground(this);
  String get white => c.white.foreground(this);

  // Foreground highlighted colors.
  String get hiBlack => c.hiBlack.foreground(this);
  String get hiRed => c.hiRed.foreground(this);
  String get hiGreen => c.hiGreen.foreground(this);
  String get hiYellow => c.hiYellow.foreground(this);
  String get hiBlue => c.hiBlue.foreground(this);
  String get hiMagenta => c.hiMagenta.foreground(this);
  String get hiCyan => c.hiCyan.foreground(this);
  String get hiWhite => c.hiWhite.foreground(this);

  // Background normal colors.
  String get bgBlack => c.black.background(this);
  String get bgRed => c.red.background(this);
  String get bgGreen => c.green.background(this);
  String get bgYellow => c.yellow.background(this);
  String get bgBlue => c.blue.background(this);
  String get bgMagenta => c.magenta.background(this);
  String get bgCyan => c.cyan.background(this);
  String get bgWhite => c.white.background(this);

  // Background highlighted colors.
  String get bgHiBlack => c.hiBlack.background(this);
  String get bgHiRed => c.hiRed.background(this);
  String get bgHiGreen => c.hiGreen.background(this);
  String get bgHiYellow => c.hiYellow.background(this);
  String get bgHiBlue => c.hiBlue.background(this);
  String get bgHiMagenta => c.hiMagenta.background(this);
  String get bgHiCyan => c.hiCyan.background(this);
  String get bgHiWhite => c.hiWhite.background(this);

  // Customized colors.
  String code(c.CodeColor color) => color.foreground(this);
  String bgCode(c.CodeColor color) => color.background(this);
  String rgb(c.RGBColor color) => color.foreground(this);
  String bgRgb(c.RGBColor color) => color.background(this);
}

extension TerminalFonts on String {
  String get bold => f.bold.render(this);
  String get faint => f.faint.render(this);
  String get italic => f.italic.render(this);
  String get underline => f.underline.render(this);
  String get blink => f.blink.render(this);
  String get blinkRapid => f.blinkRapid.render(this);
  String get negative => f.negative.render(this);
  String get conceal => f.conceal.render(this);
  String get strikethrough => f.strikethrough.render(this);
  String get doubleUnderline => f.doubleUnderline.render(this);
}

extension TerminalFontsAlias on String {
  String get dim => faint;
  String get blinkFast => blinkRapid;
  String get reverse => negative;
  String get hidden => conceal;
  String get lineThrough => strikethrough;
}
