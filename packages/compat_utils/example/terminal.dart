import 'dart:io';

import 'package:compat_utils/compat_utils.dart';

void main(List<String> arguments) => terminalDecorateExample();

/// Attention that some terminal might not support all colors and fonts.
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
}
