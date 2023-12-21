import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........''';

  test('first star', () {
    expect(day21star1(input, 1), equals(2));
    expect(day21star1(input, 2), equals(4));
    expect(day21star1(input, 6), equals(16));
  });
  test('second star', () {
    expect(day21star2(input, 500), equals(167004));
  });
}
