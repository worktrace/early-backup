import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder wrapBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const PartAnnotationsBuilder([WrapGenerator()]),
    generatedExtension: '.wrap.g.dart',
  );
}

class WrapGenerator extends GenerateOnAnnotatedConstructor<GenerateWrap>
    with GenerateConstructorSet {
  const WrapGenerator();

  @override
  String buildConstructor(ConstructorElement element) {
    final rawClass = element.returnType.element;

    final name = element.name;
    final type = rawClass.name;
    // final constructorName = element.isDefaultConstructor ? '' : '.$name';
    final extensionSuffix = element.isDefaultConstructor ? '' : '\$$name';
    return 'extension Wrap$type$extensionSuffix on Widget {\n'
        '}';
  }
}
