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
    return [
      decorateCode,
      raw.substring(0, separateIndex),
      decorateCode,
      raw.substring(separateIndex),
      resetDecorateCode,
    ].join();
  }
}
