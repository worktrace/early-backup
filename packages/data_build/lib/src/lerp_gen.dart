import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:compat_utils/format/string.dart';
import 'package:data_build/generator.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp.dart';
import 'lerp_deps.bil.g.dart';

class LerpGenerator extends AnnotationGenerator<GenerateLerp> {
  const LerpGenerator();

  /// Registered build-in lerp functions.
  @protected
  Map<String, TypeID> get buildIns => buildInLerpFunctions;

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ConstructorElement) throw const AnnoPosException();
    final classType = element.returnType;
    final typeLibID = classType.element.library.identifier;
    final type = classType.toString();
    final params = element.parameters
        .map((parameter) => buildLerpParameter(parameter, typeLibID))
        .join(',');

    return '$type _\$lerp\$$type($type a, $type b, double t)=>$type($params);';
  }

  /// Build a single lerp parameter.
  ///
  /// 1. Apply build in lerp functions ([buildIns]) if there's registered one.
  /// 2. When the type is not defined in `dart:ui` or `package:flutter`,
  /// it will the lerp factory constructor use directly
  /// wither nullable assertion.
  /// 3. When the type is defined in `dart:ui` or `package:flutter`,
  /// it will use the default lerp factory constructor with nullable assertion.
  @protected
  String buildLerpParameter(ParameterElement element, String currentLibID) {
    final name = element.name;
    final type = element.type;
    final typeName = type.toString();
    final typeLibID = type.element?.library?.identifier;

    // Maybe apply build in lerp functions.
    final match = buildIns.match(typeName, typeLibID);
    if (match != null) return '$name: $match(a.$name, b.$name, t)';

    // Use default lerp provided by dart:ui or package:flutter.
    final raw =
        typeLibID == 'dart:ui' ||
        typeLibID?.beforeOrAll('/') == 'package:flutter';
    final nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final className = nullable ? typeName.removeSuffix('?') : typeName;
    final suffix = !nullable && raw ? '!' : '';
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
