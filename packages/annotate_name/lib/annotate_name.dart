const name = GenerateName();
const lib = GenerateLibraryIdentifier();

class GenerateNameBase {
  const GenerateNameBase({this.name});

  final String? name;

  // Calling package:build_name will cause loop dependencies here,
  // so this variable is intended to be managed manually.
  static const nameField = 'name';
}

class GenerateName extends GenerateNameBase {
  const GenerateName({super.name});
}

class GenerateLibraryIdentifier extends GenerateNameBase {
  const GenerateLibraryIdentifier({super.name});
}
