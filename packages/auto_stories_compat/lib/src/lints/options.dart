import 'package:html/dom.dart';

enum Sets {
  core('lints', 'style-core'),
  recommended('lints', 'style-recommended'),
  flutter('flutter_lints', 'style-flutter');

  const Sets(this.setName, this.imgName);
  final String setName;
  final String imgName;

  /// Parses the sets from the following html structure:
  ///
  /// 1. The element structure must be exactly the same.
  /// 2. It will only check the necessary attributes. The others are ignored.
  /// 3. All fields will be trimmed.
  /// 4. If it doesn't match the structure, it will return `null`.
  ///
  /// ```html
  /// <a href="/tools/linter-rules#set_name">
  ///   <img src="/assets/img/tools/linter/img-name.svg" alt="xxx">
  /// </a>
  /// ```
  static Sets? parse(Element element) {
    // Outer element and href.
    if (element.localName != 'a') return null;
    final href = element.attributes['href']?.trim();

    // Inner element.
    if (element.children.length != 1) return null;
    final img = element.children.first;
    if (img.localName != 'img') return null;
    final src = img.attributes['src']?.trim();

    for (final value in Sets.values) {
      if (href == '/tools/linter-rules#${value.setName}' &&
          src == '/assets/img/tools/linter/${value.imgName}.svg') {
        return value;
      }
    }
    return null;
  }
}
