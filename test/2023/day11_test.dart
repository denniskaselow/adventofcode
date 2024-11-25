import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....''');

  test('first star', () {
    expect(day11star1(input), equals(374));
  });
  test('second star', () {
    expect(day11star2(input, 10), equals(1030));
    expect(day11star2(input, 100), equals(8410));
  });
}
