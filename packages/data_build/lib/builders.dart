import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  RecursiveAnnotationGenerator([copyGenerator]),
  generatedExtension: '.data.g.dart',
);
