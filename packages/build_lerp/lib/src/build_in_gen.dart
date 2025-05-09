import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_lerp/src/build_in_anno.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:nest_gen/utils.dart';
import 'package:source_gen/source_gen.dart';

Builder buildInLerpBuilder(BuilderOptions options) => LibraryBuilder(
  const BuildInLerpGenerator(),
  generatedExtension: '.bil.g.dart',
);

class BuildInLerpGenerator
    extends TopLevelSingleAnnotationGenerator<GenerateBuildInLerp> {
  const BuildInLerpGenerator();

  @override
  String joinComponents(
    Iterable<String> results,
    LibraryReader library,
    BuildStep buildStep,
  ) {
    return '// ignore: implementation_imports generated.\n'
        "import '${ConvertTypeIdentifier.libraryIdentifier}';\n\n"
        'const buildInLerpFunctions = <String, TypeIdentifier>{ '
        '${results.join(',')} '
        '};';
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! FunctionElement) {
      throw const AnnotationPositionException<GenerateBuildInLerp>();
    }
    final (name, lib) = element.returnType.identifier;
    return "'${element.name}': ('$name', '$lib')";
  }
}
