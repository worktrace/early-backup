import 'package:build/build.dart';
import 'package:data_build/annotation_gen.dart';
import 'package:data_build/generator.dart';
import 'package:data_build/src/type_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([CopyGenerator(), LerpGenerator()]),
  generatedExtension: '.data.g.dart',
);

/// Build generated data code in a Dart library file.
/// You may consider [PartDataBuilder] in most cases rather than this one.
class LibDataBuilder extends RecursiveAnnotationGenerator {
  const LibDataBuilder(this.generators, {super.throwOnUnresolved});

  @override
  final Iterable<AnnotationGenerator<dynamic>> generators;
}

/// Build generated data code into a part file,
/// with the `part of` prefix point to its source file.
class PartDataBuilder extends LibDataBuilder {
  const PartDataBuilder(super.generators, {super.throwOnUnresolved});

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final result = super.generate(library, buildStep);
    if (result == null) return null;
    return "part of '${buildStep.inputId.pathSegments.last}';\n\n$result";
  }
}

Builder nameBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([NameGenerator()]),
  generatedExtension: '.name.g.dart',
);

Builder typeBuilder(BuilderOptions options) => LibraryBuilder(
  const LibDataBuilder([PubNameGenerator()]),
  generatedExtension: '.type.g.dart',
);

Builder copyBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([CopyGenerator()]),
  generatedExtension: '.copy.g.dart',
);

Builder lerpBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([LerpGenerator()]),
  generatedExtension: '.lerp.g.dart',
);
