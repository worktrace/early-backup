import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'copy_gen.dart';
import 'equals_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([CopyGenerator(), EqualsGenerator()]),
  generatedExtension: '.data.g.dart',
);
