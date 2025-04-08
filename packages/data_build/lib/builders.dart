import 'package:build/build.dart';
import 'package:data_build/annotation.gen.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const RecursiveAnnotationGenerator([CopyGenerator()]),
  generatedExtension: '.data.g.dart',
);
