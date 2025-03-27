import 'package:args/command_runner.dart';

Future<void> main(List<String> arguments) async {
  const name = 'auto_stories';
  const description = 'Auto generated widgets preview for Flutter development.';
  final runner = CommandRunner<void>(name, description);
  await runner.run(arguments);
}
