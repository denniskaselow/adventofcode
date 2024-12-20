import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############''');

  test('first star', () {
    expect(
      day20star1(input, timeSaved: 1),
      equals(14 + 14 + 2 + 4 + 2 + 3 + 1 + 1 + 1 + 1 + 1),
    );
  });
  test('second star', () {
    expect(
      day20star2(input, timeSaved: 50),
      equals(32 + 31 + 29 + 39 + 25 + 23 + 20 + 19 + 12 + 14 + 12 + 22 + 4 + 3),
    );
  });
}
