import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'copy.dart';
import 'equals.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([CopyGenerator(), EqualsGenerator()]),
  generatedExtension: '.data.g.dart',
);
