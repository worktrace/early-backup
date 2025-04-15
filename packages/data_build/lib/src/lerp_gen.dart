import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp.dart';

class LerpGenerator extends AnnotationGenerator<GenerateLerp> {
  const LerpGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ConstructorElement) throw const AnnoPosException();

    final type = element.returnType.toString();

    return '$type _\$lerp\$$type($type a, $type b, double t) => $type();';
  }
}

class BuildInLerpGenerator
    extends TopLevelAnnotationGenerator<GenerateBuildInLerp> {
  const BuildInLerpGenerator();

  @override
  String joinResults(
    Iterable<String> results,
    LibraryReader library,
    BuildStep buildStep,
  ) =>
      "import 'package:data_build/annotation.dart';\n\n"
      'const buildInLerp = <String, TypeID>{${results.join(',')}};';

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! FunctionElement) throw const AnnoPosException();

    final name = element.name;
    final type = element.returnType.toString();
    final returnTypeID = element.returnType.element?.library?.identifier;

    final paramType = "${TypeID.fieldTypeName}: '$type'";
    final paramLibID =
        returnTypeID != null
            ? "${TypeID.fieldLibraryIdentifier}: '$returnTypeID'"
            : '';

    return "'$name': TypeID($paramType, $paramLibID)";
  }
}
