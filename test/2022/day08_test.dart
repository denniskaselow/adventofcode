import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
30373
25512
65332
33549
35390''');

  test('day 8 first star', () {
    expect(day8star1(input), equals(21));
  });
  test('day 8 second star', () {
    expect(day8star2(input), equals(8));
  });
}
