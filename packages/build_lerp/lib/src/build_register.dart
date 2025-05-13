import 'package:analyzer/dart/element/element.dart';
import 'package:annotate_lerp/register_lerp.dart';
import 'package:build/build.dart';
import 'package:build_type/type_identifier.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder registerLerpBuilder(BuilderOptions options) => LibraryBuilder(
  const RegisterLerpGenerator(),
  generatedExtension: '.register.g.dart',
);

class RegisterLerpGenerator
    extends TopLevelSingleAnnotationGenerator<RegisterLerpGenerator> {
  const RegisterLerpGenerator();

  static const registeredShortcut = 'registeredLerpFunctions';

  @override
  String joinComponents(
    Iterable<String> results,
    LibraryReader library,
    BuildStep buildStep,
  ) {
    return '// ignore: implementation_imports generated.\n'
        "import '${GenerateRegisterLerp.libraryIdentifier}';\n\n"
        'const $registeredShortcut = <String, ${TypeIdentifier.className}>{ '
        '  ${results.join(',')} '
        '};';
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is FunctionElement) return element.returnType.identifier.code;
    throw const AnnotationPositionException<GenerateRegisterLerp>();
  }
}
