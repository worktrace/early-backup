import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:compat_utils/format/string.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp.dart';
import 'lerp_deps.bil.g.dart';

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
    final params = element.parameters.map(buildLerpParameter).join(',');
    return '$type _\$lerp\$$type($type a, $type b, double t)=>$type($params);';
  }

  String buildLerpParameter(ParameterElement element) {
    final name = element.name;
    final type = element.type;
    final typeName = type.toString();
    final typeLibID = type.element?.library?.identifier;
    // if (typeLibID == null) throw Exception('cannot parse type lib: $element');

    // Maybe apply build in lerp functions.
    final match = buildInLerpFunctions.match(typeName, typeLibID);
    if (match != null) return '$name: $match(a.$name, b.$name, t)';

    // Use default lerp provided by dart:ui or package:flutter.
    final nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final className = nullable ? typeName.removeSuffix('?') : typeName;
    final suffix = nullable ? '' : '!';
    return '$name: $className.lerp(a.$name, b.$name, t)$suffix';
  }
}

/// Generate type annotation for all build in lerp functions
/// for further lerp method generating with methods overrides.
class BuildInLerpGenerator
    extends TopLevelAnnotationGenerator<GenerateBuildInLerp> {
  const BuildInLerpGenerator();

  @override
  String joinResults(
    Iterable<String> results,
    LibraryReader library,
    BuildStep buildStep,
  ) =>
      "import 'package:data_build/annotation_compat.dart';\n\n"
      'const buildInLerpFunctions = <String, TypeID>{${results.join(',')}};';

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
