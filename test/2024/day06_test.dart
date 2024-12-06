import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...''');

  test('first star', () {
    expect(day06star1(input), equals(41));
  });
  test('second star', () {
    expect(day06star2(input), equals(6));
  });
}
