import 'package:build/build.dart';
import 'package:data_build/annotation.gen.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const DataBuilder([CopyGenerator()]),
  generatedExtension: '.data.g.dart',
);

class DataBuilder extends RecursiveAnnotationGenerator {
  const DataBuilder(this.generators, {super.throwOnUnresolved});

  @override
  final Iterable<AnnotationGenerator<dynamic>> generators;

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final result = super.generate(library, buildStep);
    if (result == null) return null;
    return "part of '${buildStep.inputId.pathSegments.last}';\n\n$result";
  }
}
