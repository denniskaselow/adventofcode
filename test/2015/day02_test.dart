import 'package:adventofcode/adventofcode2015.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
2x3x4
1x1x10
''');

  test('first star', () {
    expect(day02star1(input), equals(58 + 43));
  });
  test('second star', () {
    expect(day02star2(input), equals(34 + 14));
  });
}
