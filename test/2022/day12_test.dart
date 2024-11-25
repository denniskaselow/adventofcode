import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi''');

  test('day 12 first star', () {
    expect(day12star1(input), equals(31));
  });
  test('day 12 second star', () {
    expect(day12star2(input), equals(29));
  });
}
