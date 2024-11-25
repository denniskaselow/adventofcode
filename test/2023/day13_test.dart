import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
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
#....#..#''');
  const input2 = Input('''
.......#.####
#..#.##.#####
.#...#..#....
#..#.###.....
.##.#..##.##.
#####.#..####
....######..#''');
  const input3 = Input('''
.##..##.#
.#.##.#..
#......##
#......##
.#.##.#..
.##..##..
.#.##.#.#''');

  test('first star', () {
    expect(day13star1(input), equals(405));
    expect(day13star1(input2), equals(11));
    expect(day13star1(input3), equals(4));
  });
  test('second star', () {
    expect(day13star2(input), equals(400));
  });
}
