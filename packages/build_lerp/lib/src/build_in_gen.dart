import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_lerp/src/build_in_anno.dart';
import 'package:nest_gen/nest_gen.dart';
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
        "import '${TypeID.classLibrary}';\n\n"
        'const buildInLerpFunctions = <String, TypeID>{${results.join(',')}};';
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! FunctionElement)
      throw const AnnotationPositionException<GenerateBuildInLerp>();

    final name = element.name;
    final type = element.returnType.toString();
    final returnTypeID = element.returnType.element?.library?.identifier;

    final paramType = "${TypeID.fieldTypeName}: '$type'";
    final paramLibID = returnTypeID != null
        ? "${TypeID.fieldLibraryIdentifier}: '$returnTypeID'"
        : '';

    return "'$name': TypeID($paramType, $paramLibID)";
  }
}
