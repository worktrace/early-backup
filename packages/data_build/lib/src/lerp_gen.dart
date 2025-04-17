import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:compat_utils/format/string.dart';
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
    final params = element.parameters.map(buildLerpParameter).join(',');
    return '$type _\$lerp\$$type($type a, $type b, double t)=>$type($params);';
  }

  String buildLerpParameter(ParameterElement element) {
    final name = element.name;
    final typeName = element.type.toString();
    if (typeName.endsWith('?')) {
      return '$name: ${typeName.removeSuffix('?')}.lerp(a.$name, b.$name, t)';
    }
    // final typeLibID = element.type.element?.library?.identifier;
    return '$name: $typeName.lerp(a.$name, b.$name, t)!';
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
