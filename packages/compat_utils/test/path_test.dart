import 'package:compat_utils/path.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  test('subname', () {
    expect('example'.withSubname('g'), 'example.g');
    expect('example.dart'.withSubname('g'), 'example.g.dart');
    expect(
      'path${separator}example.dart'.withSubname('g'),
      'path${separator}example.g.dart',
    );
  });

  test('replace extension', () {
    expect('example'.replaceExtension('dart'), 'example.dart');
    expect('example.part'.replaceExtension('dart'), 'example.dart');
    expect(
      'path${separator}example.part'.replaceExtension('dart'),
      'path${separator}example.dart',
    );
  });
}
