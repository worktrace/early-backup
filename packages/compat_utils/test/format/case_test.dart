import 'package:compat_utils/format/case.dart';
import 'package:test/test.dart';

void main() {
  test('camel case split', () {
    expect('ABCAndAnotherABC'.splitCamelCase, ['abc', 'and', 'another', 'abc']);
    expect('abc123abc'.splitCamelCase, ['abc123', 'abc']);
  });
}
