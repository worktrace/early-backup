import 'package:args/args.dart';
import 'package:compat_utils/compat_utils.dart';

class CommandLineOption {
  const CommandLineOption({
    required this.name,
    required this.help,
    this.abbr,
  });

  factory CommandLineOption.from({
    required String name,
    required String help,
    String? abbr,
    bool autoAbbr = true,
  }) {
    return CommandLineOption(
      name: name,
      help: help,
      abbr: abbr ?? (autoAbbr ? name.firstCharacterLower : null),
    );
  }

  final String name;
  final String help;
  final String? abbr;

  void apply(ArgParser argParser) {
    argParser.addOption(
      name,
      abbr: abbr,
      help: help,
    );
  }
}
