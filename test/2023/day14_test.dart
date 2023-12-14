import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....''';

  test('first star', () {
    expect(day14star1(input), equals(136));
  });
  test('second star', () {
    expect(day14star2(input), equals(64));
  });
}
