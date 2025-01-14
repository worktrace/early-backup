import 'package:syntax_sugar/syntax_sugar.dart';
import 'package:test/test.dart';

void main() {
  test('camel case split', () {
    expect('ABCAndAnotherABC'.splitCamelCase, ['abc', 'and', 'another', 'abc']);
    expect('abc123abc'.splitCamelCase, ['abc123', 'abc']);
  });
}
