import 'dart:io';

import 'package:compat_utils/terminal.dart';

void main(List<String> arguments) => terminalDecorateExample();

/// Attention that some terminal might not support all colors.
/// It's recommended to use the build-in terminal of VSCode.
void terminalDecorateExample() {
  // Terminal font styles.
  final fonts = [
    'bold'.bold,
    'faint/dim'.faint,
    'italic'.italic,
    'underline'.underline,
    '${'blink'.blink} (may not work)',
    '${'blinkRapid'.blinkRapid} (may not work)',
    'negative/reverse'.negative,
    '${'conceal/invisible'.conceal} (conceal/invisible)',
    'strikethrough'.strikethrough,
    '${'doubleUnderline'.doubleUnderline} (may not work)',
  ].join('\n');
  stdout.writeln('$fonts\n');

  // Terminal colors.
  const l = 10;
  final colors = [
    '${demoColor(red, 'red')} ${demoColor(hiRed, 'hi red', l)}',
    '${demoColor(green, 'green')} ${demoColor(hiGreen, 'hi green', l)}',
    '${demoColor(yellow, 'yellow')} ${demoColor(hiYellow, 'hi yellow', l)}',
    '${demoColor(blue, 'blue')} ${demoColor(hiBlue, 'hi blue', l)}',
    '${demoColor(magenta, 'magenta')} ${demoColor(hiMagenta, 'hi magenta', l)}',
    '${demoColor(cyan, 'cyan')} ${demoColor(hiCyan, 'hi cyan', l)}',
    '${demoColor(white, 'white')} ${demoColor(hiWhite, 'hi white', l)}',
    '${demoColor(black, 'black')} ${demoColor(hiBlack, 'hi black', l)}',
  ].join('\n');
  stdout
    ..writeln('$colors\n')
    ..writeln(codeColorMatrix((color, raw) => color.foreground(raw)))
    ..writeln(codeColorMatrix((color, raw) => color.background(raw)))
    ..writeln(rgbColorMatrix((color, raw) => color.foreground(raw)))
    ..writeln(rgbColorMatrix((color, raw) => color.background(raw)))
    ..writeln(colorBlockMatrix());
}

/// Demonstrate a single ANSI color code.
String demoColor(TerminalColor color, String name, [int len = 7]) {
  assert(len > 0);
  return [
    color.foreground(name.padRight(len)),
    color.background(name.padRight(len)),
  ].join(' ');
}

/// Color matrix if ANSI color code.
String codeColorMatrix(
  String Function(TerminalColor color, String raw) colorizer, [
  int width = 16,
]) {
  assert(width > 0);
  final buffer = StringBuffer();
  for (var row = 0; row < (0x100 / width).ceil(); row++) {
    for (var column = 0; column < width; column++) {
      final value = row * width + column;
      if (value > 0xff) continue;
      final content = value.toString().padLeft(3);
      buffer.write(colorizer(CodeColor(value), ' $content '));
    }
    buffer.writeln();
  }
  return buffer.toString();
}

/// Color matrix of RGB hex code.
String rgbColorMatrix(
  String Function(TerminalColor color, String raw) colorizer, {
  int width = 10,
  int height = 16,
  double lightness = 0.5,
}) {
  assert(width > 0 && height > 0);
  assert(lightness >= 0 && lightness <= 1);
  final buffer = StringBuffer();
  for (var row = 0; row < height; row++) {
    final saturation = row / (height - 1);
    for (var column = 0; column < width; column++) {
      final hue = column / width * 360;
      final color = RGBColor.fromHSL(
        hue: hue,
        saturation: saturation,
        lightness: lightness,
      );
      buffer.write(colorizer(color, ' ${color.code} '));
    }
    buffer.writeln();
  }
  return buffer.toString();
}

/// Color matrix of background block.
String colorBlockMatrix({
  int width = 80,
  int height = 16,
  double lightness = 0.5,
}) {
  assert(width > 0 && height > 0);
  assert(lightness >= 0 && lightness <= 1);
  final buffer = StringBuffer();
  for (var row = 0; row < height; row++) {
    final saturation = row / (height - 1);
    for (var column = 0; column < width; column++) {
      final hue = column / width * 360;
      final color = RGBColor.fromHSL(
        hue: hue,
        saturation: saturation,
        lightness: lightness,
      );
      buffer.write(color.background(' '));
    }
    buffer.writeln();
  }
  return buffer.toString();
}
