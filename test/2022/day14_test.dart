import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9''';

  test('day 14 first star', () {
    expect(day14star1(input), equals(24));
  });
  test('day 14 second star', () {
    expect(day14star2(input), equals(93));
  });
}
