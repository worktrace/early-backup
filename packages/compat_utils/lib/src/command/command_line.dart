import 'package:args/args.dart';
import 'package:compat_utils/format/string.dart';

abstract class CommandLineApplicable {
  const CommandLineApplicable({
    required this.name,
    required this.help,
    this.abbr,
    this.autoAbbr = true,
  });

  final String name;
  final String help;
  final String? abbr;
  final bool autoAbbr;

  /// Resolved abbreviation as configuration.
  String? get abbreviation {
    return abbr ?? (autoAbbr ? name.firstCharacterLower : null);
  }

  void apply(ArgParser argParser);
}

class CommandLineOption extends CommandLineApplicable {
  const CommandLineOption({
    required super.name,
    required super.help,
    super.abbr,
    super.autoAbbr,
  });

  @override
  void apply(ArgParser argParser) {
    argParser.addOption(name, abbr: abbreviation, help: help);
  }
}
