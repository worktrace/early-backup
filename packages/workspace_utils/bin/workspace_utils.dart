import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:compat_utils/command_line.dart';
import 'package:workspace_utils/workspace_utils.dart';

Future<void> main(List<String> arguments) {
  const name = 'workspace_utils';
  const description = 'Dart workspace multiple packages operations.';
  final runner = CommandRunner<void>(name, description)
    ..addCommand(TestCommand())
    ..addCommand(BuildCommand());

  return runner.run(arguments);
}

final rootOption = CommandLineOption.from(
  name: 'root',
  help: 'Specify the root directory where workspace root locates.',
);

class TestCommand extends Command<void> {
  TestCommand() : super() {
    rootOption.apply(argParser);
  }

  @override
  String get name => 'test';

  @override
  String get description => 'Test all packages inside the root workspace.';

  @override
  Future<void> run() async {
    final root = argResults?.option(rootOption.name);
    final package = DartPackage.resolve(path: root ?? '');
    await package.test();
  }
}

class BuildCommand extends Command<void> {
  BuildCommand() : super() {
    rootOption.apply(argParser);
  }

  @override
  String get name => 'build';

  @override
  String get description => 'Build all packages inside the root workspace.';

  @override
  Future<void> run() async {
    final root = argResults?.option(rootOption.name);
    final package = DartPackage.resolve(path: root ?? '');
    await package.build();
  }
}
