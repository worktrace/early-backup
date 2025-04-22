import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:compat_utils/format/string.dart';
import 'package:meta/meta.dart';
import 'package:nest_gen/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp.dart';
import 'lerp_deps.bil.g.dart' as gen;

class LerpGenerator extends AnnotationGenerator<GenerateLerp> {
  const LerpGenerator({this.buildInLerpFunctions = gen.buildInLerpFunctions});

  /// Registered build-in lerp functions.
  final Map<String, TypeID> buildInLerpFunctions;

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
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';
    final params = element.parameters
        .map((parameter) => buildLerpParameter(parameter, typeLibID))
        .join(',');

    return '$type _\$lerp\$$type($type a, $type b, double t) {\n'
        'return $type$constructorName($params);\n'
        '}';
  }

  /// Build a single lerp parameter.
  ///
  /// 1. Apply build in lerp functions ([buildInLerpFunctions])
  /// if there's registered one.
  /// 2. When the type is not defined in `dart:ui` or `package:flutter`, it'll
  /// use the lerp factory constructor directly without nullable assertion.
  /// 3. When lerp `String`, `bool`, `Function` or `Enum`,
  /// it will change at `0.5`.
  @protected
  String buildLerpParameter(ParameterElement element, String currentLibID) {
    final name = element.name;
    final type = element.type;
    final typeName = type.toString();

    if (type.isDartCoreString ||
        type.isDartCoreBool ||
        type.isDartCoreFunction ||
        type.element?.kind == ElementKind.ENUM) {
      return '$name: t < 0.5 ? a.$name : b.$name';
    }

    // Maybe apply build in lerp functions.
    final typeLibID = type.element?.library?.identifier;
    final match = buildInLerpFunctions.match(typeName, typeLibID);
    if (match != null) return '$name: $match(a.$name, b.$name, t)';

    // Use default lerp provided by dart:ui or package:flutter.
    final raw =
        typeLibID == 'dart:ui' ||
        typeLibID?.beforeOrAll('/') == 'package:flutter';
    final nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final className = nullable ? typeName.removeSuffix('?') : typeName;
    final suffix = !nullable && raw ? '!' : '';
    final prefix = element.isNamed ? '$name:' : '';
    return '$prefix$className.lerp(a.$name, b.$name, t)$suffix';
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
    if (element is! FunctionElement) throw const AnnoPosException();

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
