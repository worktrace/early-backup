import 'package:data_build/builder.dart';
import 'package:path/path.dart';

Future<void> main(List<String> arguments) async {
  final builder = PackageBuilder.resolve();
  await builder.buildFile(join(builder.root.path, 'lib', 'annotation.dart'));
}
