import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....''';

  test('first star', () {
    expect(day11star1(input), equals(374));
  });
  test('second star', () {
    expect(day11star2with10(input), equals(1030));
    expect(day11star2with100(input), equals(8410));
  });
}
