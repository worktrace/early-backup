import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:annotate_type/annotate_type.dart';
import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

export 'package:annotate_type/annotate_type.dart';

class TypeIdentifierGenerator
    extends GenerateOnAnnotatedTopLevelVariable<GenerateTypeIdentifier> {
  const TypeIdentifierGenerator();

  @override
  String buildTopLevelVariable(
    TopLevelVariableElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // TODO: implement buildTopLevelVariable
    throw UnimplementedError();
  }
}

extension ParseTypeIdentifier on DartType {
  TypeIdentifier get identifier => TypeIdentifier(
    name: toString(),
    libraryIdentifier: element?.library?.identifier,
  );
}

extension GenerateTypeIdentifierCode on TypeIdentifier {
  String get code =>
      '${TypeIdentifier.className}('
      '  ${TypeIdentifier.nameField}: $name, '
      '  ${TypeIdentifier.libraryIdentifierField}: $libraryIdentifier, '
      ')';
}
