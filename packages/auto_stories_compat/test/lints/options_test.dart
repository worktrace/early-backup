import 'package:auto_stories_compat/auto_stories_compat.dart';
import 'package:html/dom.dart';
import 'package:test/test.dart';

void main() {
  group('parse sets', () {
    test('normal', () {
      for (final value in Sets.values) {
        final img = Element.tag('img')
          ..attributes['src'] = '/assets/img/tools/linter/${value.imgName}.svg';
        final element = Element.tag('a')
          ..attributes['href'] = '/tools/linter-rules#${value.setName}'
          ..children.add(img);
        expect(Sets.parse(element), value);
      }
    });

    test('spaces', () {
      for (final value in Sets.values) {
        final img = Element.tag('img')
          ..attributes['src'] =
              ' /assets/img/tools/linter/${value.imgName}.svg ';
        final element = Element.tag('a')
          ..attributes['href'] = ' /tools/linter-rules#${value.setName} '
          ..children.add(img);
        expect(Sets.parse(element), value);
      }
    });

    test('more attributes', () {
      for (final value in Sets.values) {
        final img = Element.tag('img')
          ..attributes['src'] =
              ' /assets/img/tools/linter/${value.imgName}.svg '
          ..attributes['another'] = 'example';
        final element = Element.tag('a')
          ..attributes['href'] = ' /tools/linter-rules#${value.setName} '
          ..attributes['alt'] = 'example'
          ..children.add(img);
        expect(Sets.parse(element), value);
      }
    });

    test('more children', () {
      for (final value in Sets.values) {
        final img = Element.tag('img')
          ..attributes['src'] = '/assets/img/tools/linter/${value.imgName}.svg';
        final element = Element.tag('a')
          ..attributes['href'] = '/tools/linter-rules#${value.setName}'
          ..children.add(img)
          ..children.add(Element.tag('img')..attributes['src'] = 'example');
        expect(Sets.parse(element), isNull);
      }
    });

    test('invalid outer element', () {
      for (final value in Sets.values) {
        final img = Element.tag('img')
          ..attributes['src'] = '/assets/img/tools/linter/${value.imgName}.svg';
        final element = Element.tag('span')
          ..attributes['href'] = '/tools/linter-rules#${value.setName}'
          ..children.add(img);
        expect(Sets.parse(element), isNull);
      }
    });

    test('invalid inner element', () {
      for (final value in Sets.values) {
        final img = Element.tag('code')
          ..attributes['src'] = '/assets/img/tools/linter/${value.imgName}.svg';
        final element = Element.tag('a')
          ..attributes['href'] = '/tools/linter-rules#${value.setName}'
          ..children.add(img);
        expect(Sets.parse(element), isNull);
      }
    });
  });
}
