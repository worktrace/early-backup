import 'package:build/build.dart';
import 'package:nest_gen/builder.dart';
import 'package:source_gen/source_gen.dart';

import '_generators.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([CopyGenerator(), EqualsGenerator()]),
  generatedExtension: '.data.g.dart',
);

Builder copyBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([CopyGenerator()]),
  generatedExtension: '.copy.g.dart',
);

Builder equalsBuilder(BuilderOptions options) => LibraryBuilder(
  const PartDataBuilder([EqualsGenerator()]),
  generatedExtension: '.equals.g.dart',
);
