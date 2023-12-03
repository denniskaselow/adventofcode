import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = r'''
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..''';

  test('first star', () {
    expect(day03star1(input), equals(4361));
  });
  test('second star', () {
    expect(day03star2(input), equals(467835));
  });
}
