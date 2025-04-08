import 'package:data_build/builder.dart';

Future<void> main(List<String> arguments) async {
  final builder = PackageBuilder.resolve(builders: [parseBuilder]);
  await builder.build();
}
