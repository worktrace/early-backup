import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:compat_utils/format/string.dart';
import 'package:compat_utils/package.dart';
import 'package:pub_semver/pub_semver.dart';

import 'command_line.dart';

Future<void> workspaceExecutable(
  List<String> arguments, {
  String executableName = 'workspace',
}) {
  const description = 'Dart workspace multiple packages operations.';
  final runner =
      CommandRunner<void>(executableName, description)
        ..addCommand(TestCommand())
        ..addCommand(BuildCommand())
        ..addCommand(UpdateEnvironmentCommand());

  return runner.run(arguments);
}

const rootOption = CommandLineOption(
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

class UpdateEnvironmentCommand extends Command<void> {
  UpdateEnvironmentCommand() : super() {
    rootOption.apply(argParser);
  }

  @override
  String get name => 'environment';

  @override
  String get description =>
      'Update environment versions of current workspace.\n\n'
      'Example:\n\n    '
      'dart run workspace_utils environment '
      'sdk:^a.b.c '
      'flutter:">=a.b.c <d.0.0"';

  @override
  void run() {
    VersionConstraint? sdk;
    VersionConstraint? flutter;
    for (final arg in argResults?.arguments ?? []) {
      final raw = arg.toString();
      if (sdk == null && raw.startsWith('sdk:')) {
        sdk = VersionConstraint.parse(raw.removePrefix('sdk:'));
      }
      if (flutter == null && raw.startsWith('flutter:')) {
        flutter = VersionConstraint.parse(raw.removePrefix('flutter:'));
      }
    }

    DartPackage.resolve(
      path: argResults?.option(rootOption.name) ?? '',
    ).updateEnvironment(sdk: sdk, flutter: flutter);
  }
}
