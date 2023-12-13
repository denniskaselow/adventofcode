import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#''';
  const input2 = '''
.......#.####
#..#.##.#####
.#...#..#....
#..#.###.....
.##.#..##.##.
#####.#..####
....######..#''';
  const input3 = '''
.##..##.#
.#.##.#..
#......##
#......##
.#.##.#..
.##..##..
.#.##.#.#''';

  test('first star', () {
    expect(day13star1(input), equals(405));
    expect(day13star1(input2), equals(11));
    expect(day13star1(input3), equals(4));
  });
  test('second star', () {
    expect(day13star2(input), equals(400));
  });
}
