import 'package:adventofcode/adventofcode2015.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
^>v<''');

  test('first star', () {
    expect(day03star1(input), equals(4));
  });
  test('second star', () {
    expect(day03star2(input), equals(3));
  });
}
