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

  test('sort dependencies', () {
    final dependencies = <String, Set<String>>{
      'a': {'b', 'c'},
      'b': {'c'},
      'c': {},
    };
    final sorted = sortDependencies(dependencies);
    expect(sorted, ['a', 'b', 'c']);
  });

  test('sort dependencies cycle exception', () {
    final dependencies = <String, Set<String>>{
      'a': {'b'},
      'b': {'c'},
      'c': {'a'},
      'd': {},
    };
    expect(() => sortDependencies(dependencies), throwsException);
  });
}
