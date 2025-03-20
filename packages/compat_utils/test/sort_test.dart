import 'package:compat_utils/compat_utils.dart';
import 'package:test/test.dart';

void main() {
  test('calculate in degrees', () {
    final dependencies = <String, Set<String>>{
      'a': {'b', 'c'},
      'b': {'c'},
      'c': {},
    };
    final inDegrees = calculateInDegrees(dependencies);
    expect(inDegrees, {'a': 0, 'b': 1, 'c': 2});
  });
}
