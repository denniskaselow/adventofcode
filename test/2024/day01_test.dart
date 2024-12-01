import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
3   4
4   3
2   5
1   3
3   9
3   3''');

  test('first star', () {
    expect(day01star1(input), equals(11));
  });
  test('second star', () {
    expect(day01star2(input), equals(31));
  });
}
