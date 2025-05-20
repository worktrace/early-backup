import 'package:analyzer/dart/constant/value.dart';
import 'package:annotate_type/annotate_type.dart';
import 'package:build/build.dart';
import 'package:compat_utils/case.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

export 'package:annotate_type/annotate_type.dart';

export 'parse.dart';

Builder typeIdentifierBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const LibraryAnnotationBuilder(
      [TypeIdentifierGenerator()],
      imports: [TypeIdentifier.classLibraryIdentifier],
    ),
    generatedExtension: '.type.g.dart',
  );
}

class TypeIdentifierGenerator
    extends GenerateOnAnnotation<GenerateTypeIdentifier>
    with GenerateTopLevelVariable, GenerateSet {
  const TypeIdentifierGenerator();

  @override
  String? buildSetItem(
    DartObject element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final type = element.toTypeValue()?.element;
    if (type == null) return null;

    final name = type.displayName;
    final lib = type.library?.identifier;
    final libParam = lib != null
        ? "${TypeIdentifier.fieldLibraryIdentifier}: '$lib',\n"
        : '';

    return 'const type${name.pascalCase} = ${TypeIdentifier.className}(\n'
        "  ${TypeIdentifier.fieldName}: '$name',\n"
        '  $libParam'
        ');';
  }
}

extension GenerateTypeIdentifierCode on TypeIdentifier {
  String get code =>
      '${TypeIdentifier.className}('
      '  ${TypeIdentifier.fieldName}: $name, '
      '  ${TypeIdentifier.fieldLibraryIdentifier}: $libraryIdentifier, '
      ')';
}
