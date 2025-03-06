import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:workspace_utils/workspace_utils.dart';

Future<void> main(List<String> arguments) async {
  const name = 'workspace_utils';
  const description = 'Dart workspace multiple packages operations.';
  final runner = CommandRunner<void>(name, description)
    ..addCommand(TestCommand())
    ..addCommand(BuildCommand());

  return runner.run(arguments);
}

// Shared root option.
const rootOptionName = 'root';
void addRootOption(ArgParser argParser) {
  argParser.addOption(
    rootOptionName,
    abbr: rootOptionName.substring(0, 1).toLowerCase(),
    help: 'Specify the root directory where workspace root locates.',
  );
}

class TestCommand extends Command<void> {
  TestCommand() : super() {
    addRootOption(argParser);
  }

  @override
  String get name => 'test';

  @override
  String get description => 'Test all packages inside the root workspace.';

  @override
  Future<void> run() async {
    final root = argResults?.option(rootOptionName);
    final package = DartPackage.resolve(path: root ?? '');
    await package.test();
  }
}

class BuildCommand extends Command<void> {
  BuildCommand() : super() {
    addRootOption(argParser);
  }

  @override
  String get name => 'build';

  @override
  String get description => 'Build all packages inside the root workspace.';

  @override
  Future<void> run() async {
    final root = argResults?.option(rootOptionName);
    final package = DartPackage.resolve(path: root ?? '');
    await package.build();
  }
}
