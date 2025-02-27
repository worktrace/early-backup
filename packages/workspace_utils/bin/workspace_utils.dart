import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:workspace_utils/workspace_utils.dart';

Future<void> main(List<String> arguments) async {
  const name = 'workspace_utils';
  const description = 'Dart workspace multiple packages operations.';
  final runner = CommandRunner<void>(name, description)
    ..addCommand(TestCommand());

  return runner.run(arguments);
}

class TestCommand extends Command<void> {
  @override
  String get name => 'test';

  @override
  String get description => 'Test all packages inside the root workspace.';

  @override
  Future<void> run() async {
    final package = DartPackage.resolve();
    await package.test();
  }
}
